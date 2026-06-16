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
}

class DocumentBridgeException implements Exception {
  const DocumentBridgeException(this.message);

  final String message;

  @override
  String toString() => message;
}
