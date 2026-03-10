import 'package:example/style.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:example/widgets/tile.dart';
import 'package:flutter/widgets.dart';

class TilePage extends StatelessWidget {
  const TilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Style.of(context).colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DemoSection(
          title: 'Simple',
          child: Tile(
            title: 'Account',
            subtitle: 'Manage your account settings',
            onTap: () {},
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Bordered',
          child: Tile(
            variant: TileVariant.bordered,
            title: 'Privacy',
            subtitle: 'Control your privacy settings',
            trailing: Text(
              '\u203A',
              style: TextStyle(fontSize: 20, color: colors.mutedForeground),
            ),
            onTap: () {},
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Filled',
          child: Tile(
            variant: TileVariant.filled,
            title: 'Notifications',
            subtitle: 'You have 3 unread notifications',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: colors.accent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '3',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            onTap: () {},
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Title Only',
          child: Tile(
            variant: TileVariant.bordered,
            title: 'Help Center',
            onTap: () {},
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'With Leading',
          child: Tile(
            variant: TileVariant.bordered,
            leading: const Text('\u2699', style: TextStyle(fontSize: 24)),
            title: 'Settings',
            subtitle: 'App preferences',
            trailing: Text(
              '\u203A',
              style: TextStyle(fontSize: 20, color: colors.mutedForeground),
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
