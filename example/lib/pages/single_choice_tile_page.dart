import 'package:example/style.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:example/widgets/single_choice_tile.dart';
import 'package:example/widgets/tile.dart';
import 'package:example/widgets/toggle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class SingleChoiceTilePage extends StatefulWidget {
  const SingleChoiceTilePage({super.key});

  @override
  State<SingleChoiceTilePage> createState() => _SingleChoiceTilePageState();
}

class _SingleChoiceTilePageState extends State<SingleChoiceTilePage> {
  bool _withSubtitle = true;
  bool _withLeading = false;
  final Map<TileVariant, String> _selected = {
    for (final v in TileVariant.values) v: 'email',
  };

  static const _items = [
    ('email', 'Email', 'Receive notifications via email', TablerIcons.mail),
    ('sms', 'SMS', 'Receive notifications via text', TablerIcons.message),
    ('push', 'Push', 'Receive push notifications', TablerIcons.bell),
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
                  SingleChoiceTile<String>(
                    variant: variant,
                    leading: _withLeading
                        ? Icon(_items[i].$4,
                            size: 24, color: style.colors.foreground)
                        : null,
                    title: _items[i].$2,
                    subtitle: _withSubtitle ? _items[i].$3 : null,
                    value: _items[i].$1,
                    groupValue: _selected[variant]!,
                    onChanged: (v) {
                      setState(() => _selected[variant] = v);
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
