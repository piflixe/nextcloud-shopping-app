import 'package:flutter_test/flutter_test.dart';
import 'package:nextcloud_shopping_app/models/shopping_list.dart';

void main() {
  test('parses and serializes the shopping list JSON schema', () {
    const json = '''
{
  "schemaVersion": 1,
  "updatedAt": "2026-06-16T20:00:00.000Z",
  "items": [
    {
      "id": "milk",
      "name": "Milk",
      "amount": "1 l",
      "note": "Organic",
      "icon": "milk",
      "order": 0,
      "state": "open"
    },
    {
      "id": "bread",
      "name": "Bread",
      "amount": "",
      "note": "",
      "icon": "bread",
      "order": 1,
      "state": "lastUsed"
    }
  ]
}
''';

    final list = ShoppingListData.fromJsonText(json);

    expect(list.openItems.single.name, 'Milk');
    expect(list.lastUsedItems.single.name, 'Bread');
    expect(list.toJsonText(), contains('"state": "lastUsed"'));
  });

  test('supports a legacy root array', () {
    const json = '''
[
  {"name": "Apples", "state": "open"},
  {"name": "Pasta", "state": "done"}
]
''';

    final list = ShoppingListData.fromJsonText(json);

    expect(list.openItems.map((item) => item.name), ['Apples']);
    expect(list.lastUsedItems.map((item) => item.name), ['Pasta']);
  });
}
