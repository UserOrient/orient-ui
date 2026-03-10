import 'package:flutter/widgets.dart';

import 'tile.dart';
import 'single_choice.dart';

class SingleChoiceTile<T> extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final T value;
  final T groupValue;
  final ValueChanged<T>? onChanged;
  final TileVariant variant;

  const SingleChoiceTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.variant = TileVariant.simple,
  });

  @override
  Widget build(BuildContext context) {
    final bool selected = value == groupValue;

    return Semantics(
      checked: selected,
      enabled: onChanged != null,
      label: title,
      excludeSemantics: true,
      child: Tile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: SingleChoice<T>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        onTap: onChanged != null && !selected
            ? () => onChanged!(value)
            : null,
        variant: variant,
      ),
    );
  }
}
