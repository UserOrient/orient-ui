import 'package:example/style.dart';
import 'package:flutter/widgets.dart';

class VariantTabs<T> extends StatelessWidget {
  final List<T> values;
  final T selected;
  final ValueChanged<T> onChanged;
  final String Function(T)? labelBuilder;

  const VariantTabs({
    super.key,
    required this.values,
    required this.selected,
    required this.onChanged,
    this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final value in values)
          GestureDetector(
            onTap: () => onChanged(value),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: selected == value
                    ? style.colors.accent
                    : style.colors.surfaceContainer,
                borderRadius: BorderRadius.circular(Style.radii.small),
              ),
              child: Text(
                labelBuilder?.call(value) ?? (value as Enum).name,
                style: TextStyle(
                  fontSize: 13,
                  color: selected == value
                      ? style.colors.accentForeground
                      : style.colors.mutedForeground,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
