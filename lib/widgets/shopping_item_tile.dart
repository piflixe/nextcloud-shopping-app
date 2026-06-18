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
              final textHeight = (shortestSide * (hasAmount ? 0.27 : 0.36))
                  .clamp(hasAmount ? 28.0 : 36.0, hasAmount ? 36.0 : 48.0)
                  .toDouble();
              final reservedHeight =
                  10 + textHeight + (hasAmount ? 22.0 : 0.0) + 8;
              final maxIconByHeight = (shortestSide - reservedHeight).clamp(
                38.0,
                76.0,
              );
              final iconSize = (shortestSide * (hasAmount ? 0.43 : 0.56))
                  .clamp(38.0, maxIconByHeight)
                  .toDouble();

              return Padding(
                padding: const EdgeInsets.all(5),
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
                        maxFontSize: 20,
                        minFontSize: 11,
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
