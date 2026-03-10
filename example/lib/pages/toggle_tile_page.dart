import 'package:flutter/widgets.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:example/widgets/tile.dart';
import 'package:example/widgets/toggle_tile.dart';

class ToggleTilePage extends StatefulWidget {
  const ToggleTilePage({super.key});

  @override
  State<ToggleTilePage> createState() => _ToggleTilePageState();
}

class _ToggleTilePageState extends State<ToggleTilePage> {
  bool _simple = false;
  bool _bordered = true;
  bool _filled = false;
  bool _titleOnly = false;
  bool _withLeading = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DemoSection(
          title: 'Simple',
          child: ToggleTile(
            title: 'Notifications',
            subtitle: 'Receive push notifications',
            value: _simple,
            onChanged: (v) => setState(() => _simple = v),
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Bordered',
          child: ToggleTile(
            variant: TileVariant.bordered,
            title: 'Dark Mode',
            subtitle: 'Use dark theme across the app',
            value: _bordered,
            onChanged: (v) => setState(() => _bordered = v),
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Filled',
          child: ToggleTile(
            variant: TileVariant.filled,
            title: 'Auto Update',
            subtitle: 'Automatically install updates',
            value: _filled,
            onChanged: (v) => setState(() => _filled = v),
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Title Only',
          child: ToggleTile(
            variant: TileVariant.bordered,
            title: 'Enable Feature',
            value: _titleOnly,
            onChanged: (v) => setState(() => _titleOnly = v),
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'With Leading',
          child: ToggleTile(
            variant: TileVariant.bordered,
            leading: const Text('\u2699', style: TextStyle(fontSize: 24)),
            title: 'Settings',
            subtitle: 'Manage your preferences',
            value: _withLeading,
            onChanged: (v) => setState(() => _withLeading = v),
          ),
        ),
      ],
    );
  }
}
