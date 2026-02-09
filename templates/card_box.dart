import 'package:flutter/widgets.dart';

import 'styling.dart';

enum CardBoxVariant { bordered, filled }

class CardBox extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final CardBoxVariant variant;
  final VoidCallback? onTap;

  const CardBox({
    super.key,
    required this.child,
    this.padding,
    this.variant = CardBoxVariant.filled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ColorTokens colors = Styling.of(context).colors;

    final BoxDecoration decoration = switch (variant) {
      CardBoxVariant.bordered => BoxDecoration(
        border: Border.all(color: colors.border, width: 1),
        borderRadius: BorderRadius.circular(Styling.radii.medium),
      ),
      CardBoxVariant.filled => BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(Styling.radii.medium),
      ),
    };

    Widget card = Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: decoration,
      child: child,
    );

    if (onTap != null) {
      card = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: card,
        ),
      );
    }

    return card;
  }
}
