import 'package:shared_preferences/shared_preferences.dart';

import '../models/shopping_list.dart';
import 'document_bridge.dart';

class ShoppingRepository {
  ShoppingRepository({
    required SharedPreferencesWithCache preferences,
    DocumentBridge documentBridge = const DocumentBridge(),
  }) : _preferences = preferences,
       _documentBridge = documentBridge;

  static const _listJsonKey = 'shopping_list_json';
  static const _documentUriKey = 'linked_document_uri';
  static const _documentNameKey = 'linked_document_name';
  static const _languageKey = 'language_code';

  static const preferenceKeys = {
    _listJsonKey,
    _documentUriKey,
    _documentNameKey,
    _languageKey,
  };

  final SharedPreferencesWithCache _preferences;
  final DocumentBridge _documentBridge;

  String? get linkedDocumentUri => _preferences.getString(_documentUriKey);

  String? get linkedDocumentName => _preferences.getString(_documentNameKey);

  String? get languageCode => _preferences.getString(_languageKey);

  Future<void> setLanguageCode(String? code) async {
    if (code == null) {
      await _preferences.remove(_languageKey);
    } else {
      await _preferences.setString(_languageKey, code);
    }
  }

  ShoppingListData loadLocalList() {
    final saved = _preferences.getString(_listJsonKey);
    if (saved == null || saved.trim().isEmpty) {
      return ShoppingListData.initial();
    }
    try {
      return ShoppingListData.fromJsonText(saved);
    } on FormatException {
      return ShoppingListData.initial();
    }
  }

  Future<void> saveLocalList(ShoppingListData list) {
    return _preferences.setString(_listJsonKey, list.toJsonText());
  }

  Future<ShoppingListData?> pickAndLoadDocument() async {
    final document = await _documentBridge.pickJsonDocument();
    if (document == null) {
      return null;
    }
    final list = ShoppingListData.fromJsonText(document.content);
    await _preferences.setString(_documentUriKey, document.uri);
    await _preferences.setString(_documentNameKey, document.name);
    await saveLocalList(list);
    return list;
  }

  Future<ShoppingListData> reloadLinkedDocument() async {
    final uri = linkedDocumentUri;
    if (uri == null || uri.isEmpty) {
      throw const DocumentBridgeException('No linked document available.');
    }
    final document = await _documentBridge.readDocument(uri);
    final list = ShoppingListData.fromJsonText(document.content);
    await _preferences.setString(_documentNameKey, document.name);
    await saveLocalList(list);
    return list;
  }

  Future<void> saveAndSync(ShoppingListData list) async {
    await saveLocalList(list);
    final uri = linkedDocumentUri;
    if (uri == null || uri.isEmpty) {
      return;
    }
    await _documentBridge.writeDocument(uri: uri, content: list.toJsonText());
  }

  Future<void> unlinkDocument() async {
    await _preferences.remove(_documentUriKey);
    await _preferences.remove(_documentNameKey);
  }
}
