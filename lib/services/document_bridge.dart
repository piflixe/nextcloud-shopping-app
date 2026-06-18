import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PickedDocument {
  const PickedDocument({
    required this.uri,
    required this.name,
    required this.content,
  });

  final String uri;
  final String name;
  final String content;

  factory PickedDocument.fromMap(Map<Object?, Object?> map) {
    return PickedDocument(
      uri: map['uri']?.toString() ?? '',
      name: map['name']?.toString() ?? 'shopping-list.json',
      content: map['content']?.toString() ?? '',
    );
  }
}

class LinkedFolderDocument {
  const LinkedFolderDocument({
    required this.folderUri,
    required this.folderName,
    required this.documentUri,
    required this.documentName,
    required this.content,
    required this.created,
  });

  final String folderUri;
  final String folderName;
  final String documentUri;
  final String documentName;
  final String content;
  final bool created;

  factory LinkedFolderDocument.fromMap(Map<Object?, Object?> map) {
    return LinkedFolderDocument(
      folderUri: map['folderUri']?.toString() ?? '',
      folderName: map['folderName']?.toString() ?? '',
      documentUri: map['documentUri']?.toString() ?? '',
      documentName: map['documentName']?.toString() ?? 'shopping-list.json',
      content: map['content']?.toString() ?? '',
      created: map['created'] == true,
    );
  }
}

class DocumentBridge {
  const DocumentBridge();

  static const MethodChannel _channel = MethodChannel(
    'de.piela.nextcloud_shopping_app/document_bridge',
  );

  bool get isSupported => defaultTargetPlatform == TargetPlatform.android;

  Future<PickedDocument?> pickJsonDocument() async {
    if (!isSupported) {
      throw const DocumentBridgeException(
        'Document picker is currently only available on Android.',
      );
    }
    final result = await _channel.invokeMethod<Object?>('pickJsonDocument');
    if (result == null) {
      return null;
    }
    if (result case final Map<Object?, Object?> map) {
      return PickedDocument.fromMap(map);
    }
    throw const DocumentBridgeException('Unexpected document picker result.');
  }

  Future<LinkedFolderDocument?> pickFolderForJson({
    required String fileName,
    required String content,
  }) async {
    if (!isSupported) {
      throw const DocumentBridgeException(
        'Folder picker is currently only available on Android.',
      );
    }
    final result = await _channel.invokeMethod<Object?>('pickFolderForJson', {
      'fileName': fileName,
      'content': content,
      'readExisting': true,
    });
    if (result == null) {
      return null;
    }
    if (result case final Map<Object?, Object?> map) {
      return LinkedFolderDocument.fromMap(map);
    }
    throw const DocumentBridgeException('Unexpected folder picker result.');
  }

  Future<LinkedFolderDocument> ensureJsonDocumentInFolder({
    required String folderUri,
    required String fileName,
    required String content,
    bool readExisting = true,
  }) async {
    if (!isSupported) {
      throw const DocumentBridgeException(
        'Folder writing is currently only available on Android.',
      );
    }
    final result = await _channel
        .invokeMethod<Object?>('ensureJsonDocumentInFolder', {
          'folderUri': folderUri,
          'fileName': fileName,
          'content': content,
          'readExisting': readExisting,
        });
    if (result case final Map<Object?, Object?> map) {
      return LinkedFolderDocument.fromMap(map);
    }
    throw const DocumentBridgeException('Unexpected folder write result.');
  }

  Future<PickedDocument> readDocument(String uri) async {
    if (!isSupported) {
      throw const DocumentBridgeException(
        'Document reading is currently only available on Android.',
      );
    }
    final result = await _channel.invokeMethod<Object?>('readDocument', {
      'uri': uri,
    });
    if (result case final Map<Object?, Object?> map) {
      return PickedDocument.fromMap(map);
    }
    throw const DocumentBridgeException('Unexpected document read result.');
  }

  Future<PickedDocument> renameDocument({
    required String uri,
    required String displayName,
  }) async {
    if (!isSupported) {
      throw const DocumentBridgeException(
        'Document renaming is currently only available on Android.',
      );
    }
    final result = await _channel.invokeMethod<Object?>('renameDocument', {
      'uri': uri,
      'displayName': displayName,
    });
    if (result case final Map<Object?, Object?> map) {
      return PickedDocument.fromMap(map);
    }
    throw const DocumentBridgeException('Unexpected document rename result.');
  }

  Future<void> writeDocument({
    required String uri,
    required String content,
  }) async {
    if (!isSupported) {
      throw const DocumentBridgeException(
        'Document writing is currently only available on Android.',
      );
    }
    await _channel.invokeMethod<void>('writeDocument', {
      'uri': uri,
      'content': content,
    });
  }

  Future<String> localListsDirectoryPath() async {
    if (!isSupported) {
      throw const DocumentBridgeException(
        'Local app storage lookup is currently only available on Android.',
      );
    }
    final result = await _channel.invokeMethod<Object?>(
      'localListsDirectoryPath',
    );
    if (result is String && result.isNotEmpty) {
      return result;
    }
    throw const DocumentBridgeException('Unexpected local directory result.');
  }
}

class DocumentBridgeException implements Exception {
  const DocumentBridgeException(this.message);

  final String message;

  @override
  String toString() => message;
}
