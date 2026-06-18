import 'dart:convert';

class ShoppingListProfile {
  const ShoppingListProfile({
    required this.id,
    required this.name,
    required this.localFileName,
    this.linkedFolderUri,
    this.linkedFolderName,
    this.linkedDocumentUri,
    this.linkedDocumentName,
  });

  final String id;
  final String name;
  final String localFileName;
  final String? linkedFolderUri;
  final String? linkedFolderName;
  final String? linkedDocumentUri;
  final String? linkedDocumentName;

  bool get hasLinkedStorage =>
      linkedDocumentUri != null && linkedDocumentUri!.isNotEmpty;

  String get displayStorageName {
    final folderName = linkedFolderName;
    final documentName = linkedDocumentName;
    if (folderName != null && folderName.isNotEmpty) {
      if (documentName != null && documentName.isNotEmpty) {
        return '$folderName / $documentName';
      }
      return folderName;
    }
    if (documentName != null && documentName.isNotEmpty) {
      return documentName;
    }
    return localFileName;
  }

  factory ShoppingListProfile.fromJson(Map<String, Object?> json) {
    final name = (json['name'] ?? 'Shopping list').toString().trim();
    return ShoppingListProfile(
      id: (json['id'] ?? _createListId(name)).toString(),
      name: name.isEmpty ? 'Shopping list' : name,
      localFileName: (json['localFileName'] ?? jsonFileNameForList(name))
          .toString(),
      linkedFolderUri: _optionalString(json['linkedFolderUri']),
      linkedFolderName: _optionalString(json['linkedFolderName']),
      linkedDocumentUri: _optionalString(json['linkedDocumentUri']),
      linkedDocumentName: _optionalString(json['linkedDocumentName']),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'localFileName': localFileName,
      if (linkedFolderUri != null) 'linkedFolderUri': linkedFolderUri,
      if (linkedFolderName != null) 'linkedFolderName': linkedFolderName,
      if (linkedDocumentUri != null) 'linkedDocumentUri': linkedDocumentUri,
      if (linkedDocumentName != null) 'linkedDocumentName': linkedDocumentName,
    };
  }

  ShoppingListProfile copyWith({
    String? id,
    String? name,
    String? localFileName,
    String? linkedFolderUri,
    String? linkedFolderName,
    String? linkedDocumentUri,
    String? linkedDocumentName,
    bool clearLinkedStorage = false,
  }) {
    return ShoppingListProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      localFileName: localFileName ?? this.localFileName,
      linkedFolderUri: clearLinkedStorage
          ? null
          : linkedFolderUri ?? this.linkedFolderUri,
      linkedFolderName: clearLinkedStorage
          ? null
          : linkedFolderName ?? this.linkedFolderName,
      linkedDocumentUri: clearLinkedStorage
          ? null
          : linkedDocumentUri ?? this.linkedDocumentUri,
      linkedDocumentName: clearLinkedStorage
          ? null
          : linkedDocumentName ?? this.linkedDocumentName,
    );
  }
}

class ShoppingListManifest {
  const ShoppingListManifest({
    required this.schemaVersion,
    required this.activeListId,
    required this.lists,
  });

  final int schemaVersion;
  final String activeListId;
  final List<ShoppingListProfile> lists;

  ShoppingListProfile get activeProfile {
    return lists.firstWhere(
      (profile) => profile.id == activeListId,
      orElse: () => lists.first,
    );
  }

  factory ShoppingListManifest.fromJsonText(String source) {
    final decoded = jsonDecode(source);
    if (decoded is! Map<String, Object?>) {
      throw const FormatException('Shopping list manifest must be an object.');
    }

    final rawLists = decoded['lists'];
    final lists = [
      if (rawLists is List)
        for (final raw in rawLists)
          if (raw is Map<Object?, Object?>)
            ShoppingListProfile.fromJson(
              raw.map((key, value) => MapEntry(key.toString(), value)),
            ),
    ];

    if (lists.isEmpty) {
      throw const FormatException('Shopping list manifest needs a list.');
    }

    final activeListId = (decoded['activeListId'] ?? lists.first.id).toString();
    return ShoppingListManifest(
      schemaVersion: _intFromJson(decoded['schemaVersion'], 1),
      activeListId: lists.any((profile) => profile.id == activeListId)
          ? activeListId
          : lists.first.id,
      lists: lists,
    );
  }

  String toJsonText() {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert({
      'schemaVersion': schemaVersion,
      'activeListId': activeListId,
      'lists': lists.map((profile) => profile.toJson()).toList(),
    });
  }

  ShoppingListManifest copyWith({
    int? schemaVersion,
    String? activeListId,
    List<ShoppingListProfile>? lists,
  }) {
    return ShoppingListManifest(
      schemaVersion: schemaVersion ?? this.schemaVersion,
      activeListId: activeListId ?? this.activeListId,
      lists: lists ?? this.lists,
    );
  }
}

String jsonFileNameForList(String name) {
  final withoutExtension = name.trim().replaceAll(RegExp(r'\.json$'), '');
  final cleaned = withoutExtension
      .replaceAll(RegExp(r'[\\/:*?"<>|]+'), '-')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  final baseName = cleaned.isEmpty ? 'shopping-list' : cleaned;
  return '$baseName.json';
}

String createShoppingListProfileId(String name) => _createListId(name);

String _createListId(String name) {
  final cleaned = name
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
  final suffix = DateTime.now().microsecondsSinceEpoch;
  return '${cleaned.isEmpty ? 'list' : cleaned}-$suffix';
}

String? _optionalString(Object? value) {
  final text = value?.toString().trim();
  if (text == null || text.isEmpty) {
    return null;
  }
  return text;
}

int _intFromJson(Object? value, int fallback) {
  if (value is int) {
    return value;
  }
  return int.tryParse(value?.toString() ?? '') ?? fallback;
}
