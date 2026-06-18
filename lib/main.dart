import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/app_strings.dart';
import 'models/shopping_list.dart';
import 'models/shopping_list_store.dart';
import 'services/app_controller.dart';
import 'services/shopping_repository.dart';
import 'widgets/edit_item_dialog.dart';
import 'widgets/shopping_item_tile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final preferences = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: ShoppingRepository.preferenceKeys,
    ),
  );
  final repository = ShoppingRepository(preferences: preferences);
  await repository.initialize();
  runApp(ShoppingApp(controller: AppController(repository)));
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key, required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return MaterialApp(
          title: 'Shopping list',
          debugShowCheckedModeBanner: false,
          locale: controller.languageCode == null
              ? null
              : Locale(controller.languageCode!),
          supportedLocales: AppStrings.supportedLocales,
          localizationsDelegates: const [
            AppStrings.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          themeMode: ThemeMode.system,
          theme: _buildTheme(Brightness.light),
          darkTheme: _buildTheme(Brightness.dark),
          home: ShoppingHomePage(controller: controller),
        );
      },
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF21736B),
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      cardTheme: const CardThemeData(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}

class ShoppingHomePage extends StatefulWidget {
  const ShoppingHomePage({super.key, required this.controller});

  final AppController controller;

  @override
  State<ShoppingHomePage> createState() => _ShoppingHomePageState();
}

class _ShoppingHomePageState extends State<ShoppingHomePage> {
  final TextEditingController _addController = TextEditingController();
  String? _lastShownMessage;

  AppController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(_LifecycleSyncObserver(controller));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_LifecycleSyncObserver(controller));
    _addController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        _showMessageIfNeeded(context);
        final strings = AppStrings.of(context);
        return Scaffold(
          appBar: AppBar(
            title: _ListTitleButton(
              controller: controller,
              onPressed: () => _showListSwitcher(context),
            ),
            actions: [
              IconButton(
                onPressed: () => _showSearch(context),
                tooltip: strings.search,
                icon: const Icon(Icons.search_outlined),
              ),
              IconButton(
                onPressed: () => _showSettings(context),
                tooltip: strings.settings,
                icon: const Icon(Icons.settings_outlined),
              ),
            ],
          ),
          body: Column(
            children: [
              if (controller.isBusy) const LinearProgressIndicator(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                  children: [
                    _ItemSection(
                      title: strings.openItems,
                      emptyText: strings.noOpenItems,
                      items: controller.list.openItems,
                      onTap: controller.toggleItem,
                      onLongPress: _editItem,
                    ),
                    const SizedBox(height: 22),
                    _ItemSection(
                      title: strings.lastUsed,
                      emptyText: strings.noLastUsedItems,
                      items: controller.list.lastUsedItems,
                      onTap: controller.toggleItem,
                      onLongPress: _editItem,
                    ),
                  ],
                ),
              ),
              _AddItemBar(
                controller: controller,
                textController: _addController,
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSearch(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ShoppingSearchPage(controller: controller),
      ),
    );
  }

  void _showMessageIfNeeded(BuildContext context) {
    final message = controller.message;
    if (message == null || message == _lastShownMessage) {
      return;
    }
    _lastShownMessage = message;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
      controller.clearMessage();
    });
  }

  Future<void> _editItem(ShoppingItem item) async {
    final result = await showEditItemDialog(context: context, item: item);
    if (result == null) {
      return;
    }
    if (result.delete) {
      await controller.removeItem(item);
      return;
    }
    final updatedItem = result.item;
    if (updatedItem != null) {
      await controller.updateItem(updatedItem);
    }
  }

  Future<void> _showListSwitcher(BuildContext context) async {
    final strings = AppStrings.of(context);
    final action = await showDialog<_ListDialogAction>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(strings.lists),
        children: [
          for (final profile in controller.lists)
            _ShoppingListOptionTile(
              profile: profile,
              selected: profile.id == controller.activeProfile.id,
              onTap: () {
                Navigator.of(context).pop(_SwitchListAction(profile.id));
              },
            ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add_outlined),
            title: Text(strings.newList),
            onTap: () => Navigator.of(context).pop(const _CreateListAction()),
          ),
          ListTile(
            leading: const Icon(Icons.drive_file_rename_outline),
            title: Text(strings.renameList),
            onTap: () => Navigator.of(context).pop(const _RenameListAction()),
          ),
        ],
      ),
    );

    if (!context.mounted || action == null) {
      return;
    }

    switch (action) {
      case _SwitchListAction(:final id):
        await controller.switchList(id);
      case _CreateListAction():
        final name = await _showListNameDialog(
          context: context,
          title: strings.newList,
          initialValue: '',
        );
        if (name != null) {
          await controller.createList(name);
        }
      case _RenameListAction():
        final name = await _showListNameDialog(
          context: context,
          title: strings.renameList,
          initialValue: controller.activeListName,
        );
        if (name != null) {
          await controller.renameActiveList(name);
        }
    }
  }

  Future<String?> _showListNameDialog({
    required BuildContext context,
    required String title,
    required String initialValue,
  }) {
    final strings = AppStrings.of(context);
    final textController = TextEditingController(text: initialValue);
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: textController,
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(labelText: strings.listName),
          onSubmitted: (_) {
            Navigator.of(context).pop(textController.text.trim());
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(strings.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(textController.text.trim());
            },
            child: Text(strings.save),
          ),
        ],
      ),
    ).whenComplete(textController.dispose);
  }

  void _showSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SettingsPage(controller: controller),
      ),
    );
  }
}

class _LifecycleSyncObserver extends WidgetsBindingObserver {
  _LifecycleSyncObserver(this.controller);

  final AppController controller;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      controller.flushPendingSync();
    }
  }

  @override
  bool operator ==(Object other) {
    return other is _LifecycleSyncObserver && other.controller == controller;
  }

  @override
  int get hashCode => controller.hashCode;
}

sealed class _ListDialogAction {
  const _ListDialogAction();
}

class _SwitchListAction extends _ListDialogAction {
  const _SwitchListAction(this.id);

  final String id;
}

class _CreateListAction extends _ListDialogAction {
  const _CreateListAction();
}

class _RenameListAction extends _ListDialogAction {
  const _RenameListAction();
}

class _ListTitleButton extends StatelessWidget {
  const _ListTitleButton({required this.controller, required this.onPressed});

  final AppController controller;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: colors.onSurface,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        icon: _SyncStateIcon(controller: controller),
        label: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 260),
          child: Text(
            controller.activeListName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class _SyncStateIcon extends StatelessWidget {
  const _SyncStateIcon({required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final icon = switch (controller.syncState) {
      SyncState.localOnly => Icons.cloud_off_outlined,
      SyncState.synced => Icons.cloud_done_outlined,
      SyncState.pending => Icons.cloud_queue_outlined,
      SyncState.syncing => Icons.cloud_sync_outlined,
      SyncState.error => Icons.cloud_off_outlined,
    };
    final color = controller.syncState == SyncState.error
        ? colors.error
        : colors.onSurfaceVariant;
    return Icon(icon, color: color);
  }
}

class _ShoppingListOptionTile extends StatelessWidget {
  const _ShoppingListOptionTile({
    required this.profile,
    required this.selected,
    required this.onTap,
  });

  final ShoppingListProfile profile;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    return ListTile(
      leading: Icon(
        selected
            ? Icons.radio_button_checked_outlined
            : Icons.radio_button_unchecked_outlined,
      ),
      title: Text(profile.name),
      subtitle: Text(
        profile.hasLinkedStorage
            ? profile.displayStorageName
            : '${strings.localJson}: ${profile.localFileName}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({
    required this.selected,
    required this.title,
    required this.onTap,
  });

  final bool selected;
  final Widget title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        selected
            ? Icons.radio_button_checked_outlined
            : Icons.radio_button_unchecked_outlined,
      ),
      title: title,
      onTap: onTap,
    );
  }
}

class ShoppingSearchPage extends StatefulWidget {
  const ShoppingSearchPage({super.key, required this.controller});

  final AppController controller;

  @override
  State<ShoppingSearchPage> createState() => _ShoppingSearchPageState();
}

class _ShoppingSearchPageState extends State<ShoppingSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  AppController get controller => widget.controller;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    return AnimatedBuilder(
      animation: Listenable.merge([controller, _searchController]),
      builder: (context, _) {
        final results = controller.searchItems(_searchController.text);
        final openItems = results
            .where((item) => item.state == ShoppingItemState.open)
            .toList();
        final lastUsedItems = results
            .where((item) => item.state == ShoppingItemState.lastUsed)
            .toList();
        return Scaffold(
          appBar: AppBar(title: Text(strings.search)),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: strings.searchHint,
                  prefixIcon: const Icon(Icons.search_outlined),
                  suffixIcon: _searchController.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: _searchController.clear,
                          icon: const Icon(Icons.close_outlined),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              if (results.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: Text(strings.noSearchResults)),
                )
              else ...[
                _ItemSection(
                  title: strings.openItems,
                  emptyText: strings.noOpenItems,
                  items: openItems,
                  onTap: controller.toggleItem,
                  onLongPress: _editItem,
                ),
                const SizedBox(height: 22),
                _ItemSection(
                  title: strings.lastUsed,
                  emptyText: strings.noLastUsedItems,
                  items: lastUsedItems,
                  onTap: controller.toggleItem,
                  onLongPress: _editItem,
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Future<void> _editItem(ShoppingItem item) async {
    final result = await showEditItemDialog(context: context, item: item);
    if (result == null) {
      return;
    }
    if (result.delete) {
      await controller.removeItem(item);
      return;
    }
    final updatedItem = result.item;
    if (updatedItem != null) {
      await controller.updateItem(updatedItem);
    }
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final strings = AppStrings.of(context);
        final languageSelection = controller.languageCode ?? 'system';
        return Scaffold(
          appBar: AppBar(title: Text(strings.settings)),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              _SettingsSectionTitle(strings.storage),
              _StorageStatusTile(controller: controller),
              ListTile(
                leading: const Icon(Icons.folder_open_outlined),
                title: Text(strings.chooseFolder),
                subtitle: Text(strings.chooseFolderHint),
                onTap: controller.isBusy
                    ? null
                    : controller.linkActiveListToFolder,
              ),
              ListTile(
                leading: const Icon(Icons.sync_outlined),
                title: Text(strings.syncNow),
                subtitle: Text(strings.syncNowHint),
                onTap: controller.hasLinkedDocument && !controller.isBusy
                    ? controller.syncNow
                    : null,
              ),
              if (controller.hasLinkedDocument)
                ListTile(
                  leading: const Icon(Icons.download_outlined),
                  title: Text(strings.reload),
                  subtitle: Text(strings.reloadHint),
                  onTap: controller.isBusy ? null : controller.reloadDocument,
                ),
              if (controller.hasLinkedDocument)
                ListTile(
                  leading: const Icon(Icons.link_off_outlined),
                  title: Text(strings.unlink),
                  subtitle: Text(strings.unlinkHint),
                  onTap: controller.unlinkDocument,
                ),
              const Divider(height: 28),
              _SettingsSectionTitle(strings.autoSync),
              SwitchListTile(
                secondary: const Icon(Icons.cloud_sync_outlined),
                title: Text(strings.autoSync),
                subtitle: Text(strings.autoSyncHint),
                value: controller.autoSyncEnabled,
                onChanged: controller.setAutoSyncEnabled,
              ),
              ListTile(
                leading: const Icon(Icons.timer_outlined),
                title: Text(strings.syncDelay),
                subtitle: Text(
                  strings.syncDelayValue(controller.autoSyncDelaySeconds),
                ),
              ),
              Slider(
                value: controller.autoSyncDelaySeconds.toDouble(),
                min: 10,
                max: 300,
                divisions: 29,
                label: '${controller.autoSyncDelaySeconds} s',
                onChanged: controller.autoSyncEnabled
                    ? (value) =>
                          controller.setAutoSyncDelaySeconds(value.round())
                    : null,
              ),
              const Divider(height: 28),
              _SettingsSectionTitle(strings.language),
              _LanguageOptionTile(
                selected: languageSelection == 'system',
                title: Text(strings.systemLanguage),
                onTap: () => controller.setLanguageCode(null),
              ),
              _LanguageOptionTile(
                selected: languageSelection == 'de',
                title: Text(strings.german),
                onTap: () => controller.setLanguageCode('de'),
              ),
              _LanguageOptionTile(
                selected: languageSelection == 'en',
                title: Text(strings.english),
                onTap: () => controller.setLanguageCode('en'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SettingsSectionTitle extends StatelessWidget {
  const _SettingsSectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
      ),
    );
  }
}

class _StorageStatusTile extends StatelessWidget {
  const _StorageStatusTile({required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final colors = Theme.of(context).colorScheme;
    final linkedName = controller.linkedDocumentName;
    final title = linkedName == null
        ? strings.localOnly
        : strings.linkedStorage;
    final subtitle =
        linkedName ?? '${strings.localJson}: ${controller.activeLocalFileName}';
    final syncDetail = switch (controller.syncState) {
      SyncState.localOnly => strings.localOnlyHint,
      SyncState.synced => strings.synced,
      SyncState.pending => strings.syncPending,
      SyncState.syncing => strings.syncing,
      SyncState.error => controller.syncError ?? strings.syncError,
    };

    return ListTile(
      leading: _SyncStateIcon(controller: controller),
      title: Text(title),
      subtitle: Text('$subtitle\n$syncDetail'),
      isThreeLine: true,
      textColor: controller.syncState == SyncState.error ? colors.error : null,
    );
  }
}

class _ItemSection extends StatelessWidget {
  const _ItemSection({
    required this.title,
    required this.emptyText,
    required this.items,
    required this.onTap,
    required this.onLongPress,
  });

  final String title;
  final String emptyText;
  final List<ShoppingItem> items;
  final ValueChanged<ShoppingItem> onTap;
  final ValueChanged<ShoppingItem> onLongPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Center(
              child: Text(
                emptyText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return ShoppingItemTile(
                item: item,
                onTap: () => onTap(item),
                onLongPress: () => onLongPress(item),
              );
            },
          ),
      ],
    );
  }
}

class _AddItemBar extends StatelessWidget {
  const _AddItemBar({required this.controller, required this.textController});

  final AppController controller;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Material(
        color: colors.surface,
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
          child: AnimatedBuilder(
            animation: textController,
            builder: (context, _) {
              final suggestions = controller.suggestionsFor(
                textController.text,
              );
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (suggestions.isNotEmpty) ...[
                    Text(
                      strings.chooseSuggestion,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 42,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: suggestions.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final item = suggestions[index];
                          return ActionChip(
                            avatar: const Icon(
                              Icons.history_outlined,
                              size: 18,
                            ),
                            label: Text(item.name),
                            onPressed: () {
                              textController.clear();
                              controller.toggleItem(item);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textController,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: strings.addItemHint,
                            prefixIcon: const Icon(
                              Icons.add_shopping_cart_outlined,
                            ),
                            isDense: true,
                          ),
                          onSubmitted: (_) => _submit(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: _submit,
                        style: FilledButton.styleFrom(
                          fixedSize: const Size(48, 48),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _submit() {
    final text = textController.text;
    textController.clear();
    controller.addOrReactivateItem(text);
  }
}
