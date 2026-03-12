import 'package:example/style.dart';
import 'package:example/widgets/single_choice_tile.dart';
import 'package:example/widgets/tile.dart';
import 'package:example/widgets/toggle.dart';
import 'package:example/widgets/variant_tabs.dart';
import 'package:flutter/widgets.dart';

class SingleChoiceTilePage extends StatefulWidget {
  const SingleChoiceTilePage({super.key});

  @override
  State<SingleChoiceTilePage> createState() => _SingleChoiceTilePageState();
}

class _SingleChoiceTilePageState extends State<SingleChoiceTilePage> {
  TileVariant _variant = TileVariant.simple;
  bool _withSubtitle = true;
  bool _withLeading = false;
  String _selected = 'email';

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
        const SizedBox(height: 16),
        VariantTabs<TileVariant>(
          values: TileVariant.values,
          selected: _variant,
          onChanged: (v) {
            setState(() => _variant = v);
          },
        ),
        const SizedBox(height: 24),
        Column(
          children: [
            SingleChoiceTile<String>(
              variant: _variant,
              leading: _withLeading
                  ? const Text('\u2709', style: TextStyle(fontSize: 24))
                  : null,
              title: 'Email',
              subtitle: _withSubtitle
                  ? 'Receive notifications via email'
                  : null,
              value: 'email',
              groupValue: _selected,
              onChanged: (v) {
                setState(() => _selected = v);
              },
            ),
            if (_variant == TileVariant.bordered ||
                _variant == TileVariant.filled)
              const SizedBox(height: 8),
            SingleChoiceTile<String>(
              variant: _variant,
              leading: _withLeading
                  ? const Text('\u{1F4AC}', style: TextStyle(fontSize: 24))
                  : null,
              title: 'SMS',
              subtitle: _withSubtitle
                  ? 'Receive notifications via text'
                  : null,
              value: 'sms',
              groupValue: _selected,
              onChanged: (v) {
                setState(() => _selected = v);
              },
            ),
            if (_variant == TileVariant.bordered ||
                _variant == TileVariant.filled)
              const SizedBox(height: 8),
            SingleChoiceTile<String>(
              variant: _variant,
              leading: _withLeading
                  ? const Text('\u{1F514}', style: TextStyle(fontSize: 24))
                  : null,
              title: 'Push',
              subtitle: _withSubtitle
                  ? 'Receive push notifications'
                  : null,
              value: 'push',
              groupValue: _selected,
              onChanged: (v) {
                setState(() => _selected = v);
              },
            ),
          ],
        ),
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
