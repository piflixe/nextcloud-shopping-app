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
  ItemIconChoice('cheese', Icons.lunch_dining_outlined, ['cheese', 'kaese']),
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
  final normalized = normalizeIconSearchText(name);
  final words = normalized.split(RegExp(r'\s+')).toSet();
  for (final choice in itemIconChoices) {
    if (choice.key == 'default') {
      continue;
    }
    if (choice.keywords.any(
      (keyword) => keyword.length <= 2
          ? words.contains(keyword)
          : normalized.contains(keyword),
    )) {
      return choice.key;
    }
  }
  return '${generatedIconPrefix}0';
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
  'chips',
  'canned',
  'tofu',
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
      case 'water_bottle':
      case 'oil':
        _drawBottle(canvas, size, stroke, thinStroke, oil: iconKey == 'oil');
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
