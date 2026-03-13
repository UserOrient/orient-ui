import 'package:flutter/widgets.dart';
import 'package:example/style.dart';

class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final colors = style.colors;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Colors', style: context.typography.display),
          const SizedBox(height: 8),
          Text(
            'All color tokens from your style.dart.',
            style: context.typography.body.muted(context),
          ),
          const SizedBox(height: 48),
          _section('Surface', [
            _ColorEntry('background', colors.background),
            _ColorEntry('surfaceContainer', colors.surfaceContainer),
            _ColorEntry('border', colors.border),
            _ColorEntry('borderSubtle', colors.borderSubtle),
          ]),
          const SizedBox(height: 40),
          _section('Foreground', [
            _ColorEntry('foreground', colors.foreground),
            _ColorEntry('mutedForeground', colors.mutedForeground),
            _ColorEntry('accent', colors.accent),
            _ColorEntry('accentForeground', colors.accentForeground),
          ]),
          const SizedBox(height: 40),
          _section('Button', [
            _ColorEntry('primary', colors.button.primary),
            _ColorEntry('primaryForeground', colors.button.primaryForeground),
            _ColorEntry('secondary', colors.button.secondary),
            _ColorEntry('secondaryForeground', colors.button.secondaryForeground),
            _ColorEntry('destructive', colors.button.destructive),
            _ColorEntry('destructiveForeground', colors.button.destructiveForeground),
            _ColorEntry('link', colors.button.link),
            _ColorEntry('accent', colors.button.accent),
          ]),
          const SizedBox(height: 40),
          _section('Navigation', [
            _ColorEntry('railBackground', colors.navigation.railBackground),
            _ColorEntry('railItemActive', colors.navigation.railItemBackgroundActive),
            _ColorEntry('railItemHover', colors.navigation.railItemBackgroundHover),
            _ColorEntry('railItemText', colors.navigation.railItemText),
            _ColorEntry('bottomBarBackground', colors.navigation.bottomBarBackground),
            _ColorEntry('bottomBarActive', colors.navigation.bottomBarItemActive),
            _ColorEntry('bottomBarInactive', colors.navigation.bottomBarItemInactive),
          ]),
          const SizedBox(height: 40),
          _section('Semantic', [
            _ColorEntry('success', colors.success),
            _ColorEntry('error', colors.error),
            _ColorEntry('info', colors.info),
            _ColorEntry('warning', colors.warning),
          ]),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _section(String title, List<_ColorEntry> entries) {
    return Builder(
      builder: (context) {
        final style = Style.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: style.colors.mutedForeground,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final entry in entries)
                  _ColorChip(name: entry.name, color: entry.color),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _ColorEntry {
  final String name;
  final Color color;

  const _ColorEntry(this.name, this.color);
}

class _ColorChip extends StatelessWidget {
  final String name;
  final Color color;

  const _ColorChip({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final hexValue = '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';

    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 64,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(Style.radii.small),
              border: Border.all(
                color: style.colors.border,
                width: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: style.colors.foreground,
            ),
          ),
          Text(
            hexValue,
            style: TextStyle(
              fontSize: 11,
              color: style.colors.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
