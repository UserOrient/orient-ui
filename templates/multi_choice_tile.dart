import 'package:flutter/widgets.dart';

import 'tile.dart';
import 'multi_choice.dart';

class MultiChoiceTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final TileVariant variant;

  const MultiChoiceTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    required this.value,
    this.onChanged,
    this.variant = TileVariant.simple,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      checked: value,
      enabled: onChanged != null,
      label: title,
      excludeSemantics: true,
      child: Tile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: MultiChoice(
          value: value,
          onChanged: onChanged,
        ),
        onTap: onChanged != null ? () => onChanged!(!value) : null,
        variant: variant,
      ),
    );
  }
}
