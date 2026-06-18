import 'dart:convert';

enum ShoppingItemState {
  open,
  lastUsed;

  static ShoppingItemState fromJson(Object? value) {
    return switch (value?.toString()) {
      'lastUsed' || 'last_used' || 'done' || 'closed' => lastUsed,
      _ => open,
    };
  }

  String toJson() {
    return switch (this) {
      ShoppingItemState.open => 'open',
      ShoppingItemState.lastUsed => 'lastUsed',
    };
  }
}

class ShoppingItem {
  const ShoppingItem({
    required this.id,
    required this.name,
    required this.amount,
    required this.note,
    required this.icon,
    required this.order,
    required this.state,
  });

  final String id;
  final String name;
  final String amount;
  final String note;
  final String icon;
  final int order;
  final ShoppingItemState state;

  ShoppingItem copyWith({
    String? id,
    String? name,
    String? amount,
    String? note,
    String? icon,
    int? order,
    ShoppingItemState? state,
  }) {
    return ShoppingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      icon: icon ?? this.icon,
      order: order ?? this.order,
      state: state ?? this.state,
    );
  }

  factory ShoppingItem.fromJson(Map<String, Object?> json, int fallbackOrder) {
    final name = (json['name'] ?? json['title'] ?? '').toString().trim();
    return ShoppingItem(
      id: (json['id'] ?? _createId(name)).toString(),
      name: name,
      amount: (json['amount'] ?? '').toString(),
      note: (json['note'] ?? json['additionalInformation'] ?? '').toString(),
      icon: (json['icon'] ?? json['iconFile'] ?? '').toString(),
      order: _intFromJson(json['order'], fallbackOrder),
      state: ShoppingItemState.fromJson(json['state'] ?? json['status']),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'note': note,
      'icon': icon,
      'order': order,
      'state': state.toJson(),
    };
  }

  static int _intFromJson(Object? value, int fallback) {
    if (value is int) {
      return value;
    }
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }
}

class ShoppingListData {
  const ShoppingListData({
    required this.schemaVersion,
    required this.updatedAt,
    required this.items,
  });

  final int schemaVersion;
  final DateTime updatedAt;
  final List<ShoppingItem> items;

  factory ShoppingListData.empty() {
    return ShoppingListData(
      schemaVersion: 1,
      updatedAt: DateTime.now().toUtc(),
      items: const [],
    );
  }

  factory ShoppingListData.initial() {
    final names = [
      ('Milk', 'milk', '1 l'),
      ('Bread', 'bread', ''),
      ('Apples', 'apple', '6'),
      ('Pasta', 'pasta', ''),
      ('Tomatoes', 'tomato', ''),
      ('Cheese', 'cheese', ''),
    ];

    return ShoppingListData(
      schemaVersion: 1,
      updatedAt: DateTime.now().toUtc(),
      items: [
        for (var i = 0; i < names.length; i++)
          ShoppingItem(
            id: _createId(names[i].$1),
            name: names[i].$1,
            amount: names[i].$3,
            note: '',
            icon: names[i].$2,
            order: i,
            state: i < 3 ? ShoppingItemState.open : ShoppingItemState.lastUsed,
          ),
      ],
    );
  }

  factory ShoppingListData.fromJsonText(String source) {
    final decoded = jsonDecode(source);
    if (decoded is List) {
      return ShoppingListData(
        schemaVersion: 1,
        updatedAt: DateTime.now().toUtc(),
        items: _itemsFromList(decoded),
      );
    }
    if (decoded is! Map<String, Object?>) {
      throw const FormatException('Shopping list JSON must be an object.');
    }

    final rawItems = decoded['items'];
    return ShoppingListData(
      schemaVersion: _intFromJson(decoded['schemaVersion'], 1),
      updatedAt:
          DateTime.tryParse(decoded['updatedAt']?.toString() ?? '') ??
          DateTime.now().toUtc(),
      items: rawItems is List ? _itemsFromList(rawItems) : const [],
    );
  }

  ShoppingListData copyWith({
    int? schemaVersion,
    DateTime? updatedAt,
    List<ShoppingItem>? items,
  }) {
    return ShoppingListData(
      schemaVersion: schemaVersion ?? this.schemaVersion,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
    );
  }

  List<ShoppingItem> get openItems => _sortedItems(ShoppingItemState.open);

  List<ShoppingItem> get lastUsedItems =>
      _sortedItems(ShoppingItemState.lastUsed);

  String toJsonText() {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert({
      'schemaVersion': schemaVersion,
      'updatedAt': updatedAt.toUtc().toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
    });
  }

  ShoppingListData touch(List<ShoppingItem> updatedItems) {
    return copyWith(updatedAt: DateTime.now().toUtc(), items: updatedItems);
  }

  List<ShoppingItem> _sortedItems(ShoppingItemState state) {
    final filtered = items.where((item) => item.state == state).toList();
    filtered.sort((a, b) {
      final orderCompare = a.order.compareTo(b.order);
      if (orderCompare != 0) {
        return orderCompare;
      }
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    return filtered;
  }

  static List<ShoppingItem> _itemsFromList(List<Object?> source) {
    return [
      for (var i = 0; i < source.length; i++)
        if (source[i] case final Map<Object?, Object?> raw)
          ShoppingItem.fromJson(
            raw.map((key, value) => MapEntry(key.toString(), value)),
            i,
          ),
    ].where((item) => item.name.isNotEmpty).toList();
  }

  static int _intFromJson(Object? value, int fallback) {
    if (value is int) {
      return value;
    }
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }
}

String _createId(String name) {
  final cleaned = name
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
  final suffix = DateTime.now().microsecondsSinceEpoch;
  return '${cleaned.isEmpty ? 'item' : cleaned}-$suffix';
}
