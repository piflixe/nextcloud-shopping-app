import 'dart:math' as math;

import 'package:flutter/material.dart';

class ItemIconChoice {
  const ItemIconChoice(this.key, this.icon, this.keywords);

  final String key;
  final IconData icon;
  final List<String> keywords;
}

const generatedIconPrefix = 'generated:';

const List<ItemIconChoice> itemIconChoices = [
  ItemIconChoice('basket', Icons.shopping_basket_outlined, [
    'shop',
    'shopping',
    'einkauf',
    'korb',
  ]),
  ItemIconChoice('bag', Icons.shopping_bag_outlined, ['bag', 'tuete']),
  ItemIconChoice('store', Icons.storefront_outlined, ['store', 'laden']),
  ItemIconChoice('offer', Icons.local_offer_outlined, ['coupon', 'rabatt']),
  ItemIconChoice('milk', Icons.local_drink_outlined, [
    'milk',
    'milch',
    'vollmilch',
    'hafermilch',
    'mandelmilch',
  ]),
  ItemIconChoice('juice', Icons.local_drink_outlined, [
    'juice',
    'saft',
    'orangensaft',
    'apfelsaft',
    'multivitamin',
  ]),
  ItemIconChoice('cola', Icons.local_drink_outlined, [
    'cola',
    'coke',
    'limonade',
    'softdrink',
  ]),
  ItemIconChoice('mate', Icons.local_drink_outlined, [
    'mate',
    'clubmate',
    'club mate',
    'eistee',
  ]),
  ItemIconChoice('water_bottle', Icons.water_drop_outlined, [
    'water',
    'wasser',
    'mineralwasser',
    'sprudel',
  ]),
  ItemIconChoice('yogurt', Icons.local_cafe_outlined, [
    'joghurt',
    'yogurt',
    'quark',
    'pudding',
  ]),
  ItemIconChoice('cream', Icons.local_drink_outlined, [
    'cream',
    'sahne',
    'creme',
  ]),
  ItemIconChoice('apple', Icons.spa_outlined, [
    'apple',
    'apfel',
    'fruit',
    'obst',
  ]),
  ItemIconChoice('banana', Icons.spa_outlined, ['banana', 'banane']),
  ItemIconChoice('orange', Icons.spa_outlined, [
    'orange',
    'mandarine',
    'clementine',
  ]),
  ItemIconChoice('lemon', Icons.spa_outlined, [
    'lemon',
    'zitrone',
    'limette',
    'lime',
  ]),
  ItemIconChoice('pear', Icons.spa_outlined, ['pear', 'birne']),
  ItemIconChoice('grapes', Icons.spa_outlined, [
    'grapes',
    'trauben',
    'weintrauben',
  ]),
  ItemIconChoice('strawberry', Icons.spa_outlined, [
    'strawberry',
    'erdbeere',
    'beere',
    'berries',
  ]),
  ItemIconChoice('watermelon', Icons.spa_outlined, [
    'watermelon',
    'melone',
    'wassermelone',
  ]),
  ItemIconChoice('pineapple', Icons.spa_outlined, ['pineapple', 'ananas']),
  ItemIconChoice('kiwi', Icons.spa_outlined, ['kiwi']),
  ItemIconChoice('peach', Icons.spa_outlined, [
    'peach',
    'pfirsich',
    'aprikose',
    'nektarine',
  ]),
  ItemIconChoice('cherry', Icons.spa_outlined, [
    'cherry',
    'kirsche',
    'kirschen',
  ]),
  ItemIconChoice('avocado', Icons.spa_outlined, ['avocado']),
  ItemIconChoice('vegetable', Icons.eco_outlined, [
    'vegetable',
    'gemuese',
    'salat',
  ]),
  ItemIconChoice('lettuce', Icons.eco_outlined, [
    'lettuce',
    'kopfsalat',
    'eisbergsalat',
    'rucola',
    'spinat',
  ]),
  ItemIconChoice('carrot', Icons.eco_outlined, [
    'carrot',
    'karotte',
    'moehre',
    'mohre',
  ]),
  ItemIconChoice('cucumber', Icons.eco_outlined, [
    'cucumber',
    'gurke',
    'zucchini',
  ]),
  ItemIconChoice('pepper', Icons.eco_outlined, ['pepper', 'paprika', 'chili']),
  ItemIconChoice('potato', Icons.eco_outlined, [
    'potato',
    'kartoffel',
    'kartoffeln',
  ]),
  ItemIconChoice('onion', Icons.eco_outlined, ['onion', 'zwiebel', 'zwiebeln']),
  ItemIconChoice('broccoli', Icons.eco_outlined, [
    'broccoli',
    'brokkoli',
    'blumenkohl',
  ]),
  ItemIconChoice('mushroom', Icons.eco_outlined, [
    'mushroom',
    'pilz',
    'pilze',
    'champignon',
  ]),
  ItemIconChoice('garlic', Icons.eco_outlined, ['garlic', 'knoblauch']),
  ItemIconChoice('corn', Icons.eco_outlined, ['corn', 'mais']),
  ItemIconChoice('tomato', Icons.local_pizza_outlined, [
    'tomato',
    'tomate',
    'sauce',
    'pizza',
  ]),
  ItemIconChoice('cabbage', Icons.eco_outlined, [
    'cabbage',
    'kohl',
    'rotkohl',
    'weisskohl',
    'wirsing',
  ]),
  ItemIconChoice('eggplant', Icons.eco_outlined, ['eggplant', 'aubergine']),
  ItemIconChoice('pumpkin', Icons.eco_outlined, [
    'pumpkin',
    'kuerbis',
    'kurbis',
  ]),
  ItemIconChoice('peas', Icons.eco_outlined, ['peas', 'erbse', 'erbsen']),
  ItemIconChoice('beans', Icons.eco_outlined, [
    'beans',
    'bohnen',
    'kidneybohnen',
  ]),
  ItemIconChoice('radish', Icons.eco_outlined, [
    'radish',
    'radieschen',
    'rettich',
  ]),
  ItemIconChoice('asparagus', Icons.eco_outlined, ['asparagus', 'spargel']),
  ItemIconChoice('herbs', Icons.eco_outlined, [
    'herbs',
    'kraeuter',
    'basilikum',
    'petersilie',
    'schnittlauch',
    'koriander',
  ]),
  ItemIconChoice('bread', Icons.bakery_dining_outlined, [
    'bread',
    'brot',
    'broetchen',
    'toast',
    'baguette',
    'bakery',
  ]),
  ItemIconChoice('cake', Icons.cake_outlined, [
    'cake',
    'kuchen',
    'torte',
    'muffin',
  ]),
  ItemIconChoice('cookie', Icons.cookie_outlined, [
    'cookie',
    'keks',
    'biscuit',
  ]),
  ItemIconChoice('feta', Icons.inventory_2_outlined, [
    'feta',
    'hirtenkaese',
    'hirtenkase',
    'schafskaese',
    'schafskase',
  ]),
  ItemIconChoice('mozzarella', Icons.inventory_2_outlined, [
    'mozzarella',
    'burrata',
  ]),
  ItemIconChoice('cream_cheese', Icons.inventory_2_outlined, [
    'cream cheese',
    'frischkaese',
    'frischkase',
    'philadelphia',
    'streichkaese',
    'streichkase',
  ]),
  ItemIconChoice('cheese', Icons.lunch_dining_outlined, [
    'cheese',
    'kaese',
    'kase',
    'gouda',
    'emmentaler',
  ]),
  ItemIconChoice('butter', Icons.inventory_2_outlined, ['butter']),
  ItemIconChoice('egg', Icons.egg_outlined, ['egg', 'eggs', 'ei', 'eier']),
  ItemIconChoice('meat', Icons.set_meal_outlined, [
    'meat',
    'fleisch',
    'sausage',
    'wurst',
    'ham',
    'schinken',
  ]),
  ItemIconChoice('fish', Icons.phishing_outlined, ['fish', 'fisch', 'seafood']),
  ItemIconChoice('pasta', Icons.ramen_dining_outlined, [
    'pasta',
    'nudel',
    'spaghetti',
    'ramen',
  ]),
  ItemIconChoice('rice', Icons.rice_bowl_outlined, [
    'rice',
    'reis',
    'grain',
    'getreide',
  ]),
  ItemIconChoice('flour', Icons.inventory_2_outlined, [
    'flour',
    'mehl',
    'weizenmehl',
    'dinkelmehl',
  ]),
  ItemIconChoice('sugar', Icons.inventory_2_outlined, ['sugar', 'zucker']),
  ItemIconChoice('salt', Icons.inventory_2_outlined, [
    'salt',
    'salz',
    'pfeffer',
    'peppercorn',
  ]),
  ItemIconChoice('oil', Icons.local_drink_outlined, [
    'oil',
    'oel',
    'olivenoel',
    'rapsoel',
    'essig',
    'vinegar',
  ]),
  ItemIconChoice('cereal', Icons.inventory_2_outlined, [
    'cereal',
    'muesli',
    'cornflakes',
    'haferflocken',
    'oats',
  ]),
  ItemIconChoice('nuts', Icons.grain_outlined, [
    'nuts',
    'nuesse',
    'nuss',
    'mandel',
    'mandeln',
  ]),
  ItemIconChoice('honey', Icons.inventory_2_outlined, ['honey', 'honig']),
  ItemIconChoice('jam', Icons.inventory_2_outlined, [
    'jam',
    'marmelade',
    'konfituere',
  ]),
  ItemIconChoice('chocolate', Icons.cookie_outlined, [
    'chocolate',
    'schokolade',
    'schoko',
  ]),
  ItemIconChoice('pretzel_sticks', Icons.bakery_dining_outlined, [
    'pretzel sticks',
    'salzstangen',
    'salzstange',
    'brezelstangen',
    'laugenstangen',
  ]),
  ItemIconChoice('chips', Icons.fastfood_outlined, [
    'chips',
    'nachos',
    'cracker',
  ]),
  ItemIconChoice('canned', Icons.inventory_2_outlined, [
    'dose',
    'dosen',
    'canned',
    'konserve',
  ]),
  ItemIconChoice('tofu', Icons.inventory_2_outlined, ['tofu']),
  ItemIconChoice('soup', Icons.soup_kitchen_outlined, ['soup', 'suppe']),
  ItemIconChoice('restaurant', Icons.restaurant_outlined, [
    'meal',
    'essen',
    'food',
    'lebensmittel',
  ]),
  ItemIconChoice('fastfood', Icons.fastfood_outlined, [
    'burger',
    'fries',
    'snack',
  ]),
  ItemIconChoice('frozen', Icons.ac_unit_outlined, [
    'frozen',
    'tiefkuehl',
    'eis',
    'ice',
  ]),
  ItemIconChoice('icecream', Icons.icecream_outlined, ['icecream', 'eiscreme']),
  ItemIconChoice('coffee', Icons.coffee_outlined, ['coffee', 'kaffee']),
  ItemIconChoice('tea', Icons.emoji_food_beverage_outlined, ['tea', 'tee']),
  ItemIconChoice('water', Icons.water_drop_outlined, ['drink', 'getraenk']),
  ItemIconChoice('beer', Icons.sports_bar_outlined, ['beer', 'bier']),
  ItemIconChoice('wine', Icons.wine_bar_outlined, ['wine', 'wein']),
  ItemIconChoice('kitchen', Icons.kitchen_outlined, [
    'kitchen',
    'kueche',
    'fridge',
    'kuehlschrank',
  ]),
  ItemIconChoice('cleaning', Icons.cleaning_services_outlined, [
    'clean',
    'putz',
    'reiniger',
    'lappen',
  ]),
  ItemIconChoice('laundry', Icons.local_laundry_service_outlined, [
    'laundry',
    'waschmittel',
    'waesche',
  ]),
  ItemIconChoice('soap', Icons.soap_outlined, [
    'soap',
    'seife',
    'shampoo',
    'duschgel',
  ]),
  ItemIconChoice('toothpaste', Icons.clean_hands_outlined, [
    'toothpaste',
    'zahnpasta',
    'zahncreme',
  ]),
  ItemIconChoice('toothbrush', Icons.cleaning_services_outlined, [
    'toothbrush',
    'zahnbuerste',
    'zahnburste',
    'zahnbürste',
  ]),
  ItemIconChoice('sanitizer', Icons.sanitizer_outlined, [
    'desinfektion',
    'sanitizer',
  ]),
  ItemIconChoice('paper', Icons.inventory_2_outlined, [
    'paper',
    'papier',
    'toilet',
    'kuechenrolle',
  ]),
  ItemIconChoice('pet', Icons.pets_outlined, [
    'pet',
    'tier',
    'cat',
    'katze',
    'dog',
    'hund',
  ]),
  ItemIconChoice('baby', Icons.child_friendly_outlined, [
    'baby',
    'windel',
    'diaper',
  ]),
  ItemIconChoice('pharmacy', Icons.local_pharmacy_outlined, [
    'pharmacy',
    'apotheke',
    'medicine',
    'medizin',
  ]),
  ItemIconChoice('medication', Icons.medication_outlined, [
    'tablet',
    'tablette',
    'pills',
  ]),
  ItemIconChoice('healing', Icons.healing_outlined, [
    'healing',
    'pflaster',
    'verband',
  ]),
  ItemIconChoice('mask', Icons.masks_outlined, ['mask', 'maske']),
  ItemIconChoice('flower', Icons.local_florist_outlined, [
    'flower',
    'blume',
    'pflanze',
  ]),
  ItemIconChoice('garden', Icons.yard_outlined, ['garden', 'garten', 'erde']),
  ItemIconChoice('tools', Icons.construction_outlined, [
    'tool',
    'werkzeug',
    'schraube',
  ]),
  ItemIconChoice('hardware', Icons.hardware_outlined, ['hardware', 'baumarkt']),
  ItemIconChoice('lightbulb', Icons.lightbulb_outlined, [
    'bulb',
    'lampe',
    'birne',
  ]),
  ItemIconChoice('battery', Icons.battery_charging_full_outlined, [
    'battery',
    'batterie',
    'akku',
  ]),
  ItemIconChoice('print', Icons.print_outlined, [
    'printer',
    'drucker',
    'patrone',
  ]),
  ItemIconChoice('car', Icons.directions_car_outlined, ['car', 'auto']),
  ItemIconChoice('fuel', Icons.local_gas_station_outlined, [
    'fuel',
    'benzin',
    'diesel',
  ]),
  ItemIconChoice('toy', Icons.toys_outlined, ['toy', 'spielzeug']),
  ItemIconChoice('sport', Icons.sports_soccer_outlined, ['sport', 'ball']),
  ItemIconChoice('clothes', Icons.checkroom_outlined, [
    'clothes',
    'kleidung',
    'shirt',
    'socken',
  ]),
  ItemIconChoice('default', Icons.local_grocery_store_outlined, []),
];

bool isGeneratedIconKey(String key) {
  return key.startsWith(generatedIconPrefix);
}

List<String> generatedIconKeysFor(String name) {
  return [
    for (var variant = 0; variant < 10; variant++)
      '$generatedIconPrefix$variant',
  ];
}

IconData materialIconForKey(String iconKey) {
  return itemIconChoices
      .firstWhere(
        (choice) => choice.key == iconKey,
        orElse: () => itemIconChoices.last,
      )
      .icon;
}

String suggestIconKey(String name) {
  var bestKey = '${generatedIconPrefix}0';
  var bestScore = 0;
  for (final choice in itemIconChoices) {
    if (choice.key == 'default') {
      continue;
    }
    final score = _iconChoiceMatchScore(choice, name);
    if (score > bestScore) {
      bestKey = choice.key;
      bestScore = score;
    }
  }
  return bestScore == 0 ? '${generatedIconPrefix}0' : bestKey;
}

bool iconChoiceMatchesQuery(
  ItemIconChoice choice,
  String query, {
  String? languageCode,
}) {
  return _iconChoiceMatchScore(choice, query, languageCode: languageCode) > 0;
}

int _iconChoiceMatchScore(
  ItemIconChoice choice,
  String query, {
  String? languageCode,
}) {
  final queryTerms = _iconSearchTerms(query);
  if (queryTerms.isEmpty) {
    return 1;
  }

  final choiceTerms = _iconSearchTerms(
    localizedIconSearchText(choice, languageCode: languageCode),
  );

  var bestScore = 0;
  for (final queryTerm in queryTerms) {
    if (choiceTerms.contains(queryTerm)) {
      bestScore = math.max(bestScore, 100);
    }
    if (queryTerm.length <= 2) {
      continue;
    }
    for (final choiceTerm in choiceTerms) {
      if (choiceTerm.length <= 2) {
        continue;
      }
      if (queryTerm.contains(choiceTerm) || choiceTerm.contains(queryTerm)) {
        bestScore = math.max(bestScore, 50);
      }
    }
  }
  return bestScore;
}

String localizedIconSearchText(ItemIconChoice choice, {String? languageCode}) {
  return [
    choice.key,
    localizedIconLabel(choice.key, languageCode: languageCode),
    ...choice.keywords,
    ...?_localizedIconKeywords[choice.key],
  ].join(' ');
}

String localizedIconLabel(String iconKey, {String? languageCode}) {
  if (languageCode == 'de') {
    return _germanIconNames[iconKey] ?? _humanizeIconKey(iconKey);
  }
  return _englishIconNames[iconKey] ?? _humanizeIconKey(iconKey);
}

int supermarketOrderForIcon(String iconKey) {
  return _supermarketOrderByIcon[iconKey] ?? 90;
}

String normalizeIconSearchText(String value) {
  return value
      .toLowerCase()
      .replaceAll('\u00e4', 'ae')
      .replaceAll('\u00f6', 'oe')
      .replaceAll('\u00fc', 'ue')
      .replaceAll('\u00df', 'ss')
      .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
      .trim();
}

Set<String> _iconSearchTerms(String value) {
  final normalized = normalizeIconSearchText(value);
  if (normalized.isEmpty) {
    return const <String>{};
  }

  final terms = <String>{};
  final tokens = normalized
      .split(RegExp(r'\s+'))
      .where((token) => token.isNotEmpty)
      .toList();
  for (final token in tokens) {
    _addTermVariants(terms, token);
  }
  if (tokens.length > 1) {
    _addTermVariants(terms, tokens.join());
  }
  return terms;
}

void _addTermVariants(Set<String> terms, String term) {
  if (term.isEmpty) {
    return;
  }
  final candidates = <String>{term, _compactGermanUmlautVariant(term)};
  for (final candidate in candidates.toList()) {
    for (final suffix in const [
      'innen',
      'chen',
      'lein',
      'ern',
      'en',
      'er',
      'es',
      'e',
      'n',
      's',
    ]) {
      if (candidate.length > suffix.length + 3 && candidate.endsWith(suffix)) {
        candidates.add(
          candidate.substring(0, candidate.length - suffix.length),
        );
      }
    }
  }
  for (final candidate in candidates.toList()) {
    terms.add(candidate);
    terms.add(_compactGermanUmlautVariant(candidate));
  }
}

String _compactGermanUmlautVariant(String value) {
  return value
      .replaceAll('ae', 'a')
      .replaceAll('oe', 'o')
      .replaceAll('ue', 'u');
}

String _humanizeIconKey(String key) {
  return key.replaceAll('_', ' ');
}

const Map<String, String> _englishIconNames = {
  'water_bottle': 'water bottle',
  'cream_cheese': 'cream cheese',
  'pretzel_sticks': 'pretzel sticks',
};

const Map<String, String> _germanIconNames = {
  'basket': 'Einkaufskorb',
  'bag': 'Einkaufstasche',
  'store': 'Laden',
  'offer': 'Angebot',
  'milk': 'Milch',
  'juice': 'Saft',
  'cola': 'Cola',
  'mate': 'Mate',
  'water_bottle': 'Wasserflasche',
  'yogurt': 'Joghurt',
  'cream': 'Sahne',
  'apple': 'Apfel',
  'banana': 'Banane',
  'orange': 'Orange',
  'lemon': 'Zitrone',
  'pear': 'Birne',
  'grapes': 'Trauben',
  'strawberry': 'Erdbeere',
  'watermelon': 'Wassermelone',
  'pineapple': 'Ananas',
  'kiwi': 'Kiwi',
  'peach': 'Pfirsich',
  'cherry': 'Kirschen',
  'avocado': 'Avocado',
  'vegetable': 'Gemuese',
  'lettuce': 'Salat',
  'carrot': 'Karotte',
  'cucumber': 'Gurke',
  'pepper': 'Paprika',
  'potato': 'Kartoffel',
  'onion': 'Zwiebel',
  'broccoli': 'Brokkoli',
  'mushroom': 'Pilze',
  'garlic': 'Knoblauch',
  'corn': 'Mais',
  'tomato': 'Tomate',
  'cabbage': 'Kohl',
  'eggplant': 'Aubergine',
  'pumpkin': 'Kuerbis',
  'peas': 'Erbsen',
  'beans': 'Bohnen',
  'radish': 'Radieschen',
  'asparagus': 'Spargel',
  'herbs': 'Kraeuter',
  'bread': 'Brot',
  'cake': 'Kuchen',
  'cookie': 'Keks',
  'feta': 'Feta',
  'mozzarella': 'Mozzarella',
  'cream_cheese': 'Frischkaese',
  'cheese': 'Kaese',
  'butter': 'Butter',
  'egg': 'Ei',
  'meat': 'Fleisch',
  'fish': 'Fisch',
  'pasta': 'Nudeln',
  'rice': 'Reis',
  'flour': 'Mehl',
  'sugar': 'Zucker',
  'salt': 'Salz',
  'oil': 'Oel',
  'cereal': 'Muesli',
  'nuts': 'Nuesse',
  'honey': 'Honig',
  'jam': 'Marmelade',
  'chocolate': 'Schokolade',
  'pretzel_sticks': 'Salzstangen',
  'chips': 'Chips',
  'canned': 'Konserve',
  'tofu': 'Tofu',
  'soup': 'Suppe',
  'restaurant': 'Essen',
  'fastfood': 'Snack',
  'frozen': 'Tiefkuehlware',
  'icecream': 'Eis',
  'coffee': 'Kaffee',
  'tea': 'Tee',
  'water': 'Getraenk',
  'beer': 'Bier',
  'wine': 'Wein',
  'kitchen': 'Kueche',
  'cleaning': 'Putzen',
  'laundry': 'Waesche',
  'soap': 'Seife',
  'toothpaste': 'Zahnpasta',
  'toothbrush': 'Zahnbuerste',
  'sanitizer': 'Desinfektion',
  'paper': 'Papier',
  'pet': 'Tierbedarf',
  'baby': 'Baby',
  'pharmacy': 'Apotheke',
  'medication': 'Medikamente',
  'healing': 'Pflaster',
  'mask': 'Maske',
  'flower': 'Blume',
  'garden': 'Garten',
  'tools': 'Werkzeug',
  'hardware': 'Baumarkt',
  'lightbulb': 'Lampe',
  'battery': 'Batterie',
  'print': 'Drucker',
  'car': 'Auto',
  'fuel': 'Benzin',
  'toy': 'Spielzeug',
  'sport': 'Sport',
  'clothes': 'Kleidung',
  'default': 'Artikel',
};

const Map<String, List<String>> _localizedIconKeywords = {
  'apple': ['aepfel', 'apfel'],
  'lemon': ['zitronen'],
  'feta': ['salatkaese', 'salatkase'],
  'mozzarella': ['mini mozzarella'],
  'cream_cheese': ['frischkaese', 'frischkase', 'brotaufstrich'],
  'pretzel_sticks': ['salzstange', 'salzstangen'],
  'cola': ['coca cola', 'pepsi'],
  'mate': ['club mate', 'club-mate'],
  'toothpaste': ['zahn pasta', 'zahncreme'],
  'toothbrush': ['zahn buerste', 'zahn burste'],
};

const Map<String, int> _supermarketOrderByIcon = {
  'vegetable': 10,
  'lettuce': 10,
  'carrot': 10,
  'cucumber': 10,
  'pepper': 10,
  'potato': 10,
  'onion': 10,
  'broccoli': 10,
  'mushroom': 10,
  'garlic': 10,
  'corn': 10,
  'tomato': 10,
  'cabbage': 10,
  'eggplant': 10,
  'pumpkin': 10,
  'peas': 10,
  'beans': 10,
  'radish': 10,
  'asparagus': 10,
  'herbs': 10,
  'apple': 12,
  'banana': 12,
  'orange': 12,
  'lemon': 12,
  'pear': 12,
  'grapes': 12,
  'strawberry': 12,
  'watermelon': 12,
  'pineapple': 12,
  'kiwi': 12,
  'peach': 12,
  'cherry': 12,
  'avocado': 12,
  'bread': 20,
  'cake': 20,
  'cookie': 20,
  'milk': 30,
  'yogurt': 30,
  'cream': 30,
  'feta': 30,
  'mozzarella': 30,
  'cream_cheese': 30,
  'cheese': 30,
  'butter': 30,
  'egg': 30,
  'meat': 34,
  'fish': 34,
  'tofu': 34,
  'frozen': 38,
  'icecream': 38,
  'pasta': 42,
  'rice': 42,
  'flour': 42,
  'sugar': 42,
  'salt': 42,
  'oil': 42,
  'cereal': 42,
  'nuts': 42,
  'honey': 46,
  'jam': 46,
  'canned': 46,
  'soup': 46,
  'chocolate': 50,
  'pretzel_sticks': 50,
  'chips': 50,
  'juice': 60,
  'cola': 60,
  'mate': 60,
  'water_bottle': 60,
  'water': 60,
  'coffee': 64,
  'tea': 64,
  'beer': 66,
  'wine': 66,
  'cleaning': 80,
  'laundry': 80,
  'soap': 80,
  'toothpaste': 80,
  'toothbrush': 80,
  'sanitizer': 80,
  'paper': 80,
  'pet': 82,
  'baby': 82,
  'pharmacy': 84,
  'medication': 84,
  'healing': 84,
  'mask': 84,
  'flower': 86,
  'garden': 86,
  'tools': 88,
  'hardware': 88,
  'lightbulb': 88,
  'battery': 88,
  'print': 88,
  'car': 88,
  'fuel': 88,
  'toy': 88,
  'sport': 88,
  'clothes': 88,
};

Color generatedIconAccent(String name, int variant) {
  final hue = (_stableHash('$name:$variant') % 360).toDouble();
  return HSLColor.fromAHSL(1, hue, 0.58, 0.58).toColor();
}

int generatedIconVariant(String iconKey) {
  if (!isGeneratedIconKey(iconKey)) {
    return 0;
  }
  return int.tryParse(iconKey.substring(generatedIconPrefix.length)) ?? 0;
}

const Set<String> _drawnItemIconKeys = {
  'milk',
  'juice',
  'cola',
  'mate',
  'water_bottle',
  'yogurt',
  'cream',
  'apple',
  'banana',
  'orange',
  'lemon',
  'pear',
  'grapes',
  'strawberry',
  'watermelon',
  'pineapple',
  'kiwi',
  'peach',
  'cherry',
  'avocado',
  'lettuce',
  'carrot',
  'cucumber',
  'pepper',
  'potato',
  'onion',
  'broccoli',
  'mushroom',
  'garlic',
  'corn',
  'tomato',
  'cabbage',
  'eggplant',
  'pumpkin',
  'peas',
  'beans',
  'radish',
  'asparagus',
  'herbs',
  'bread',
  'feta',
  'mozzarella',
  'cream_cheese',
  'cheese',
  'butter',
  'egg',
  'fish',
  'pasta',
  'rice',
  'flour',
  'sugar',
  'salt',
  'oil',
  'cereal',
  'nuts',
  'honey',
  'jam',
  'chocolate',
  'pretzel_sticks',
  'chips',
  'canned',
  'tofu',
  'toothpaste',
  'toothbrush',
};

bool hasDrawnItemIcon(String iconKey) {
  return _drawnItemIconKeys.contains(iconKey);
}

int _stableHash(String value) {
  var hash = 0;
  for (final codeUnit in value.codeUnits) {
    hash = 0x1fffffff & (hash + codeUnit);
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    hash ^= hash >> 6;
  }
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash ^= hash >> 11;
  hash = 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  return hash.abs();
}

class ShoppingItemIcon extends StatelessWidget {
  const ShoppingItemIcon({
    super.key,
    required this.iconKey,
    required this.name,
    required this.size,
    required this.color,
  });

  final String iconKey;
  final String name;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (isGeneratedIconKey(iconKey)) {
      return GeneratedItemIcon(
        name: name,
        variant: generatedIconVariant(iconKey),
        size: size,
        color: color,
      );
    }
    if (hasDrawnItemIcon(iconKey)) {
      return DrawnItemIcon(iconKey: iconKey, size: size, color: color);
    }
    return Icon(materialIconForKey(iconKey), size: size, color: color);
  }
}

class DrawnItemIcon extends StatelessWidget {
  const DrawnItemIcon({
    super.key,
    required this.iconKey,
    required this.size,
    required this.color,
  });

  final String iconKey;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _DrawnItemIconPainter(iconKey: iconKey, color: color),
    );
  }
}

class _DrawnItemIconPainter extends CustomPainter {
  const _DrawnItemIconPainter({required this.iconKey, required this.color});

  final String iconKey;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.07
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final thinStroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.045
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final fill = Paint()
      ..color = color.withValues(alpha: 0.22)
      ..style = PaintingStyle.fill;

    switch (iconKey) {
      case 'milk':
      case 'juice':
      case 'cream':
        _drawCarton(
          canvas,
          size,
          stroke,
          thinStroke,
          label: _cartonLabel(iconKey),
        );
        break;
      case 'cola':
      case 'mate':
      case 'water_bottle':
      case 'oil':
        _drawBottle(
          canvas,
          size,
          stroke,
          thinStroke,
          oil: iconKey == 'oil',
          label: switch (iconKey) {
            'cola' => 'C',
            'mate' => 'M',
            _ => '',
          },
        );
        break;
      case 'yogurt':
        _drawYogurt(canvas, size, stroke, thinStroke);
        break;
      case 'apple':
        _drawApple(canvas, size, stroke, thinStroke, fill);
        break;
      case 'banana':
        _drawBanana(canvas, size, stroke, thinStroke);
        break;
      case 'orange':
      case 'lemon':
        _drawCitrus(canvas, size, stroke, thinStroke, long: iconKey == 'lemon');
        break;
      case 'pear':
        _drawPear(canvas, size, stroke, thinStroke, fill);
        break;
      case 'grapes':
        _drawGrapes(canvas, size, stroke, fill);
        break;
      case 'strawberry':
        _drawStrawberry(canvas, size, stroke, thinStroke);
        break;
      case 'watermelon':
        _drawWatermelon(canvas, size, stroke, thinStroke);
        break;
      case 'pineapple':
        _drawPineapple(canvas, size, stroke, thinStroke);
        break;
      case 'kiwi':
        _drawKiwi(canvas, size, stroke, thinStroke, fill);
        break;
      case 'peach':
        _drawPeach(canvas, size, stroke, thinStroke, fill);
        break;
      case 'cherry':
        _drawCherry(canvas, size, stroke, thinStroke);
        break;
      case 'avocado':
        _drawAvocado(canvas, size, stroke, thinStroke, fill);
        break;
      case 'lettuce':
      case 'cabbage':
      case 'herbs':
        _drawLettuce(canvas, size, stroke, thinStroke);
        break;
      case 'carrot':
      case 'radish':
        _drawCarrot(canvas, size, stroke, thinStroke);
        break;
      case 'cucumber':
      case 'eggplant':
      case 'asparagus':
        _drawCucumber(canvas, size, stroke, thinStroke);
        break;
      case 'pepper':
        _drawPepper(canvas, size, stroke, thinStroke);
        break;
      case 'potato':
        _drawPotato(canvas, size, stroke, thinStroke);
        break;
      case 'onion':
        _drawOnion(canvas, size, stroke, thinStroke);
        break;
      case 'broccoli':
        _drawBroccoli(canvas, size, stroke, thinStroke, fill);
        break;
      case 'mushroom':
        _drawMushroom(canvas, size, stroke, thinStroke);
        break;
      case 'garlic':
        _drawGarlic(canvas, size, stroke, thinStroke);
        break;
      case 'corn':
      case 'peas':
      case 'beans':
        _drawCorn(canvas, size, stroke, thinStroke);
        break;
      case 'tomato':
      case 'pumpkin':
        _drawTomato(canvas, size, stroke, thinStroke, fill);
        break;
      case 'bread':
        _drawBread(canvas, size, stroke, thinStroke);
        break;
      case 'feta':
      case 'mozzarella':
      case 'cream_cheese':
        _drawDairyPack(
          canvas,
          size,
          stroke,
          thinStroke,
          label: _dairyLabel(iconKey),
        );
        break;
      case 'cheese':
        _drawCheese(canvas, size, stroke, thinStroke);
        break;
      case 'butter':
      case 'tofu':
        _drawBox(
          canvas,
          size,
          stroke,
          thinStroke,
          label: iconKey == 'butter' ? 'B' : 'T',
        );
        break;
      case 'egg':
        _drawEgg(canvas, size, stroke, thinStroke);
        break;
      case 'fish':
        _drawFish(canvas, size, stroke, thinStroke);
        break;
      case 'pasta':
        _drawPasta(canvas, size, stroke, thinStroke);
        break;
      case 'rice':
        _drawRice(canvas, size, stroke, thinStroke);
        break;
      case 'flour':
      case 'sugar':
      case 'cereal':
        _drawBag(canvas, size, stroke, thinStroke, label: _bagLabel(iconKey));
        break;
      case 'salt':
        _drawSalt(canvas, size, stroke, thinStroke);
        break;
      case 'nuts':
        _drawNuts(canvas, size, stroke, thinStroke, fill);
        break;
      case 'honey':
      case 'jam':
      case 'canned':
        _drawJar(canvas, size, stroke, thinStroke, label: _jarLabel(iconKey));
        break;
      case 'chocolate':
      case 'chips':
        _drawSnack(
          canvas,
          size,
          stroke,
          thinStroke,
          chocolate: iconKey == 'chocolate',
        );
        break;
      case 'pretzel_sticks':
        _drawPretzelSticks(canvas, size, stroke, thinStroke);
        break;
      case 'toothpaste':
        _drawToothpaste(canvas, size, stroke, thinStroke);
        break;
      case 'toothbrush':
        _drawToothbrush(canvas, size, stroke, thinStroke);
        break;
      default:
        _drawBag(canvas, size, stroke, thinStroke, label: '');
    }
  }

  String _cartonLabel(String key) {
    return switch (key) {
      'milk' => 'M',
      'juice' => 'S',
      'cream' => 'C',
      _ => '',
    };
  }

  String _bagLabel(String key) {
    return switch (key) {
      'flour' => 'M',
      'sugar' => 'Z',
      'cereal' => 'O',
      _ => '',
    };
  }

  String _dairyLabel(String key) {
    return switch (key) {
      'feta' => 'F',
      'mozzarella' => 'M',
      'cream_cheese' => 'F',
      _ => '',
    };
  }

  String _jarLabel(String key) {
    return switch (key) {
      'honey' => 'H',
      'jam' => 'J',
      'canned' => 'D',
      _ => '',
    };
  }

  void _drawCarton(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke, {
    required String label,
  }) {
    final w = size.width;
    final path = Path()
      ..moveTo(w * 0.27, w * 0.24)
      ..lineTo(w * 0.42, w * 0.12)
      ..lineTo(w * 0.73, w * 0.22)
      ..lineTo(w * 0.73, w * 0.82)
      ..lineTo(w * 0.27, w * 0.82)
      ..close();
    canvas.drawPath(path, stroke);
    canvas.drawLine(
      Offset(w * 0.42, w * 0.12),
      Offset(w * 0.42, w * 0.32),
      thinStroke,
    );
    canvas.drawLine(
      Offset(w * 0.27, w * 0.36),
      Offset(w * 0.73, w * 0.36),
      thinStroke,
    );
    canvas.drawLine(
      Offset(w * 0.5, w * 0.46),
      Offset(w * 0.5, w * 0.68),
      thinStroke,
    );
    _drawLabel(canvas, size, label, w * 0.34);
  }

  void _drawBottle(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke, {
    required bool oil,
    String label = '',
  }) {
    final w = size.width;
    final path = Path()
      ..moveTo(w * 0.42, w * 0.12)
      ..lineTo(w * 0.58, w * 0.12)
      ..lineTo(w * 0.58, w * 0.29)
      ..quadraticBezierTo(w * 0.72, w * 0.35, w * 0.72, w * 0.49)
      ..lineTo(w * 0.72, w * 0.82)
      ..lineTo(w * 0.28, w * 0.82)
      ..lineTo(w * 0.28, w * 0.49)
      ..quadraticBezierTo(w * 0.28, w * 0.35, w * 0.42, w * 0.29)
      ..close();
    canvas.drawPath(path, stroke);
    canvas.drawLine(
      Offset(w * 0.35, w * 0.52),
      Offset(w * 0.65, w * 0.52),
      thinStroke,
    );
    if (oil) {
      canvas.drawPath(
        Path()
          ..moveTo(w * 0.5, w * 0.39)
          ..quadraticBezierTo(w * 0.38, w * 0.54, w * 0.5, w * 0.62)
          ..quadraticBezierTo(w * 0.62, w * 0.54, w * 0.5, w * 0.39),
        thinStroke,
      );
    }
    _drawLabel(canvas, size, label, w * 0.24);
  }

  void _drawYogurt(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    canvas.drawLine(
      Offset(w * 0.25, w * 0.28),
      Offset(w * 0.75, w * 0.28),
      stroke,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.31, w * 0.31, w * 0.38, w * 0.47),
        Radius.circular(w * 0.08),
      ),
      stroke,
    );
    canvas.drawArc(
      Rect.fromLTWH(w * 0.35, w * 0.38, w * 0.3, w * 0.22),
      0,
      math.pi,
      false,
      thinStroke,
    );
  }

  void _drawApple(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke,
    Paint fill,
  ) {
    final w = size.width;
    final path = Path()
      ..moveTo(w * 0.5, w * 0.33)
      ..cubicTo(w * 0.25, w * 0.2, w * 0.16, w * 0.55, w * 0.32, w * 0.78)
      ..cubicTo(w * 0.42, w * 0.9, w * 0.48, w * 0.78, w * 0.5, w * 0.78)
      ..cubicTo(w * 0.52, w * 0.78, w * 0.58, w * 0.9, w * 0.68, w * 0.78)
      ..cubicTo(w * 0.84, w * 0.55, w * 0.75, w * 0.2, w * 0.5, w * 0.33);
    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
    canvas.drawLine(
      Offset(w * 0.5, w * 0.32),
      Offset(w * 0.56, w * 0.16),
      thinStroke,
    );
    canvas.drawOval(
      Rect.fromLTWH(w * 0.56, w * 0.15, w * 0.19, w * 0.1),
      thinStroke,
    );
  }

  void _drawBanana(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    final path = Path()
      ..moveTo(w * 0.24, w * 0.58)
      ..cubicTo(w * 0.43, w * 0.82, w * 0.76, w * 0.74, w * 0.86, w * 0.39)
      ..cubicTo(w * 0.65, w * 0.62, w * 0.42, w * 0.62, w * 0.25, w * 0.36);
    canvas.drawPath(path, stroke);
    canvas.drawLine(
      Offset(w * 0.24, w * 0.58),
      Offset(w * 0.18, w * 0.62),
      thinStroke,
    );
    canvas.drawLine(
      Offset(w * 0.86, w * 0.39),
      Offset(w * 0.91, w * 0.34),
      thinStroke,
    );
  }

  void _drawCitrus(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke, {
    required bool long,
  }) {
    final w = size.width;
    if (long) {
      final lemon = Path()
        ..moveTo(w * 0.18, w * 0.52)
        ..cubicTo(w * 0.3, w * 0.24, w * 0.68, w * 0.2, w * 0.84, w * 0.38)
        ..cubicTo(w * 0.7, w * 0.7, w * 0.32, w * 0.78, w * 0.18, w * 0.52);
      canvas.drawPath(lemon, stroke);
      canvas.drawPath(
        Path()
          ..moveTo(w * 0.34, w * 0.52)
          ..quadraticBezierTo(w * 0.52, w * 0.4, w * 0.7, w * 0.42),
        thinStroke,
      );
      _drawLeaf(canvas, w, Offset(w * 0.7, w * 0.25), thinStroke);
      return;
    }
    final rect = long
        ? Rect.fromLTWH(w * 0.22, w * 0.36, w * 0.56, w * 0.32)
        : Rect.fromLTWH(w * 0.24, w * 0.24, w * 0.52, w * 0.52);
    canvas.drawOval(rect, stroke);
    canvas.drawLine(
      Offset(w * 0.5, rect.top),
      Offset(w * 0.5, rect.bottom),
      thinStroke,
    );
    canvas.drawLine(
      Offset(rect.left, w * 0.5),
      Offset(rect.right, w * 0.5),
      thinStroke,
    );
    if (!long) {
      canvas.drawArc(
        Rect.fromLTWH(w * 0.36, w * 0.16, w * 0.25, w * 0.15),
        math.pi,
        math.pi,
        false,
        thinStroke,
      );
    }
  }

  void _drawPear(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke,
    Paint fill,
  ) {
    final w = size.width;
    final path = Path()
      ..moveTo(w * 0.5, w * 0.22)
      ..cubicTo(w * 0.28, w * 0.28, w * 0.32, w * 0.48, w * 0.22, w * 0.62)
      ..cubicTo(w * 0.14, w * 0.78, w * 0.34, w * 0.88, w * 0.5, w * 0.82)
      ..cubicTo(w * 0.66, w * 0.88, w * 0.86, w * 0.78, w * 0.78, w * 0.62)
      ..cubicTo(w * 0.68, w * 0.48, w * 0.72, w * 0.28, w * 0.5, w * 0.22);
    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
    canvas.drawLine(
      Offset(w * 0.5, w * 0.22),
      Offset(w * 0.56, w * 0.1),
      thinStroke,
    );
  }

  void _drawGrapes(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final w = size.width;
    for (final center in [
      Offset(w * 0.42, w * 0.34),
      Offset(w * 0.58, w * 0.34),
      Offset(w * 0.34, w * 0.5),
      Offset(w * 0.5, w * 0.5),
      Offset(w * 0.66, w * 0.5),
      Offset(w * 0.42, w * 0.66),
      Offset(w * 0.58, w * 0.66),
    ]) {
      canvas.drawCircle(center, w * 0.095, fill);
      canvas.drawCircle(center, w * 0.095, stroke);
    }
  }

  void _drawStrawberry(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke,
  ) {
    final w = size.width;
    final path = Path()
      ..moveTo(w * 0.5, w * 0.25)
      ..cubicTo(w * 0.22, w * 0.22, w * 0.18, w * 0.47, w * 0.5, w * 0.86)
      ..cubicTo(w * 0.82, w * 0.47, w * 0.78, w * 0.22, w * 0.5, w * 0.25);
    canvas.drawPath(path, stroke);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.36, w * 0.25)
        ..lineTo(w * 0.5, w * 0.14)
        ..lineTo(w * 0.64, w * 0.25),
      thinStroke,
    );
    for (final p in [
      Offset(w * 0.42, w * 0.45),
      Offset(w * 0.58, w * 0.45),
      Offset(w * 0.5, w * 0.62),
    ]) {
      canvas.drawCircle(p, w * 0.018, thinStroke);
    }
  }

  void _drawWatermelon(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke,
  ) {
    final w = size.width;
    final rect = Rect.fromLTWH(w * 0.18, w * 0.3, w * 0.64, w * 0.48);
    canvas.drawArc(rect, 0, math.pi, false, stroke);
    canvas.drawLine(
      Offset(w * 0.18, w * 0.54),
      Offset(w * 0.82, w * 0.54),
      stroke,
    );
    canvas.drawArc(
      Rect.fromLTWH(w * 0.28, w * 0.36, w * 0.44, w * 0.28),
      0,
      math.pi,
      false,
      thinStroke,
    );
    for (final p in [Offset(w * 0.42, w * 0.45), Offset(w * 0.55, w * 0.43)]) {
      canvas.drawCircle(p, w * 0.018, thinStroke);
    }
  }

  void _drawLeaf(Canvas canvas, double w, Offset origin, Paint stroke) {
    final path = Path()
      ..moveTo(origin.dx, origin.dy)
      ..quadraticBezierTo(
        origin.dx + w * 0.12,
        origin.dy - w * 0.08,
        origin.dx + w * 0.22,
        origin.dy + w * 0.02,
      )
      ..quadraticBezierTo(
        origin.dx + w * 0.1,
        origin.dy + w * 0.1,
        origin.dx,
        origin.dy,
      );
    canvas.drawPath(path, stroke);
  }

  void _drawPineapple(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke,
  ) {
    final w = size.width;
    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.32, w * 0.28, w * 0.36, w * 0.56),
      Radius.circular(w * 0.18),
    );
    canvas.drawRRect(body, stroke);
    for (final x in [0.39, 0.5, 0.61]) {
      canvas.drawLine(
        Offset(w * x, w * 0.36),
        Offset(w * (x - 0.12), w * 0.72),
        thinStroke,
      );
      canvas.drawLine(
        Offset(w * (x - 0.12), w * 0.36),
        Offset(w * x, w * 0.72),
        thinStroke,
      );
    }
    for (final leaf in [
      [0.5, 0.28, 0.5, 0.08],
      [0.48, 0.3, 0.34, 0.14],
      [0.52, 0.3, 0.66, 0.14],
    ]) {
      canvas.drawLine(
        Offset(w * leaf[0], w * leaf[1]),
        Offset(w * leaf[2], w * leaf[3]),
        thinStroke,
      );
    }
  }

  void _drawKiwi(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke,
    Paint fill,
  ) {
    final w = size.width;
    final center = Offset(w * 0.5, w * 0.52);
    canvas.drawCircle(center, w * 0.28, fill);
    canvas.drawCircle(center, w * 0.28, stroke);
    canvas.drawCircle(center, w * 0.08, thinStroke);
    for (var i = 0; i < 10; i++) {
      final angle = math.pi * 2 * i / 10;
      canvas.drawCircle(
        center + Offset(math.cos(angle), math.sin(angle)) * w * 0.17,
        w * 0.012,
        thinStroke,
      );
    }
  }

  void _drawPeach(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke,
    Paint fill,
  ) {
    final w = size.width;
    final path = Path()
      ..moveTo(w * 0.5, w * 0.24)
      ..cubicTo(w * 0.2, w * 0.18, w * 0.17, w * 0.62, w * 0.5, w * 0.84)
      ..cubicTo(w * 0.83, w * 0.62, w * 0.8, w * 0.18, w * 0.5, w * 0.24);
    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
    canvas.drawLine(
      Offset(w * 0.5, w * 0.28),
      Offset(w * 0.52, w * 0.76),
      thinStroke,
    );
    _drawLeaf(canvas, w, Offset(w * 0.57, w * 0.22), thinStroke);
  }

  void _drawCherry(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    canvas.drawCircle(Offset(w * 0.4, w * 0.65), w * 0.14, stroke);
    canvas.drawCircle(Offset(w * 0.62, w * 0.68), w * 0.14, stroke);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.4, w * 0.5)
        ..quadraticBezierTo(w * 0.44, w * 0.24, w * 0.62, w * 0.22)
        ..moveTo(w * 0.62, w * 0.54)
        ..quadraticBezierTo(w * 0.56, w * 0.3, w * 0.62, w * 0.22),
      thinStroke,
    );
    _drawLeaf(canvas, w, Offset(w * 0.68, w * 0.22), thinStroke);
  }

  void _drawAvocado(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke,
    Paint fill,
  ) {
    final w = size.width;
    final path = Path()
      ..moveTo(w * 0.5, w * 0.17)
      ..cubicTo(w * 0.24, w * 0.26, w * 0.22, w * 0.68, w * 0.5, w * 0.84)
      ..cubicTo(w * 0.78, w * 0.68, w * 0.76, w * 0.26, w * 0.5, w * 0.17);
    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
    canvas.drawCircle(Offset(w * 0.5, w * 0.59), w * 0.12, thinStroke);
  }

  void _drawLettuce(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    for (final x in [0.34, 0.5, 0.66]) {
      canvas.drawOval(
        Rect.fromLTWH(w * (x - 0.14), w * 0.25, w * 0.28, w * 0.5),
        stroke,
      );
    }
    canvas.drawLine(
      Offset(w * 0.24, w * 0.75),
      Offset(w * 0.76, w * 0.75),
      thinStroke,
    );
  }

  void _drawCarrot(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    final path = Path()
      ..moveTo(w * 0.37, w * 0.32)
      ..lineTo(w * 0.72, w * 0.43)
      ..lineTo(w * 0.3, w * 0.86)
      ..close();
    canvas.drawPath(path, stroke);
    canvas.drawLine(
      Offset(w * 0.42, w * 0.46),
      Offset(w * 0.55, w * 0.5),
      thinStroke,
    );
    canvas.drawLine(
      Offset(w * 0.51, w * 0.24),
      Offset(w * 0.5, w * 0.1),
      thinStroke,
    );
    canvas.drawLine(
      Offset(w * 0.52, w * 0.25),
      Offset(w * 0.66, w * 0.14),
      thinStroke,
    );
    canvas.drawLine(
      Offset(w * 0.5, w * 0.25),
      Offset(w * 0.36, w * 0.14),
      thinStroke,
    );
  }

  void _drawCucumber(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    final rect = Rect.fromLTWH(w * 0.16, w * 0.38, w * 0.68, w * 0.24);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(w * 0.18)),
      stroke,
    );
    for (final x in [0.34, 0.5, 0.66]) {
      canvas.drawCircle(Offset(w * x, w * 0.5), w * 0.018, thinStroke);
    }
  }

  void _drawPepper(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    final path = Path()
      ..moveTo(w * 0.5, w * 0.24)
      ..cubicTo(w * 0.2, w * 0.22, w * 0.2, w * 0.72, w * 0.42, w * 0.78)
      ..cubicTo(w * 0.5, w * 0.88, w * 0.58, w * 0.78, w * 0.58, w * 0.78)
      ..cubicTo(w * 0.82, w * 0.72, w * 0.8, w * 0.22, w * 0.5, w * 0.24);
    canvas.drawPath(path, stroke);
    canvas.drawLine(
      Offset(w * 0.5, w * 0.24),
      Offset(w * 0.5, w * 0.12),
      thinStroke,
    );
  }

  void _drawPotato(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    canvas.drawOval(
      Rect.fromLTWH(w * 0.24, w * 0.28, w * 0.52, w * 0.44),
      stroke,
    );
    for (final p in [
      Offset(w * 0.4, w * 0.42),
      Offset(w * 0.56, w * 0.52),
      Offset(w * 0.46, w * 0.61),
    ]) {
      canvas.drawCircle(p, w * 0.018, thinStroke);
    }
  }

  void _drawOnion(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    final path = Path()
      ..moveTo(w * 0.5, w * 0.18)
      ..cubicTo(w * 0.22, w * 0.42, w * 0.25, w * 0.78, w * 0.5, w * 0.86)
      ..cubicTo(w * 0.75, w * 0.78, w * 0.78, w * 0.42, w * 0.5, w * 0.18);
    canvas.drawPath(path, stroke);
    canvas.drawArc(
      Rect.fromLTWH(w * 0.36, w * 0.36, w * 0.28, w * 0.36),
      math.pi * 0.5,
      math.pi,
      false,
      thinStroke,
    );
  }

  void _drawBroccoli(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke,
    Paint fill,
  ) {
    final w = size.width;
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.45, w * 0.82)
        ..lineTo(w * 0.45, w * 0.58)
        ..lineTo(w * 0.35, w * 0.48)
        ..moveTo(w * 0.55, w * 0.82)
        ..lineTo(w * 0.55, w * 0.58)
        ..lineTo(w * 0.65, w * 0.48),
      thinStroke,
    );
    for (final c in [
      Offset(w * 0.34, w * 0.38),
      Offset(w * 0.5, w * 0.3),
      Offset(w * 0.66, w * 0.38),
      Offset(w * 0.5, w * 0.48),
    ]) {
      canvas.drawCircle(c, w * 0.13, fill);
      canvas.drawCircle(c, w * 0.13, stroke);
    }
  }

  void _drawMushroom(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    canvas.drawArc(
      Rect.fromLTWH(w * 0.2, w * 0.25, w * 0.6, w * 0.42),
      math.pi,
      math.pi,
      false,
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.22, w * 0.46),
      Offset(w * 0.78, w * 0.46),
      stroke,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.42, w * 0.46, w * 0.16, w * 0.32),
        Radius.circular(w * 0.08),
      ),
      stroke,
    );
    canvas.drawCircle(Offset(w * 0.42, w * 0.36), w * 0.018, thinStroke);
    canvas.drawCircle(Offset(w * 0.58, w * 0.36), w * 0.018, thinStroke);
  }

  void _drawGarlic(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    for (final x in [0.36, 0.5, 0.64]) {
      canvas.drawOval(
        Rect.fromLTWH(w * (x - 0.12), w * 0.34, w * 0.24, w * 0.42),
        stroke,
      );
    }
    canvas.drawLine(
      Offset(w * 0.5, w * 0.34),
      Offset(w * 0.5, w * 0.16),
      thinStroke,
    );
  }

  void _drawCorn(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    canvas.drawOval(
      Rect.fromLTWH(w * 0.36, w * 0.18, w * 0.28, w * 0.64),
      stroke,
    );
    for (final y in [0.34, 0.48, 0.62]) {
      canvas.drawLine(
        Offset(w * 0.4, w * y),
        Offset(w * 0.6, w * y),
        thinStroke,
      );
    }
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.36, w * 0.55)
        ..lineTo(w * 0.18, w * 0.78)
        ..moveTo(w * 0.64, w * 0.55)
        ..lineTo(w * 0.82, w * 0.78),
      thinStroke,
    );
  }

  void _drawTomato(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke,
    Paint fill,
  ) {
    final w = size.width;
    canvas.drawCircle(Offset(w * 0.5, w * 0.55), w * 0.28, fill);
    canvas.drawCircle(Offset(w * 0.5, w * 0.55), w * 0.28, stroke);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.5, w * 0.3)
        ..lineTo(w * 0.4, w * 0.18)
        ..moveTo(w * 0.5, w * 0.3)
        ..lineTo(w * 0.6, w * 0.18)
        ..moveTo(w * 0.5, w * 0.3)
        ..lineTo(w * 0.5, w * 0.16),
      thinStroke,
    );
  }

  void _drawBread(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    final path = Path()
      ..moveTo(w * 0.2, w * 0.66)
      ..cubicTo(w * 0.18, w * 0.28, w * 0.82, w * 0.28, w * 0.8, w * 0.66)
      ..quadraticBezierTo(w * 0.8, w * 0.8, w * 0.66, w * 0.8)
      ..lineTo(w * 0.34, w * 0.8)
      ..quadraticBezierTo(w * 0.2, w * 0.8, w * 0.2, w * 0.66);
    canvas.drawPath(path, stroke);
    canvas.drawLine(
      Offset(w * 0.38, w * 0.42),
      Offset(w * 0.34, w * 0.56),
      thinStroke,
    );
    canvas.drawLine(
      Offset(w * 0.55, w * 0.39),
      Offset(w * 0.51, w * 0.54),
      thinStroke,
    );
    canvas.drawLine(
      Offset(w * 0.69, w * 0.44),
      Offset(w * 0.65, w * 0.58),
      thinStroke,
    );
  }

  void _drawCheese(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    final path = Path()
      ..moveTo(w * 0.22, w * 0.72)
      ..lineTo(w * 0.78, w * 0.5)
      ..lineTo(w * 0.22, w * 0.28)
      ..close();
    canvas.drawPath(path, stroke);
    canvas.drawCircle(Offset(w * 0.42, w * 0.53), w * 0.045, thinStroke);
    canvas.drawCircle(Offset(w * 0.57, w * 0.56), w * 0.035, thinStroke);
  }

  void _drawDairyPack(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke, {
    required String label,
  }) {
    final w = size.width;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.22, w * 0.28, w * 0.56, w * 0.46),
        Radius.circular(w * 0.08),
      ),
      stroke,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.28, w * 0.2, w * 0.44, w * 0.16),
        Radius.circular(w * 0.06),
      ),
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.3, w * 0.48),
      Offset(w * 0.7, w * 0.48),
      thinStroke,
    );
    canvas.drawLine(
      Offset(w * 0.34, w * 0.62),
      Offset(w * 0.66, w * 0.62),
      thinStroke,
    );
    _drawLabel(canvas, size, label, w * 0.24);
  }

  void _drawEgg(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    canvas.drawOval(
      Rect.fromLTWH(w * 0.31, w * 0.18, w * 0.38, w * 0.64),
      stroke,
    );
    canvas.drawOval(
      Rect.fromLTWH(w * 0.39, w * 0.42, w * 0.22, w * 0.18),
      thinStroke,
    );
  }

  void _drawFish(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    final body = Path()
      ..moveTo(w * 0.22, w * 0.5)
      ..cubicTo(w * 0.42, w * 0.24, w * 0.66, w * 0.32, w * 0.78, w * 0.5)
      ..cubicTo(w * 0.66, w * 0.68, w * 0.42, w * 0.76, w * 0.22, w * 0.5);
    canvas.drawPath(body, stroke);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.78, w * 0.5)
        ..lineTo(w * 0.9, w * 0.36)
        ..lineTo(w * 0.9, w * 0.64)
        ..close(),
      stroke,
    );
    canvas.drawCircle(Offset(w * 0.38, w * 0.45), w * 0.018, thinStroke);
  }

  void _drawPasta(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    canvas.drawArc(
      Rect.fromLTWH(w * 0.2, w * 0.28, w * 0.6, w * 0.48),
      0,
      math.pi,
      false,
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.2, w * 0.52),
      Offset(w * 0.8, w * 0.52),
      stroke,
    );
    for (final x in [0.33, 0.44, 0.55, 0.66]) {
      canvas.drawLine(
        Offset(w * x, w * 0.26),
        Offset(w * x + w * 0.04, w * 0.52),
        thinStroke,
      );
    }
  }

  void _drawRice(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    _drawBag(canvas, size, stroke, thinStroke, label: 'R');
    for (final p in [
      Offset(w * 0.34, w * 0.73),
      Offset(w * 0.48, w * 0.68),
      Offset(w * 0.62, w * 0.73),
    ]) {
      canvas.drawOval(
        Rect.fromCenter(center: p, width: w * 0.1, height: w * 0.045),
        thinStroke,
      );
    }
  }

  void _drawBag(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke, {
    required String label,
  }) {
    final w = size.width;
    final rect = Rect.fromLTWH(w * 0.26, w * 0.18, w * 0.48, w * 0.64);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(w * 0.06)),
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.32, w * 0.32),
      Offset(w * 0.68, w * 0.32),
      thinStroke,
    );
    canvas.drawLine(
      Offset(w * 0.32, w * 0.66),
      Offset(w * 0.68, w * 0.66),
      thinStroke,
    );
    _drawLabel(canvas, size, label, w * 0.32);
  }

  void _drawBox(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke, {
    required String label,
  }) {
    final w = size.width;
    final rect = Rect.fromLTWH(w * 0.22, w * 0.3, w * 0.56, w * 0.38);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(w * 0.06)),
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.28, w * 0.42),
      Offset(w * 0.72, w * 0.42),
      thinStroke,
    );
    _drawLabel(canvas, size, label, w * 0.23);
  }

  void _drawJar(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke, {
    required String label,
  }) {
    final w = size.width;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.32, w * 0.24, w * 0.36, w * 0.58),
        Radius.circular(w * 0.08),
      ),
      stroke,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.36, w * 0.15, w * 0.28, w * 0.13),
        Radius.circular(w * 0.04),
      ),
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.36, w * 0.48),
      Offset(w * 0.64, w * 0.48),
      thinStroke,
    );
    _drawLabel(canvas, size, label, w * 0.2);
  }

  void _drawSnack(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke, {
    required bool chocolate,
  }) {
    final w = size.width;
    if (chocolate) {
      final rect = Rect.fromLTWH(w * 0.24, w * 0.28, w * 0.52, w * 0.44);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(w * 0.04)),
        stroke,
      );
      for (final x in [0.41, 0.58]) {
        canvas.drawLine(
          Offset(w * x, w * 0.3),
          Offset(w * x, w * 0.7),
          thinStroke,
        );
      }
      canvas.drawLine(
        Offset(w * 0.26, w * 0.5),
        Offset(w * 0.74, w * 0.5),
        thinStroke,
      );
      return;
    }

    final bag = Path()
      ..moveTo(w * 0.3, w * 0.18)
      ..lineTo(w * 0.7, w * 0.25)
      ..lineTo(w * 0.66, w * 0.82)
      ..lineTo(w * 0.26, w * 0.75)
      ..close();
    canvas.drawPath(bag, stroke);
    canvas.drawLine(
      Offset(w * 0.34, w * 0.38),
      Offset(w * 0.66, w * 0.43),
      thinStroke,
    );
    canvas.drawLine(
      Offset(w * 0.32, w * 0.62),
      Offset(w * 0.64, w * 0.67),
      thinStroke,
    );
  }

  void _drawPretzelSticks(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke,
  ) {
    final w = size.width;
    final cup = Path()
      ..moveTo(w * 0.24, w * 0.32)
      ..lineTo(w * 0.76, w * 0.32)
      ..lineTo(w * 0.68, w * 0.82)
      ..lineTo(w * 0.32, w * 0.82)
      ..close();
    canvas.drawPath(cup, stroke);
    for (final x in [0.36, 0.47, 0.58, 0.69]) {
      canvas.drawLine(
        Offset(w * x, w * 0.16),
        Offset(w * (x - 0.08), w * 0.68),
        thinStroke,
      );
    }
    canvas.drawLine(
      Offset(w * 0.3, w * 0.48),
      Offset(w * 0.7, w * 0.48),
      thinStroke,
    );
  }

  void _drawToothpaste(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke,
  ) {
    final w = size.width;
    final tube = Path()
      ..moveTo(w * 0.18, w * 0.58)
      ..lineTo(w * 0.62, w * 0.34)
      ..lineTo(w * 0.78, w * 0.5)
      ..lineTo(w * 0.34, w * 0.76)
      ..close();
    canvas.drawPath(tube, stroke);
    canvas.drawLine(
      Offset(w * 0.3, w * 0.58),
      Offset(w * 0.62, w * 0.4),
      thinStroke,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.72, w * 0.42, w * 0.14, w * 0.16),
        Radius.circular(w * 0.03),
      ),
      thinStroke,
    );
  }

  void _drawToothbrush(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke,
  ) {
    final w = size.width;
    canvas.drawLine(
      Offset(w * 0.22, w * 0.78),
      Offset(w * 0.72, w * 0.28),
      stroke,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.64, w * 0.18, w * 0.22, w * 0.16),
        Radius.circular(w * 0.04),
      ),
      stroke,
    );
    for (final x in [0.68, 0.74, 0.8]) {
      canvas.drawLine(
        Offset(w * x, w * 0.18),
        Offset(w * x, w * 0.08),
        thinStroke,
      );
    }
    canvas.drawCircle(Offset(w * 0.34, w * 0.66), w * 0.018, thinStroke);
  }

  void _drawSalt(Canvas canvas, Size size, Paint stroke, Paint thinStroke) {
    final w = size.width;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.34, w * 0.26, w * 0.32, w * 0.5),
        Radius.circular(w * 0.08),
      ),
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.36, w * 0.36),
      Offset(w * 0.64, w * 0.36),
      thinStroke,
    );
    for (final x in [0.43, 0.5, 0.57]) {
      canvas.drawCircle(Offset(w * x, w * 0.27), w * 0.015, thinStroke);
    }
  }

  void _drawNuts(
    Canvas canvas,
    Size size,
    Paint stroke,
    Paint thinStroke,
    Paint fill,
  ) {
    final w = size.width;
    for (final rect in [
      Rect.fromLTWH(w * 0.22, w * 0.38, w * 0.25, w * 0.32),
      Rect.fromLTWH(w * 0.43, w * 0.28, w * 0.28, w * 0.36),
      Rect.fromLTWH(w * 0.56, w * 0.5, w * 0.22, w * 0.28),
    ]) {
      canvas.drawOval(rect, fill);
      canvas.drawOval(rect, stroke);
    }
    canvas.drawLine(
      Offset(w * 0.5, w * 0.35),
      Offset(w * 0.58, w * 0.56),
      thinStroke,
    );
  }

  void _drawLabel(Canvas canvas, Size size, String label, double fontSize) {
    if (label.isEmpty) {
      return;
    }
    final painter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          letterSpacing: 0,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);
    painter.paint(
      canvas,
      Offset(
        (size.width - painter.width) / 2,
        (size.height - painter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(_DrawnItemIconPainter oldDelegate) {
    return iconKey != oldDelegate.iconKey || color != oldDelegate.color;
  }
}

class GeneratedItemIcon extends StatelessWidget {
  const GeneratedItemIcon({
    super.key,
    required this.name,
    required this.variant,
    required this.size,
    required this.color,
  });

  final String name;
  final int variant;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _GeneratedItemIconPainter(
        label: _labelForName(name),
        variant: variant,
        color: color,
        accent: generatedIconAccent(name, variant),
      ),
    );
  }

  String _labelForName(String value) {
    final words = normalizeIconSearchText(
      value,
    ).split(RegExp(r'\s+')).where((word) => word.isNotEmpty).toList();
    if (words.isEmpty) {
      return '?';
    }
    if (words.length == 1) {
      return words.first.substring(0, math.min(2, words.first.length));
    }
    return '${words.first[0]}${words[1][0]}';
  }
}

class _GeneratedItemIconPainter extends CustomPainter {
  const _GeneratedItemIconPainter({
    required this.label,
    required this.variant,
    required this.color,
    required this.accent,
  });

  final String label;
  final int variant;
  final Color color;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.07
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final accentStroke = Paint()
      ..color = accent.withValues(alpha: 0.78)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.055
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final inset = size.width * 0.13;
    final rect = Rect.fromLTWH(
      inset,
      inset,
      size.width - inset * 2,
      size.height - inset * 2,
    );

    switch (variant % 6) {
      case 0:
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(size.width * 0.2)),
          stroke,
        );
        canvas.drawLine(rect.topLeft, rect.bottomRight, accentStroke);
        break;
      case 1:
        canvas.drawCircle(size.center(Offset.zero), size.width * 0.34, stroke);
        canvas.drawArc(
          rect,
          math.pi * 0.1,
          math.pi * 0.85,
          false,
          accentStroke,
        );
        break;
      case 2:
        final path = Path()
          ..moveTo(size.width * 0.5, size.height * 0.13)
          ..lineTo(size.width * 0.86, size.height * 0.78)
          ..lineTo(size.width * 0.14, size.height * 0.78)
          ..close();
        canvas.drawPath(path, stroke);
        canvas.drawLine(
          Offset(size.width * 0.3, size.height * 0.48),
          Offset(size.width * 0.7, size.height * 0.48),
          accentStroke,
        );
        break;
      case 3:
        canvas.drawOval(rect, stroke);
        canvas.drawLine(
          Offset(size.width * 0.5, size.height * 0.15),
          Offset(size.width * 0.5, size.height * 0.85),
          accentStroke,
        );
        break;
      case 4:
        final path = Path()
          ..moveTo(size.width * 0.5, size.height * 0.1)
          ..lineTo(size.width * 0.82, size.height * 0.35)
          ..lineTo(size.width * 0.7, size.height * 0.82)
          ..lineTo(size.width * 0.3, size.height * 0.82)
          ..lineTo(size.width * 0.18, size.height * 0.35)
          ..close();
        canvas.drawPath(path, stroke);
        canvas.drawCircle(
          size.center(Offset.zero),
          size.width * 0.1,
          accentStroke,
        );
        break;
      default:
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(size.width * 0.08)),
          stroke,
        );
        canvas.drawCircle(
          size.center(Offset.zero),
          size.width * 0.18,
          accentStroke,
        );
    }

    final textPainter = TextPainter(
      text: TextSpan(
        text: label.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: size.width * 0.28,
          fontWeight: FontWeight.w900,
          letterSpacing: 0,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(_GeneratedItemIconPainter oldDelegate) {
    return label != oldDelegate.label ||
        variant != oldDelegate.variant ||
        color != oldDelegate.color ||
        accent != oldDelegate.accent;
  }
}
