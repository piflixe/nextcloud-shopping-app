import 'package:flutter/foundation.dart';

import '../icons/item_icon_catalog.dart';
import '../models/shopping_list.dart';
import 'shopping_repository.dart';

class AppController extends ChangeNotifier {
  AppController(this._repository)
    : _list = _repository.loadLocalList(),
      _linkedDocumentName = _repository.linkedDocumentName,
      _languageCode = _repository.languageCode;

  final ShoppingRepository _repository;

  ShoppingListData _list;
  String? _linkedDocumentName;
  String? _languageCode;
  String? _message;
  bool _isBusy = false;

  ShoppingListData get list => _list;

  String? get linkedDocumentName => _linkedDocumentName;

  String? get languageCode => _languageCode;

  String? get message => _message;

  bool get isBusy => _isBusy;

  bool get hasLinkedDocument => _linkedDocumentName != null;

  void clearMessage() {
    _message = null;
    notifyListeners();
  }

  Future<void> setLanguageCode(String? code) async {
    _languageCode = code;
    notifyListeners();
    await _repository.setLanguageCode(code);
  }

  Future<void> openDocument() async {
    await _runBusy(() async {
      final loaded = await _repository.pickAndLoadDocument();
      if (loaded == null) {
        return;
      }
      _list = loaded;
      _linkedDocumentName = _repository.linkedDocumentName;
    });
  }

  Future<void> reloadDocument() async {
    await _runBusy(() async {
      _list = await _repository.reloadLinkedDocument();
      _linkedDocumentName = _repository.linkedDocumentName;
    });
  }

  Future<void> unlinkDocument() async {
    await _repository.unlinkDocument();
    _linkedDocumentName = null;
    notifyListeners();
  }

  Future<void> toggleItem(ShoppingItem item) async {
    final destination = item.state == ShoppingItemState.open
        ? ShoppingItemState.lastUsed
        : ShoppingItemState.open;
    final updated = _list.items
        .map(
          (candidate) => candidate.id == item.id
              ? candidate.copyWith(
                  state: destination,
                  order: _nextOrder(destination),
                )
              : candidate,
        )
        .toList();
    await _save(_list.touch(updated));
  }

  Future<void> addOrReactivateItem(String rawName) async {
    final name = rawName.trim();
    if (name.isEmpty) {
      return;
    }

    final existing = _list.items
        .where(
          (item) =>
              item.name.toLowerCase() == name.toLowerCase() &&
              item.state == ShoppingItemState.lastUsed,
        )
        .firstOrNull;

    if (existing != null) {
      await toggleItem(existing);
      return;
    }

    final item = ShoppingItem(
      id: _createId(name),
      name: name,
      amount: '',
      note: '',
      icon: suggestIconKey(name),
      order: _nextOrder(ShoppingItemState.open),
      state: ShoppingItemState.open,
    );
    await _save(_list.touch([..._list.items, item]));
  }

  Future<void> updateItem(ShoppingItem item) async {
    final updated = _list.items
        .map((candidate) => candidate.id == item.id ? item : candidate)
        .toList();
    await _save(_list.touch(updated));
  }

  Future<void> removeItem(ShoppingItem item) async {
    final updated = _list.items
        .where((candidate) => candidate.id != item.id)
        .toList();
    await _save(_list.touch(updated));
  }

  List<ShoppingItem> suggestionsFor(String query) {
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) {
      return const [];
    }
    return _list.lastUsedItems
        .where((item) => item.name.toLowerCase().contains(needle))
        .take(5)
        .toList();
  }

  int _nextOrder(ShoppingItemState state) {
    final sameState = _list.items.where((item) => item.state == state);
    if (sameState.isEmpty) {
      return 0;
    }
    return sameState.map((item) => item.order).reduce((a, b) => a > b ? a : b) +
        1;
  }

  Future<void> _save(ShoppingListData nextList) async {
    _list = nextList;
    notifyListeners();
    try {
      await _repository.saveAndSync(nextList);
    } catch (error) {
      _message = error.toString();
      notifyListeners();
    }
  }

  Future<void> _runBusy(Future<void> Function() task) async {
    _isBusy = true;
    _message = null;
    notifyListeners();
    try {
      await task();
    } catch (error) {
      _message = error.toString();
    } finally {
      _isBusy = false;
      notifyListeners();
    }
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
