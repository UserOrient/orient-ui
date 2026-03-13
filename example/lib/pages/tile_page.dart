import 'package:example/style.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:example/widgets/tile.dart';
import 'package:example/widgets/toggle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class TilePage extends StatefulWidget {
  const TilePage({super.key});

  @override
  State<TilePage> createState() => _TilePageState();
}

class _TilePageState extends State<TilePage> {
  bool _withSubtitle = true;
  bool _withLeading = false;
  bool _withTrailing = false;

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);
    final ColorTokens colors = style.colors;

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
            _toggle('Trailing', _withTrailing, (v) {
              setState(() => _withTrailing = v);
            }, style),
          ],
        ),
        const SizedBox(height: 24),
        for (final variant in TileVariant.values) ...[
          DemoSection(
            title: variant.name,
            child: Tile(
              variant: variant,
              leading: _withLeading
                  ? Icon(TablerIcons.user, size: 24, color: colors.foreground)
                  : null,
              title: 'Account',
              subtitle:
                  _withSubtitle ? 'Manage your account settings' : null,
              trailing: _withTrailing
                  ? Text(
                      '\u203A',
                      style: TextStyle(
                          fontSize: 20, color: colors.mutedForeground),
                    )
                  : null,
              onTap: () {},
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
