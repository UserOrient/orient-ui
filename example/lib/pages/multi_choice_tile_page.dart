import 'package:example/style.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:example/widgets/multi_choice_tile.dart';
import 'package:example/widgets/tile.dart';
import 'package:example/widgets/toggle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class MultiChoiceTilePage extends StatefulWidget {
  const MultiChoiceTilePage({super.key});

  @override
  State<MultiChoiceTilePage> createState() => _MultiChoiceTilePageState();
}

class _MultiChoiceTilePageState extends State<MultiChoiceTilePage> {
  bool _withSubtitle = true;
  bool _withLeading = false;
  final Map<TileVariant, List<bool>> _values = {
    for (final v in TileVariant.values) v: [true, false, true],
  };

  static const _items = [
    ('Email', 'Receive notifications via email', TablerIcons.mail),
    ('SMS', 'Receive notifications via text', TablerIcons.message),
    ('Push', 'Receive push notifications', TablerIcons.bell),
  ];

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 24,
          runSpacing: 12,
          children: [
            _toggle('Subtitle', _withSubtitle, (v) {
              setState(() => _withSubtitle = v);
            }, style),
            _toggle('Leading', _withLeading, (v) {
              setState(() => _withLeading = v);
            }, style),
          ],
        ),
        const SizedBox(height: 24),
        for (final variant in TileVariant.values) ...[
          DemoSection(
            title: variant.name,
            child: Column(
              children: [
                for (int i = 0; i < _items.length; i++) ...[
                  MultiChoiceTile(
                    variant: variant,
                    leading: _withLeading
                        ? Icon(_items[i].$3,
                            size: 24, color: style.colors.foreground)
                        : null,
                    title: _items[i].$1,
                    subtitle: _withSubtitle ? _items[i].$2 : null,
                    value: _values[variant]![i],
                    onChanged: (v) {
                      setState(() => _values[variant]![i] = v);
                    },
                  ),
                  if (i < _items.length - 1 &&
                      (variant == TileVariant.bordered ||
                          variant == TileVariant.filled))
                    const SizedBox(height: 8),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ],
    );
  }

  Widget _toggle(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
    Style style,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Toggle.small(value: value, onChanged: onChanged),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: style.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}
