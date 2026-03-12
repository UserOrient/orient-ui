import 'package:example/style.dart';
import 'package:example/widgets/tile.dart';
import 'package:example/widgets/toggle.dart';
import 'package:example/widgets/toggle_tile.dart';
import 'package:example/widgets/variant_tabs.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class ToggleTilePage extends StatefulWidget {
  const ToggleTilePage({super.key});

  @override
  State<ToggleTilePage> createState() => _ToggleTilePageState();
}

class _ToggleTilePageState extends State<ToggleTilePage> {
  TileVariant _variant = TileVariant.simple;
  bool _withSubtitle = true;
  bool _withLeading = false;
  bool _value = false;

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
        ToggleTile(
          variant: _variant,
          leading: _withLeading
              ? Icon(TablerIcons.bell, size: 24, color: style.colors.foreground)
              : null,
          title: 'Notifications',
          subtitle: _withSubtitle ? 'Receive push notifications' : null,
          value: _value,
          onChanged: (v) {
            setState(() => _value = v);
          },
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
