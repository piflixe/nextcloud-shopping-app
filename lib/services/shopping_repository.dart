import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/shopping_list.dart';
import '../models/shopping_list_store.dart';
import 'document_bridge.dart';

class ShoppingRepository {
  ShoppingRepository({
    required SharedPreferencesWithCache preferences,
    DocumentBridge documentBridge = const DocumentBridge(),
    String? localDirectoryPath,
  }) : _preferences = preferences,
       _documentBridge = documentBridge,
       _localDirectoryPathOverride = localDirectoryPath;

  static const _legacyListJsonKey = 'shopping_list_json';
  static const _legacyDocumentUriKey = 'linked_document_uri';
  static const _legacyDocumentNameKey = 'linked_document_name';
  static const _manifestKey = 'shopping_lists_manifest';
  static const _languageKey = 'language_code';

  static const preferenceKeys = {
    _legacyListJsonKey,
    _legacyDocumentUriKey,
    _legacyDocumentNameKey,
    _manifestKey,
    _languageKey,
  };

  final SharedPreferencesWithCache _preferences;
  final DocumentBridge _documentBridge;
  final String? _localDirectoryPathOverride;

  late Directory _localDirectory;
  late ShoppingListManifest _manifest;
  bool _initialized = false;

  List<ShoppingListProfile> get lists => List.unmodifiable(_manifest.lists);

  ShoppingListProfile get activeProfile => _manifest.activeProfile;

  String? get languageCode => _preferences.getString(_languageKey);

  Future<void> initialize() async {
    final path =
        _localDirectoryPathOverride ??
        (_documentBridge.isSupported
            ? await _documentBridge.localListsDirectoryPath()
            : Directory('.shopping_lists').absolute.path);
    _localDirectory = Directory(path);
    if (!await _localDirectory.exists()) {
      await _localDirectory.create(recursive: true);
    }

    _manifest = await _loadOrCreateManifest();
    await _saveManifest();
    _initialized = true;
  }

  Future<void> setLanguageCode(String? code) async {
    if (code == null) {
      await _preferences.remove(_languageKey);
    } else {
      await _preferences.setString(_languageKey, code);
    }
  }

  ShoppingListData loadActiveList() {
    _requireInitialized();
    return _readLocalList(activeProfile);
  }

  Future<ShoppingListData> switchList(String id) async {
    _requireInitialized();
    if (!_manifest.lists.any((profile) => profile.id == id)) {
      throw const FormatException('Unknown shopping list.');
    }
    _manifest = _manifest.copyWith(activeListId: id);
    await _saveManifest();
    return _readLocalList(activeProfile);
  }

  Future<ShoppingListData> createList(String name) async {
    _requireInitialized();
    final cleanName = _cleanListName(name);
    _ensureUniqueName(cleanName);

    final profile = ShoppingListProfile(
      id: createShoppingListProfileId(cleanName),
      name: cleanName,
      localFileName: _uniqueLocalFileName(jsonFileNameForList(cleanName)),
    );
    final list = ShoppingListData.empty();
    await _writeLocalList(profile, list);

    _manifest = _manifest.copyWith(
      activeListId: profile.id,
      lists: [..._manifest.lists, profile],
    );
    await _saveManifest();
    return list;
  }

  Future<ShoppingListData> renameActiveList(String name) async {
    _requireInitialized();
    final cleanName = _cleanListName(name);
    final current = activeProfile;
    _ensureUniqueName(cleanName, exceptId: current.id);

    final nextFileName = _uniqueLocalFileName(
      jsonFileNameForList(cleanName),
      except: current.localFileName,
    );
    final list = _readLocalList(current);
    if (nextFileName != current.localFileName) {
      final oldFile = _localFile(current.localFileName);
      final nextFile = _localFile(nextFileName);
      if (await oldFile.exists()) {
        await oldFile.rename(nextFile.path);
      } else {
        await _writeText(nextFile, list.toJsonText());
      }
    }

    var updated = current.copyWith(
      name: cleanName,
      localFileName: nextFileName,
    );

    final folderUri = current.linkedFolderUri;
    if (folderUri != null && folderUri.isNotEmpty) {
      final linked = await _documentBridge.ensureJsonDocumentInFolder(
        folderUri: folderUri,
        fileName: jsonFileNameForList(cleanName),
        content: list.toJsonText(),
        readExisting: false,
      );
      updated = updated.copyWith(
        linkedFolderUri: linked.folderUri,
        linkedFolderName: linked.folderName,
        linkedDocumentUri: linked.documentUri,
        linkedDocumentName: linked.documentName,
      );
    } else if (current.linkedDocumentUri != null) {
      final renamed = await _documentBridge.renameDocument(
        uri: current.linkedDocumentUri!,
        displayName: jsonFileNameForList(cleanName),
      );
      updated = updated.copyWith(
        linkedDocumentUri: renamed.uri,
        linkedDocumentName: renamed.name,
      );
    }

    _manifest = _replaceProfile(updated);
    await _saveManifest();
    return list;
  }

  Future<ShoppingListData?> linkActiveListToFolder() async {
    _requireInitialized();
    final current = activeProfile;
    final localList = _readLocalList(current);
    final linked = await _documentBridge.pickFolderForJson(
      fileName: jsonFileNameForList(current.name),
      content: localList.toJsonText(),
    );
    if (linked == null) {
      return null;
    }

    final loaded = ShoppingListData.fromJsonText(linked.content);
    await _writeLocalList(current, loaded);
    final updated = current.copyWith(
      linkedFolderUri: linked.folderUri,
      linkedFolderName: linked.folderName,
      linkedDocumentUri: linked.documentUri,
      linkedDocumentName: linked.documentName,
    );
    _manifest = _replaceProfile(updated);
    await _saveManifest();
    return loaded;
  }

  Future<ShoppingListData> reloadActiveLinkedList() async {
    _requireInitialized();
    final documentUri = activeProfile.linkedDocumentUri;
    if (documentUri == null || documentUri.isEmpty) {
      throw const DocumentBridgeException('No linked document available.');
    }

    final document = await _documentBridge.readDocument(documentUri);
    final list = ShoppingListData.fromJsonText(document.content);
    await _writeLocalList(activeProfile, list);
    _manifest = _replaceProfile(
      activeProfile.copyWith(
        linkedDocumentUri: document.uri,
        linkedDocumentName: document.name,
      ),
    );
    await _saveManifest();
    return list;
  }

  Future<void> saveAndSync(ShoppingListData list) async {
    _requireInitialized();
    final profile = activeProfile;
    await _writeLocalList(profile, list);
    final uri = profile.linkedDocumentUri;
    if (uri == null || uri.isEmpty) {
      return;
    }
    await _documentBridge.writeDocument(uri: uri, content: list.toJsonText());
  }

  Future<void> unlinkActiveListStorage() async {
    _requireInitialized();
    _manifest = _replaceProfile(
      activeProfile.copyWith(clearLinkedStorage: true),
    );
    await _saveManifest();
  }

  Future<ShoppingListManifest> _loadOrCreateManifest() async {
    final saved = _preferences.getString(_manifestKey);
    if (saved != null && saved.trim().isNotEmpty) {
      try {
        final manifest = ShoppingListManifest.fromJsonText(saved);
        await _ensureLocalFiles(manifest);
        return manifest;
      } on FormatException {
        // Fall through to a fresh manifest.
      }
    }

    return _createInitialManifest();
  }

  Future<ShoppingListManifest> _createInitialManifest() async {
    final legacyJson = _preferences.getString(_legacyListJsonKey);
    final legacyName = _listNameFromDocumentName(
      _preferences.getString(_legacyDocumentNameKey),
    );
    final name = legacyName ?? 'Einkaufsliste';
    final profile = ShoppingListProfile(
      id: createShoppingListProfileId(name),
      name: name,
      localFileName: _uniqueLocalFileName(jsonFileNameForList(name)),
      linkedDocumentUri: _preferences.getString(_legacyDocumentUriKey),
      linkedDocumentName: _preferences.getString(_legacyDocumentNameKey),
    );
    final list = _parseListOrInitial(legacyJson);
    await _writeLocalList(profile, list);
    return ShoppingListManifest(
      schemaVersion: 1,
      activeListId: profile.id,
      lists: [profile],
    );
  }

  Future<void> _ensureLocalFiles(ShoppingListManifest manifest) async {
    for (final profile in manifest.lists) {
      final file = _localFile(profile.localFileName);
      if (!await file.exists()) {
        await _writeLocalList(profile, ShoppingListData.empty());
      }
    }
  }

  ShoppingListData _readLocalList(ShoppingListProfile profile) {
    final file = _localFile(profile.localFileName);
    if (!file.existsSync()) {
      return ShoppingListData.empty();
    }
    try {
      return ShoppingListData.fromJsonText(file.readAsStringSync());
    } on FormatException {
      return ShoppingListData.empty();
    }
  }

  Future<void> _writeLocalList(
    ShoppingListProfile profile,
    ShoppingListData list,
  ) {
    return _writeText(_localFile(profile.localFileName), list.toJsonText());
  }

  Future<void> _writeText(File file, String content) async {
    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true);
    }
    await file.writeAsString(content);
  }

  ShoppingListManifest _replaceProfile(ShoppingListProfile profile) {
    return _manifest.copyWith(
      lists: [
        for (final candidate in _manifest.lists)
          candidate.id == profile.id ? profile : candidate,
      ],
    );
  }

  Future<void> _saveManifest() {
    return _preferences.setString(_manifestKey, _manifest.toJsonText());
  }

  File _localFile(String fileName) {
    return File('${_localDirectory.path}${Platform.pathSeparator}$fileName');
  }

  String _uniqueLocalFileName(String preferred, {String? except}) {
    if (except != null && preferred.toLowerCase() == except.toLowerCase()) {
      return preferred;
    }

    final existing = _manifestOrEmpty().lists
        .map((profile) => profile.localFileName.toLowerCase())
        .where((fileName) => fileName != except?.toLowerCase())
        .toSet();

    if (!existing.contains(preferred.toLowerCase()) &&
        !_localFile(preferred).existsSync()) {
      return preferred;
    }

    final base = preferred.replaceAll(
      RegExp(r'\.json$', caseSensitive: false),
      '',
    );
    for (var i = 2; i < 1000; i++) {
      final candidate = '$base-$i.json';
      if (!existing.contains(candidate.toLowerCase()) &&
          !_localFile(candidate).existsSync()) {
        return candidate;
      }
    }
    throw const FileSystemException('Unable to create a unique list file.');
  }

  ShoppingListManifest _manifestOrEmpty() {
    if (!_initialized) {
      return const ShoppingListManifest(
        schemaVersion: 1,
        activeListId: '',
        lists: [],
      );
    }
    return _manifest;
  }

  void _ensureUniqueName(String name, {String? exceptId}) {
    final normalized = name.toLowerCase();
    final exists = _manifest.lists.any(
      (profile) =>
          profile.id != exceptId && profile.name.toLowerCase() == normalized,
    );
    if (exists) {
      throw const FormatException('A list with this name already exists.');
    }
  }

  void _requireInitialized() {
    if (!_initialized) {
      throw StateError('ShoppingRepository.initialize() was not called.');
    }
  }
}

String _cleanListName(String name) {
  final cleanName = name.trim().replaceAll(RegExp(r'\s+'), ' ');
  if (cleanName.isEmpty) {
    throw const FormatException('List name must not be empty.');
  }
  return cleanName;
}

ShoppingListData _parseListOrInitial(String? json) {
  if (json == null || json.trim().isEmpty) {
    return ShoppingListData.initial();
  }
  try {
    return ShoppingListData.fromJsonText(json);
  } on FormatException {
    return ShoppingListData.initial();
  }
}

String? _listNameFromDocumentName(String? documentName) {
  final name = documentName?.trim();
  if (name == null || name.isEmpty) {
    return null;
  }
  return name.replaceAll(RegExp(r'\.json$', caseSensitive: false), '');
}
