import 'package:flutter/material.dart';

import '../icons/item_icon_catalog.dart';
import '../models/shopping_list.dart';

class ShoppingItemTile extends StatelessWidget {
  const ShoppingItemTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.onLongPress,
  });

  final ShoppingItem item;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final isOpen = item.state == ShoppingItemState.open;
    final colors = Theme.of(context).colorScheme;
    final background = isOpen
        ? (Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF6F2B24)
              : const Color(0xFFFFE0D6))
        : (Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF124A41)
              : const Color(0xFFD8F2EA));
    final foreground = isOpen
        ? (Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFFFFD5CA)
              : const Color(0xFF6D2A1F))
        : (Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFFAEE7D8)
              : const Color(0xFF0F4A40));

    return Semantics(
      button: true,
      label: item.name,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconForShoppingItem(iconKey: item.icon, name: item.name),
                  size: 30,
                  color: foreground,
                ),
                const SizedBox(height: 6),
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (item.amount.trim().isNotEmpty) ...[
                  const SizedBox(height: 4),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.surface.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      child: Text(
                        item.amount,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: foreground,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
