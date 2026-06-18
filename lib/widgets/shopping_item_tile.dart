import 'package:flutter/material.dart';

import '../icons/item_icon_catalog.dart';
import '../models/shopping_list.dart';
import 'auto_fit_text.dart';

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
          child: LayoutBuilder(
            builder: (context, constraints) {
              final hasAmount = item.amount.trim().isNotEmpty;
              final shortestSide = constraints.biggest.shortestSide;
              final iconSize = (shortestSide * (hasAmount ? 0.38 : 0.48))
                  .clamp(hasAmount ? 40.0 : 44.0, hasAmount ? 48.0 : 58.0)
                  .toDouble();
              final textHeight = hasAmount ? 28.0 : 40.0;

              return Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShoppingItemIcon(
                      iconKey: item.icon,
                      name: item.name,
                      size: iconSize,
                      color: foreground,
                    ),
                    SizedBox(height: hasAmount ? 3 : 4),
                    SizedBox(
                      height: textHeight,
                      width: double.infinity,
                      child: AutoFitText(
                        text: item.name,
                        maxFontSize: 17,
                        minFontSize: 10,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: foreground,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    if (hasAmount) ...[
                      const SizedBox(height: 2),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 17),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: colors.surface.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 1,
                            ),
                            child: Text(
                              item.amount,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: foreground,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
