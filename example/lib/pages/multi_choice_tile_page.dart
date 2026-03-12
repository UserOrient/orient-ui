import 'package:example/style.dart';
import 'package:example/widgets/multi_choice_tile.dart';
import 'package:example/widgets/tile.dart';
import 'package:example/widgets/toggle.dart';
import 'package:example/widgets/variant_tabs.dart';
import 'package:flutter/widgets.dart';

class MultiChoiceTilePage extends StatefulWidget {
  const MultiChoiceTilePage({super.key});

  @override
  State<MultiChoiceTilePage> createState() => _MultiChoiceTilePageState();
}

class _MultiChoiceTilePageState extends State<MultiChoiceTilePage> {
  TileVariant _variant = TileVariant.simple;
  bool _withSubtitle = true;
  bool _withLeading = false;
  bool _email = true;
  bool _sms = false;
  bool _push = true;

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
            MultiChoiceTile(
              variant: _variant,
              leading: _withLeading
                  ? const Text('\u2709', style: TextStyle(fontSize: 24))
                  : null,
              title: 'Email',
              subtitle: _withSubtitle
                  ? 'Receive notifications via email'
                  : null,
              value: _email,
              onChanged: (v) {
                setState(() => _email = v);
              },
            ),
            if (_variant == TileVariant.bordered ||
                _variant == TileVariant.filled)
              const SizedBox(height: 8),
            MultiChoiceTile(
              variant: _variant,
              leading: _withLeading
                  ? const Text('\u{1F4AC}', style: TextStyle(fontSize: 24))
                  : null,
              title: 'SMS',
              subtitle: _withSubtitle
                  ? 'Receive notifications via text'
                  : null,
              value: _sms,
              onChanged: (v) {
                setState(() => _sms = v);
              },
            ),
            if (_variant == TileVariant.bordered ||
                _variant == TileVariant.filled)
              const SizedBox(height: 8),
            MultiChoiceTile(
              variant: _variant,
              leading: _withLeading
                  ? const Text('\u{1F514}', style: TextStyle(fontSize: 24))
                  : null,
              title: 'Push',
              subtitle: _withSubtitle
                  ? 'Receive push notifications'
                  : null,
              value: _push,
              onChanged: (v) {
                setState(() => _push = v);
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
