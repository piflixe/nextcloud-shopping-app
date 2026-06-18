package de.piela.nextcloud_shopping_app

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.DocumentsContract
import android.provider.OpenableColumns
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.OutputStreamWriter

class MainActivity : FlutterActivity() {
    private var pendingDocumentPick: MethodChannel.Result? = null
    private var pendingFolderPick: PendingFolderPick? = null
    private var pendingCreateDocument: PendingCreateDocument? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            DOCUMENT_CHANNEL,
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "pickJsonDocument" -> pickJsonDocument(result)
                "pickFolderForJson" -> pickFolderForJson(call, result)
                "ensureJsonDocumentInFolder" -> ensureJsonDocumentInFolder(call, result)
                "readDocument" -> readDocument(call, result)
                "renameDocument" -> renameDocument(call, result)
                "writeDocument" -> writeDocument(call, result)
                "localListsDirectoryPath" -> localListsDirectoryPath(result)
                else -> result.notImplemented()
            }
        }
    }

    private fun pickJsonDocument(result: MethodChannel.Result) {
        if (hasPendingPicker()) {
            result.error("PICKER_BUSY", "A document picker is already open.", null)
            return
        }

        pendingDocumentPick = result
        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
            addCategory(Intent.CATEGORY_OPENABLE)
            type = "*/*"
            putExtra(
                Intent.EXTRA_MIME_TYPES,
                arrayOf("application/json", "text/json", "text/plain"),
            )
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION)
            addFlags(Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION)
        }
        startActivityForResult(intent, REQUEST_PICK_JSON)
    }

    private fun pickFolderForJson(call: MethodCall, result: MethodChannel.Result) {
        if (hasPendingPicker()) {
            result.error("PICKER_BUSY", "A document picker is already open.", null)
            return
        }

        val fileName = call.argument<String>("fileName") ?: DEFAULT_JSON_NAME
        val content = call.argument<String>("content") ?: ""
        val readExisting = call.argument<Boolean>("readExisting") ?: true
        pendingFolderPick = PendingFolderPick(result, fileName, content, readExisting)

        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE).apply {
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION)
            addFlags(Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION)
            addFlags(Intent.FLAG_GRANT_PREFIX_URI_PERMISSION)
        }
        startActivityForResult(intent, REQUEST_PICK_FOLDER)
    }

    private fun ensureJsonDocumentInFolder(call: MethodCall, result: MethodChannel.Result) {
        val folderUriText = call.argument<String>("folderUri")
        val fileName = call.argument<String>("fileName") ?: DEFAULT_JSON_NAME
        val content = call.argument<String>("content") ?: ""
        val readExisting = call.argument<Boolean>("readExisting") ?: true
        if (folderUriText.isNullOrBlank()) {
            result.error("MISSING_URI", "Missing folder URI.", null)
            return
        }

        runCatching {
            folderDocumentResult(Uri.parse(folderUriText), fileName, content, readExisting)
        }.onSuccess(result::success).onFailure {
            result.error("FOLDER_WRITE_FAILED", it.message, null)
        }
    }

    private fun readDocument(call: MethodCall, result: MethodChannel.Result) {
        val uriText = call.argument<String>("uri")
        if (uriText.isNullOrBlank()) {
            result.error("MISSING_URI", "Missing document URI.", null)
            return
        }

        runCatching {
            val uri = Uri.parse(uriText)
            documentResult(uri)
        }.onSuccess(result::success).onFailure {
            result.error("READ_FAILED", it.message, null)
        }
    }

    private fun renameDocument(call: MethodCall, result: MethodChannel.Result) {
        val uriText = call.argument<String>("uri")
        val displayName = call.argument<String>("displayName")
        if (uriText.isNullOrBlank() || displayName.isNullOrBlank()) {
            result.error("MISSING_ARGUMENTS", "Missing document URI or display name.", null)
            return
        }

        runCatching {
            val uri = Uri.parse(uriText)
            val renamed = DocumentsContract.renameDocument(contentResolver, uri, displayName)
                ?: uri
            documentResult(renamed)
        }.onSuccess(result::success).onFailure {
            result.error("RENAME_FAILED", it.message, null)
        }
    }

    private fun writeDocument(call: MethodCall, result: MethodChannel.Result) {
        val uriText = call.argument<String>("uri")
        val content = call.argument<String>("content")
        if (uriText.isNullOrBlank() || content == null) {
            result.error("MISSING_ARGUMENTS", "Missing document URI or content.", null)
            return
        }

        runCatching {
            writeText(Uri.parse(uriText), content)
        }.onSuccess {
            result.success(null)
        }.onFailure {
            result.error("WRITE_FAILED", it.message, null)
        }
    }

    private fun localListsDirectoryPath(result: MethodChannel.Result) {
        runCatching {
            val directory = File(filesDir, "shopping_lists")
            if (!directory.exists()) {
                directory.mkdirs()
            }
            directory.absolutePath
        }.onSuccess(result::success).onFailure {
            result.error("LOCAL_DIRECTORY_FAILED", it.message, null)
        }
    }

    @Deprecated("Deprecated in Java")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        when (requestCode) {
            REQUEST_PICK_JSON -> completeDocumentPick(resultCode, data)
            REQUEST_PICK_FOLDER -> completeFolderPick(resultCode, data)
            REQUEST_CREATE_JSON -> completeCreateDocument(resultCode, data)
        }
    }

    private fun completeDocumentPick(resultCode: Int, data: Intent?) {
        val result = pendingDocumentPick ?: return
        pendingDocumentPick = null

        if (resultCode != Activity.RESULT_OK) {
            result.success(null)
            return
        }

        val uri = data?.data
        if (uri == null) {
            result.error("NO_DOCUMENT", "No document was selected.", null)
            return
        }

        val flags = data.flags and (
            Intent.FLAG_GRANT_READ_URI_PERMISSION or
                Intent.FLAG_GRANT_WRITE_URI_PERMISSION
            )
        runCatching {
            if (flags != 0) {
                contentResolver.takePersistableUriPermission(uri, flags)
            }
            documentResult(uri)
        }.onSuccess(result::success).onFailure {
            result.error("PICK_FAILED", it.message, null)
        }
    }

    private fun completeFolderPick(resultCode: Int, data: Intent?) {
        val pending = pendingFolderPick ?: return
        pendingFolderPick = null

        if (resultCode != Activity.RESULT_OK) {
            pending.result.success(null)
            return
        }

        val uri = data?.data
        if (uri == null) {
            pending.result.error("NO_FOLDER", "No folder was selected.", null)
            return
        }

        val flags = data.flags and (
            Intent.FLAG_GRANT_READ_URI_PERMISSION or
                Intent.FLAG_GRANT_WRITE_URI_PERMISSION
            )
        runCatching {
            if (flags != 0) {
                contentResolver.takePersistableUriPermission(uri, flags)
            }
            val existing = findChildDocument(uri, pending.fileName)
            if (existing != null) {
                folderDocumentResultFromDocument(
                    treeUri = uri,
                    documentUri = existing,
                    content = pending.content,
                    created = false,
                    readExisting = pending.readExisting,
                )
            } else {
                val created = createChildDocument(uri, pending.fileName)
                folderDocumentResultFromDocument(
                    treeUri = uri,
                    documentUri = created,
                    content = pending.content,
                    created = true,
                    readExisting = pending.readExisting,
                )
            }
        }.onSuccess(pending.result::success).onFailure {
            launchCreateDocumentFallback(uri, pending, it)
            return
        }
    }

    private fun completeCreateDocument(resultCode: Int, data: Intent?) {
        val pending = pendingCreateDocument ?: return
        pendingCreateDocument = null

        if (resultCode != Activity.RESULT_OK) {
            pending.result.success(null)
            return
        }

        val returnedUri = data?.data
        if (returnedUri == null) {
            pending.result.error("NO_DOCUMENT", "No document was created.", null)
            return
        }

        val flags = data.flags and (
            Intent.FLAG_GRANT_READ_URI_PERMISSION or
                Intent.FLAG_GRANT_WRITE_URI_PERMISSION
            )
        runCatching {
            if (flags != 0) {
                runCatching {
                    contentResolver.takePersistableUriPermission(returnedUri, flags)
                }
            }
            val documentUri = createdDocumentUriFromResult(pending, returnedUri)
            writeText(documentUri, pending.content)
            mapOf(
                "folderUri" to pending.treeUri.toString(),
                "folderName" to folderDisplayName(pending.treeUri),
                "documentUri" to documentUri.toString(),
                "documentName" to displayName(documentUri),
                "content" to pending.content,
                "created" to true,
            )
        }.onSuccess(pending.result::success).onFailure {
            pending.result.error("CREATE_DOCUMENT_FAILED", it.message, null)
        }
    }

    private fun createdDocumentUriFromResult(
        pending: PendingCreateDocument,
        returnedUri: Uri,
    ): Uri {
        if (!isTreeUri(returnedUri)) {
            return returnedUri
        }

        return findChildDocument(pending.treeUri, pending.fileName)
            ?: findChildDocument(returnedUri, pending.fileName)
            ?: error("Created document ${pending.fileName} could not be found.")
    }

    private fun folderPickFailed(pending: PendingFolderPick, error: Throwable) {
        pendingCreateDocument = null
        pending.result.error("FOLDER_PICK_FAILED", error.message, null)
    }

    private fun launchCreateDocumentFallback(
        treeUri: Uri,
        pending: PendingFolderPick,
        cause: Throwable,
    ) {
        if (pendingCreateDocument != null) {
            folderPickFailed(pending, cause)
            return
        }

        pendingCreateDocument = PendingCreateDocument(
            result = pending.result,
            treeUri = treeUri,
            fileName = pending.fileName,
            content = pending.content,
        )

        val intent = Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
            addCategory(Intent.CATEGORY_OPENABLE)
            type = JSON_MIME_TYPE
            putExtra(Intent.EXTRA_TITLE, pending.fileName)
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION)
            addFlags(Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                putExtra(DocumentsContract.EXTRA_INITIAL_URI, treeUri)
            }
        }

        runCatching {
            startActivityForResult(intent, REQUEST_CREATE_JSON)
        }.onFailure {
            folderPickFailed(pending, cause)
        }
    }

    private fun folderDocumentResult(
        treeUri: Uri,
        requestedFileName: String,
        content: String,
        readExisting: Boolean,
    ): Map<String, Any> {
        val fileName = requestedFileName.ifBlank { DEFAULT_JSON_NAME }
        var created = false
        val documentUri = findChildDocument(treeUri, fileName) ?: run {
            created = true
            createChildDocument(treeUri, fileName)
        }

        return folderDocumentResultFromDocument(
            treeUri = treeUri,
            documentUri = documentUri,
            content = content,
            created = created,
            readExisting = readExisting,
        )
    }

    private fun folderDocumentResultFromDocument(
        treeUri: Uri,
        documentUri: Uri,
        content: String,
        created: Boolean,
        readExisting: Boolean,
    ): Map<String, Any> {
        val resultContent = if (created || !readExisting) {
            writeText(documentUri, content)
            content
        } else {
            readText(documentUri)
        }

        return mapOf(
            "folderUri" to treeUri.toString(),
            "folderName" to folderDisplayName(treeUri),
            "documentUri" to documentUri.toString(),
            "documentName" to displayName(documentUri),
            "content" to resultContent,
            "created" to created,
        )
    }

    private fun createChildDocument(treeUri: Uri, fileName: String): Uri {
        val parentUri = DocumentsContract.buildDocumentUriUsingTree(
            treeUri,
            DocumentsContract.getTreeDocumentId(treeUri),
        )
        return DocumentsContract.createDocument(
            contentResolver,
            parentUri,
            JSON_MIME_TYPE,
            fileName,
        ) ?: error("Unable to create document $fileName.")
    }

    private fun findChildDocument(treeUri: Uri, fileName: String): Uri? {
        val childrenUri = DocumentsContract.buildChildDocumentsUriUsingTree(
            treeUri,
            DocumentsContract.getTreeDocumentId(treeUri),
        )
        val projection = arrayOf(
            DocumentsContract.Document.COLUMN_DOCUMENT_ID,
            DocumentsContract.Document.COLUMN_DISPLAY_NAME,
        )
        contentResolver.query(childrenUri, projection, null, null, null).use { cursor ->
            if (cursor == null) {
                return null
            }
            val idIndex = cursor.getColumnIndex(DocumentsContract.Document.COLUMN_DOCUMENT_ID)
            val nameIndex = cursor.getColumnIndex(DocumentsContract.Document.COLUMN_DISPLAY_NAME)
            if (idIndex < 0 || nameIndex < 0) {
                return null
            }
            while (cursor.moveToNext()) {
                val name = cursor.getString(nameIndex)
                if (name != null && name.equals(fileName, ignoreCase = true)) {
                    val documentId = cursor.getString(idIndex)
                    return DocumentsContract.buildDocumentUriUsingTree(treeUri, documentId)
                }
            }
        }
        return null
    }

    private fun documentResult(uri: Uri): Map<String, String> {
        return mapOf(
            "uri" to uri.toString(),
            "name" to displayName(uri),
            "content" to readText(uri),
        )
    }

    private fun readText(uri: Uri): String {
        contentResolver.openInputStream(uri).use { stream ->
            if (stream == null) {
                error("Unable to open input stream.")
            }
            return stream.bufferedReader(Charsets.UTF_8).use { reader ->
                reader.readText()
            }
        }
    }

    private fun writeText(uri: Uri, content: String) {
        contentResolver.openOutputStream(uri, "wt").use { stream ->
            if (stream == null) {
                error("Unable to open output stream.")
            }
            OutputStreamWriter(stream, Charsets.UTF_8).use { writer ->
                writer.write(content)
            }
        }
    }

    private fun displayName(uri: Uri): String {
        return queryDisplayName(uri) ?: DEFAULT_JSON_NAME
    }

    private fun folderDisplayName(uri: Uri): String {
        val documentUri = runCatching {
            DocumentsContract.buildDocumentUriUsingTree(
                uri,
                DocumentsContract.getTreeDocumentId(uri),
            )
        }.getOrNull()

        return documentUri?.let(::queryDisplayName)
            ?: queryDisplayName(uri)
            ?: runCatching {
            val treeDocumentId = DocumentsContract.getTreeDocumentId(uri)
            treeDocumentId.substringAfterLast('/').substringAfterLast(':')
                .ifBlank { treeDocumentId }
        }.getOrDefault("Folder")
    }

    private fun queryDisplayName(uri: Uri): String? {
        return runCatching {
            contentResolver.query(uri, null, null, null, null).use { cursor ->
                if (cursor != null && cursor.moveToFirst()) {
                    val index = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
                    if (index >= 0) {
                        cursor.getString(index)
                    } else {
                        null
                    }
                } else {
                    null
                }
            }
        }.getOrNull()
    }

    private fun isTreeUri(uri: Uri): Boolean {
        return uri.pathSegments.firstOrNull() == "tree"
    }

    private data class PendingFolderPick(
        val result: MethodChannel.Result,
        val fileName: String,
        val content: String,
        val readExisting: Boolean,
    )

    private data class PendingCreateDocument(
        val result: MethodChannel.Result,
        val treeUri: Uri,
        val fileName: String,
        val content: String,
    )

    private fun hasPendingPicker(): Boolean {
        return pendingDocumentPick != null ||
            pendingFolderPick != null ||
            pendingCreateDocument != null
    }

    companion object {
        private const val DOCUMENT_CHANNEL =
            "de.piela.nextcloud_shopping_app/document_bridge"
        private const val DEFAULT_JSON_NAME = "shopping-list.json"
        private const val JSON_MIME_TYPE = "text/plain"
        private const val REQUEST_PICK_JSON = 4101
        private const val REQUEST_PICK_FOLDER = 4102
        private const val REQUEST_CREATE_JSON = 4103
    }
}
