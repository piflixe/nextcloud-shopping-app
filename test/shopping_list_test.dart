import 'package:flutter_test/flutter_test.dart';
import 'package:nextcloud_shopping_app/icons/item_icon_catalog.dart';
import 'package:nextcloud_shopping_app/models/shopping_list.dart';
import 'package:nextcloud_shopping_app/models/shopping_list_store.dart';

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

  test('suggests catalog icons and generated fallback icons', () {
    expect(suggestIconKey('Kaffee'), 'coffee');
    expect(suggestIconKey('Waschmittel'), 'laundry');
    expect(suggestIconKey('Orangensaft'), 'juice');
    expect(suggestIconKey('Reis'), 'rice');
    expect(suggestIconKey('Mehl'), 'flour');
    expect(suggestIconKey('Banane'), 'banana');
    expect(suggestIconKey('\u00c4pfel'), 'apple');
    expect(suggestIconKey('Tomaten'), 'tomato');
    expect(suggestIconKey('M\u00f6hren'), 'carrot');
    expect(suggestIconKey('Frischk\u00e4se'), 'cream_cheese');
    expect(suggestIconKey('Salzstangen'), 'pretzel_sticks');
    expect(suggestIconKey('Club-Mate'), 'mate');
    expect(suggestIconKey('Zahnpasta'), 'toothpaste');
    expect(suggestIconKey('Zahnb\u00fcrsten'), 'toothbrush');
    expect(suggestIconKey('Paprika'), 'pepper');
    expect(suggestIconKey('Very specific custom item'), 'generated:0');
  });

  test('matches localized icon picker search terms', () {
    final lemon = itemIconChoices.firstWhere((choice) => choice.key == 'lemon');
    final creamCheese = itemIconChoices.firstWhere(
      (choice) => choice.key == 'cream_cheese',
    );

    expect(
      iconChoiceMatchesQuery(lemon, 'Zitronen', languageCode: 'de'),
      isTrue,
    );
    expect(
      iconChoiceMatchesQuery(
        creamCheese,
        'Frischk\u00e4se',
        languageCode: 'de',
      ),
      isTrue,
    );
  });

  test('serializes shopping list profiles for multiple lists', () {
    final manifest = ShoppingListManifest(
      schemaVersion: 1,
      activeListId: 'groceries',
      lists: const [
        ShoppingListProfile(
          id: 'groceries',
          name: 'Groceries',
          localFileName: 'Groceries.json',
        ),
        ShoppingListProfile(
          id: 'hardware',
          name: 'Hardware',
          localFileName: 'Hardware.json',
          linkedFolderUri: 'content://folder',
          linkedFolderName: 'Shared',
          linkedDocumentUri: 'content://folder/Hardware.json',
          linkedDocumentName: 'Hardware.json',
        ),
      ],
    );

    final parsed = ShoppingListManifest.fromJsonText(manifest.toJsonText());

    expect(parsed.activeProfile.name, 'Groceries');
    expect(parsed.lists.last.hasLinkedStorage, isTrue);
    expect(parsed.lists.last.displayStorageName, 'Shared / Hardware.json');
  });

  test('builds json file names from list names', () {
    expect(jsonFileNameForList('Wochen Einkauf'), 'Wochen Einkauf.json');
    expect(jsonFileNameForList('Drogerie.json'), 'Drogerie.json');
    expect(jsonFileNameForList('Bad/Lager:*'), 'Bad-Lager-.json');
  });
}
