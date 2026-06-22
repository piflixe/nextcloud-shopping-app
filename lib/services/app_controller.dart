import 'dart:async';

import 'package:flutter/foundation.dart';

import '../icons/item_icon_catalog.dart';
import '../models/shopping_list.dart';
import '../models/shopping_list_store.dart';
import 'shopping_repository.dart';

enum SyncState { localOnly, synced, pending, syncing, error }

class AppController extends ChangeNotifier {
  AppController(this._repository)
    : _list = _repository.loadActiveList(),
      _lists = _repository.lists,
      _activeProfile = _repository.activeProfile,
      _languageCode = _repository.languageCode,
      _autoSyncEnabled = _repository.autoSyncEnabled,
      _autoSyncDelaySeconds = _repository.autoSyncDelaySeconds;

  final ShoppingRepository _repository;

  ShoppingListData _list;
  List<ShoppingListProfile> _lists;
  ShoppingListProfile _activeProfile;
  String? _languageCode;
  String? _message;
  bool _isBusy = false;
  bool _autoSyncEnabled;
  int _autoSyncDelaySeconds;
  bool _hasPendingSync = false;
  bool _isSyncing = false;
  String? _syncError;
  Timer? _syncTimer;

  ShoppingListData get list => _list;

  List<ShoppingListProfile> get lists => _lists;

  ShoppingListProfile get activeProfile => _activeProfile;

  String get activeListName => _activeProfile.name;

  String get activeLocalFileName => _activeProfile.localFileName;

  String? get linkedDocumentName => _activeProfile.hasLinkedStorage
      ? _activeProfile.displayStorageName
      : null;

  String? get languageCode => _languageCode;

  String? get message => _message;

  bool get isBusy => _isBusy || _isSyncing;

  bool get isSyncing => _isSyncing;

  bool get autoSyncEnabled => _autoSyncEnabled;

  int get autoSyncDelaySeconds => _autoSyncDelaySeconds;

  String? get syncError => _syncError;

  bool get hasLinkedDocument => _activeProfile.hasLinkedStorage;

  List<String> get storeSuggestions {
    final stores = _list.items
        .map((item) => item.note.trim())
        .where((store) => store.isNotEmpty)
        .toSet()
        .toList();
    stores.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return stores;
  }

  SyncState get syncState {
    if (!hasLinkedDocument) {
      return SyncState.localOnly;
    }
    if (_isSyncing) {
      return SyncState.syncing;
    }
    if (_syncError != null) {
      return SyncState.error;
    }
    if (_hasPendingSync) {
      return SyncState.pending;
    }
    return SyncState.synced;
  }

  void disposeController() {
    _syncTimer?.cancel();
  }

  void clearMessage() {
    _message = null;
    notifyListeners();
  }

  Future<void> setLanguageCode(String? code) async {
    _languageCode = code;
    notifyListeners();
    await _repository.setLanguageCode(code);
  }

  Future<void> setAutoSyncEnabled(bool enabled) async {
    _autoSyncEnabled = enabled;
    if (!enabled) {
      _syncTimer?.cancel();
    } else if (_hasPendingSync) {
      _scheduleAutoSync();
    }
    notifyListeners();
    await _repository.setAutoSyncEnabled(enabled);
  }

  Future<void> setAutoSyncDelaySeconds(int seconds) async {
    final clamped = seconds.clamp(10, 600);
    _autoSyncDelaySeconds = clamped;
    if (_autoSyncEnabled && _hasPendingSync) {
      _scheduleAutoSync();
    }
    notifyListeners();
    await _repository.setAutoSyncDelaySeconds(clamped);
  }

  Future<void> switchList(String id) async {
    if (id == _activeProfile.id) {
      return;
    }
    await flushPendingSync();
    await _runBusy(() async {
      _list = await _repository.switchList(id);
      _refreshProfiles();
      _resetSyncState();
    });
  }

  Future<void> createList(String name) async {
    await flushPendingSync();
    await _runBusy(() async {
      _list = await _repository.createList(name);
      _refreshProfiles();
      _resetSyncState();
    });
  }

  Future<void> renameActiveList(String name) async {
    await flushPendingSync();
    await _runBusy(() async {
      _list = await _repository.renameActiveList(name);
      _refreshProfiles();
      _resetSyncState();
    });
  }

  Future<void> linkActiveListToFolder() async {
    await _runBusy(() async {
      final loaded = await _repository.linkActiveListToFolder();
      if (loaded == null) {
        return;
      }
      _list = loaded;
      _refreshProfiles();
      _resetSyncState();
    });
  }

  Future<void> reloadDocument() async {
    await _runBusy(() async {
      _list = await _repository.reloadActiveLinkedList();
      _refreshProfiles();
      _resetSyncState();
    });
  }

  Future<void> unlinkDocument() async {
    _syncTimer?.cancel();
    await _repository.unlinkActiveListStorage();
    _refreshProfiles();
    _resetSyncState();
    notifyListeners();
  }

  Future<void> flushPendingSync() async {
    if (!_hasPendingSync || !hasLinkedDocument) {
      return;
    }
    await syncNow();
  }

  Future<void> syncNow() async {
    if (!hasLinkedDocument || _isSyncing) {
      return;
    }
    _syncTimer?.cancel();
    _isSyncing = true;
    _message = null;
    notifyListeners();
    try {
      await _repository.syncActiveList(_list);
      _hasPendingSync = false;
      _syncError = null;
    } catch (error) {
      _syncError = error.toString();
      _message = _syncError;
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
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
                  order: destination == ShoppingItemState.open
                      ? _defaultOrderFor(destination, candidate.icon)
                      : _nextOrder(destination),
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

    final icon = suggestIconKey(name);
    final item = ShoppingItem(
      id: _createId(name),
      name: name,
      amount: '',
      note: '',
      icon: icon,
      order: _defaultOrderFor(ShoppingItemState.open, icon),
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

  Future<void> moveItem({
    required ShoppingItem item,
    required ShoppingItemState destinationState,
    required String destinationStore,
    ShoppingItem? beforeItem,
  }) async {
    if (beforeItem?.id == item.id &&
        item.state == destinationState &&
        item.note.trim() == destinationStore.trim()) {
      return;
    }

    final moved = item.copyWith(
      state: destinationState,
      note: destinationStore.trim(),
    );
    final destinationItems = _orderedItemsForState(
      destinationState,
    ).where((candidate) => candidate.id != item.id).toList();
    final insertIndex = beforeItem == null
        ? destinationItems.length
        : destinationItems.indexWhere(
            (candidate) => candidate.id == beforeItem.id,
          );
    destinationItems.insert(
      insertIndex < 0 ? destinationItems.length : insertIndex,
      moved,
    );

    final normalizedDestinationItems = <String, ShoppingItem>{
      for (var i = 0; i < destinationItems.length; i++)
        destinationItems[i].id: destinationItems[i].copyWith(order: i),
    };
    final updated = _list.items.map((candidate) {
      return normalizedDestinationItems[candidate.id] ?? candidate;
    }).toList();
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

  List<ShoppingItem> searchItems(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return _list.items;
    }
    final terms = normalized.split(RegExp(r'\s+'));
    return _list.items.where((item) {
      final haystack = '${item.name} ${item.amount} ${item.note} ${item.icon}'
          .toLowerCase();
      return terms.every(haystack.contains);
    }).toList();
  }

  int _nextOrder(ShoppingItemState state) {
    final sameState = _list.items.where((item) => item.state == state);
    if (sameState.isEmpty) {
      return 0;
    }
    return sameState.map((item) => item.order).reduce((a, b) => a > b ? a : b) +
        1;
  }

  int _defaultOrderFor(ShoppingItemState state, String iconKey) {
    if (state != ShoppingItemState.open) {
      return _nextOrder(state);
    }
    final rank = supermarketOrderForIcon(iconKey);
    final rankBase = rank * 1000;
    final sameRankOrders = _list.items
        .where((item) => item.state == state)
        .where((item) => supermarketOrderForIcon(item.icon) == rank)
        .map((item) => item.order)
        .where((order) => order >= rankBase && order < rankBase + 1000);
    if (sameRankOrders.isEmpty) {
      return rankBase;
    }
    return sameRankOrders.reduce((a, b) => a > b ? a : b) + 1;
  }

  List<ShoppingItem> _orderedItemsForState(ShoppingItemState state) {
    final items = _list.items.where((item) => item.state == state).toList();
    items.sort((a, b) {
      final orderCompare = a.order.compareTo(b.order);
      if (orderCompare != 0) {
        return orderCompare;
      }
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    return items;
  }

  Future<void> _save(ShoppingListData nextList) async {
    _list = nextList;
    _syncError = null;
    if (hasLinkedDocument) {
      _hasPendingSync = true;
    }
    notifyListeners();
    try {
      await _repository.saveLocalActiveList(nextList);
      if (_autoSyncEnabled && hasLinkedDocument) {
        _scheduleAutoSync();
      }
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

  void _scheduleAutoSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer(Duration(seconds: _autoSyncDelaySeconds), () {
      syncNow();
    });
  }

  void _refreshProfiles() {
    _lists = _repository.lists;
    _activeProfile = _repository.activeProfile;
  }

  void _resetSyncState() {
    _syncTimer?.cancel();
    _hasPendingSync = false;
    _isSyncing = false;
    _syncError = null;
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
