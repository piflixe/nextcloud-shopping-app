import 'package:flutter/material.dart';

class ItemIconChoice {
  const ItemIconChoice(this.key, this.icon);

  final String key;
  final IconData icon;
}

const List<ItemIconChoice> itemIconChoices = [
  ItemIconChoice('basket', Icons.shopping_basket_outlined),
  ItemIconChoice('apple', Icons.spa_outlined),
  ItemIconChoice('bread', Icons.bakery_dining_outlined),
  ItemIconChoice('milk', Icons.local_drink_outlined),
  ItemIconChoice('cheese', Icons.lunch_dining_outlined),
  ItemIconChoice('tomato', Icons.local_pizza_outlined),
  ItemIconChoice('pasta', Icons.ramen_dining_outlined),
  ItemIconChoice('coffee', Icons.coffee_outlined),
  ItemIconChoice('tea', Icons.emoji_food_beverage_outlined),
  ItemIconChoice('water', Icons.water_drop_outlined),
  ItemIconChoice('cleaning', Icons.cleaning_services_outlined),
  ItemIconChoice('soap', Icons.soap_outlined),
  ItemIconChoice('pet', Icons.pets_outlined),
  ItemIconChoice('pharmacy', Icons.medication_outlined),
  ItemIconChoice('frozen', Icons.ac_unit_outlined),
  ItemIconChoice('vegetable', Icons.eco_outlined),
  ItemIconChoice('meat', Icons.set_meal_outlined),
  ItemIconChoice('egg', Icons.egg_outlined),
  ItemIconChoice('default', Icons.local_grocery_store_outlined),
];

IconData iconForShoppingItem({required String iconKey, required String name}) {
  final resolvedKey = iconKey.trim().isEmpty ? suggestIconKey(name) : iconKey;
  return itemIconChoices
      .firstWhere(
        (choice) => choice.key == resolvedKey,
        orElse: () => itemIconChoices.last,
      )
      .icon;
}

String suggestIconKey(String name) {
  final normalized = name.toLowerCase();
  for (final mapping in _keywordToIcon) {
    if (mapping.keywords.any((keyword) => normalized.contains(keyword))) {
      return mapping.iconKey;
    }
  }
  return 'default';
}

const List<_KeywordIconMapping> _keywordToIcon = [
  _KeywordIconMapping('milk', ['milk', 'milch', 'joghurt', 'yogurt']),
  _KeywordIconMapping('bread', ['bread', 'brot', 'brötchen', 'toast']),
  _KeywordIconMapping('apple', ['apple', 'apfel', 'banane', 'banana', 'obst']),
  _KeywordIconMapping('tomato', ['tomato', 'tomate', 'pizza']),
  _KeywordIconMapping('pasta', ['pasta', 'nudel', 'reis', 'rice']),
  _KeywordIconMapping('coffee', ['coffee', 'kaffee']),
  _KeywordIconMapping('tea', ['tea', 'tee']),
  _KeywordIconMapping('water', ['water', 'wasser', 'saft', 'juice']),
  _KeywordIconMapping('cleaning', ['clean', 'putz', 'reiniger']),
  _KeywordIconMapping('soap', ['soap', 'seife', 'shampoo']),
  _KeywordIconMapping('pet', ['cat', 'dog', 'hund', 'katze', 'tier']),
  _KeywordIconMapping('pharmacy', ['med', 'tablette', 'apotheke']),
  _KeywordIconMapping('frozen', ['frozen', 'eis', 'tiefkühl']),
  _KeywordIconMapping('vegetable', ['salat', 'gemüse', 'carrot', 'karotte']),
  _KeywordIconMapping('meat', ['meat', 'fleisch', 'fish', 'fisch']),
  _KeywordIconMapping('egg', ['egg', 'ei', 'eier']),
  _KeywordIconMapping('cheese', ['cheese', 'käse']),
];

class _KeywordIconMapping {
  const _KeywordIconMapping(this.iconKey, this.keywords);

  final String iconKey;
  final List<String> keywords;
}
