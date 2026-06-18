import 'package:flutter/material.dart';

import '../icons/item_icon_catalog.dart';
import '../l10n/app_strings.dart';
import '../models/shopping_list.dart';

class EditItemDialogResult {
  const EditItemDialogResult.save(this.item) : delete = false;

  const EditItemDialogResult.delete() : item = null, delete = true;

  final ShoppingItem? item;
  final bool delete;
}

Future<EditItemDialogResult?> showEditItemDialog({
  required BuildContext context,
  required ShoppingItem item,
}) {
  return showDialog<EditItemDialogResult>(
    context: context,
    builder: (context) => _EditItemDialog(item: item),
  );
}

class _EditItemDialog extends StatefulWidget {
  const _EditItemDialog({required this.item});

  final ShoppingItem item;

  @override
  State<_EditItemDialog> createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<_EditItemDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _amountController;
  late final TextEditingController _noteController;
  late final TextEditingController _iconSearchController;
  late String _iconKey;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _nameController.addListener(_refreshGeneratedPreview);
    _amountController = TextEditingController(text: widget.item.amount);
    _noteController = TextEditingController(text: widget.item.note);
    _iconSearchController = TextEditingController()
      ..addListener(_refreshGeneratedPreview);
    _iconKey = widget.item.icon.trim().isEmpty
        ? suggestIconKey(widget.item.name)
        : widget.item.icon;
  }

  @override
  void dispose() {
    _nameController.removeListener(_refreshGeneratedPreview);
    _nameController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    _iconSearchController
      ..removeListener(_refreshGeneratedPreview)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final colors = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(strings.editItem),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(labelText: strings.itemName),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(labelText: strings.amount),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _noteController,
                decoration: InputDecoration(labelText: strings.note),
                minLines: 1,
                maxLines: 3,
              ),
              const SizedBox(height: 18),
              Text(strings.icon, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              TextField(
                controller: _iconSearchController,
                decoration: InputDecoration(
                  hintText: strings.iconSearchHint,
                  prefixIcon: const Icon(Icons.search_outlined),
                  isDense: true,
                  suffixIcon: _iconSearchController.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: _iconSearchController.clear,
                          icon: const Icon(Icons.close_outlined),
                        ),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final choice in _filteredIconChoices())
                    Tooltip(
                      message: choice.key,
                      child: InkResponse(
                        onTap: () => setState(() => _iconKey = choice.key),
                        radius: 24,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: choice.key == _iconKey
                                ? colors.primaryContainer
                                : colors.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: choice.key == _iconKey
                                  ? colors.primary
                                  : colors.outlineVariant,
                            ),
                          ),
                          child: Center(
                            child: ShoppingItemIcon(
                              iconKey: choice.key,
                              name: _nameController.text,
                              size: 32,
                              color: choice.key == _iconKey
                                  ? colors.onPrimaryContainer
                                  : colors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    ),
                  for (final key in generatedIconKeysFor(_nameController.text))
                    Tooltip(
                      message: key,
                      child: InkResponse(
                        onTap: () => setState(() => _iconKey = key),
                        radius: 24,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: key == _iconKey
                                ? colors.primaryContainer
                                : colors.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: key == _iconKey
                                  ? colors.primary
                                  : colors.outlineVariant,
                            ),
                          ),
                          child: Center(
                            child: ShoppingItemIcon(
                              iconKey: key,
                              name: _nameController.text,
                              size: 32,
                              color: key == _iconKey
                                  ? colors.onPrimaryContainer
                                  : colors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton.icon(
          onPressed: () =>
              Navigator.of(context).pop(const EditItemDialogResult.delete()),
          icon: const Icon(Icons.delete_outline),
          label: Text(strings.delete),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(strings.cancel),
        ),
        FilledButton.icon(
          onPressed: _save,
          icon: const Icon(Icons.check),
          label: Text(strings.save),
        ),
      ],
    );
  }

  List<ItemIconChoice> _filteredIconChoices() {
    final query = normalizeIconSearchText(_iconSearchController.text);
    if (query.isEmpty) {
      return itemIconChoices;
    }
    final terms = query.split(RegExp(r'\s+'));
    return itemIconChoices.where((choice) {
      final haystack = normalizeIconSearchText(
        '${choice.key} ${choice.keywords.join(' ')}',
      );
      return terms.every(haystack.contains);
    }).toList();
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      return;
    }
    Navigator.of(context).pop(
      EditItemDialogResult.save(
        widget.item.copyWith(
          name: name,
          amount: _amountController.text.trim(),
          note: _noteController.text.trim(),
          icon: _iconKey,
        ),
      ),
    );
  }

  void _refreshGeneratedPreview() {
    if (mounted) {
      setState(() {});
    }
  }
}
