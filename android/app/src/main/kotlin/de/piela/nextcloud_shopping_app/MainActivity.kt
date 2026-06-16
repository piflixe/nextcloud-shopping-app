package de.piela.nextcloud_shopping_app

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.provider.OpenableColumns
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.OutputStreamWriter

class MainActivity : FlutterActivity() {
    private var pendingDocumentPick: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            DOCUMENT_CHANNEL,
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "pickJsonDocument" -> pickJsonDocument(result)
                "readDocument" -> readDocument(call, result)
                "writeDocument" -> writeDocument(call, result)
                else -> result.notImplemented()
            }
        }
    }

    private fun pickJsonDocument(result: MethodChannel.Result) {
        if (pendingDocumentPick != null) {
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

    private fun writeDocument(call: MethodCall, result: MethodChannel.Result) {
        val uriText = call.argument<String>("uri")
        val content = call.argument<String>("content")
        if (uriText.isNullOrBlank() || content == null) {
            result.error("MISSING_ARGUMENTS", "Missing document URI or content.", null)
            return
        }

        runCatching {
            val uri = Uri.parse(uriText)
            contentResolver.openOutputStream(uri, "wt").use { stream ->
                if (stream == null) {
                    error("Unable to open output stream.")
                }
                OutputStreamWriter(stream, Charsets.UTF_8).use { writer ->
                    writer.write(content)
                }
            }
        }.onSuccess {
            result.success(null)
        }.onFailure {
            result.error("WRITE_FAILED", it.message, null)
        }
    }

    @Deprecated("Deprecated in Java")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode != REQUEST_PICK_JSON) {
            return
        }

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
            contentResolver.takePersistableUriPermission(uri, flags)
            documentResult(uri)
        }.onSuccess(result::success).onFailure {
            result.error("PICK_FAILED", it.message, null)
        }
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

    private fun displayName(uri: Uri): String {
        contentResolver.query(uri, null, null, null, null).use { cursor ->
            if (cursor != null && cursor.moveToFirst()) {
                val index = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
                if (index >= 0) {
                    return cursor.getString(index)
                }
            }
        }
        return "shopping-list.json"
    }

    companion object {
        private const val DOCUMENT_CHANNEL =
            "de.piela.nextcloud_shopping_app/document_bridge"
        private const val REQUEST_PICK_JSON = 4101
    }
}
