import 'package:flutter/widgets.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:example/widgets/tile.dart';
import 'package:example/widgets/single_choice_tile.dart';

class SingleChoiceTilePage extends StatefulWidget {
  const SingleChoiceTilePage({super.key});

  @override
  State<SingleChoiceTilePage> createState() => _SingleChoiceTilePageState();
}

class _SingleChoiceTilePageState extends State<SingleChoiceTilePage> {
  String _simple = 'email';
  String _bordered = 'dark';
  String _filled = 'monthly';
  String _withLeading = 'home';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DemoSection(
          title: 'Simple',
          child: Column(
            children: [
              SingleChoiceTile<String>(
                title: 'Email',
                subtitle: 'Receive notifications via email',
                value: 'email',
                groupValue: _simple,
                onChanged: (v) => setState(() => _simple = v),
              ),
              SingleChoiceTile<String>(
                title: 'SMS',
                subtitle: 'Receive notifications via text',
                value: 'sms',
                groupValue: _simple,
                onChanged: (v) => setState(() => _simple = v),
              ),
              SingleChoiceTile<String>(
                title: 'Push',
                subtitle: 'Receive push notifications',
                value: 'push',
                groupValue: _simple,
                onChanged: (v) => setState(() => _simple = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Bordered',
          child: Column(
            children: [
              SingleChoiceTile<String>(
                variant: TileVariant.bordered,
                title: 'Light',
                subtitle: 'Use light theme',
                value: 'light',
                groupValue: _bordered,
                onChanged: (v) => setState(() => _bordered = v),
              ),
              const SizedBox(height: 8),
              SingleChoiceTile<String>(
                variant: TileVariant.bordered,
                title: 'Dark',
                subtitle: 'Use dark theme',
                value: 'dark',
                groupValue: _bordered,
                onChanged: (v) => setState(() => _bordered = v),
              ),
              const SizedBox(height: 8),
              SingleChoiceTile<String>(
                variant: TileVariant.bordered,
                title: 'System',
                subtitle: 'Follow system setting',
                value: 'system',
                groupValue: _bordered,
                onChanged: (v) => setState(() => _bordered = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Filled',
          child: Column(
            children: [
              SingleChoiceTile<String>(
                variant: TileVariant.filled,
                title: 'Monthly',
                value: 'monthly',
                groupValue: _filled,
                onChanged: (v) => setState(() => _filled = v),
              ),
              const SizedBox(height: 8),
              SingleChoiceTile<String>(
                variant: TileVariant.filled,
                title: 'Yearly',
                value: 'yearly',
                groupValue: _filled,
                onChanged: (v) => setState(() => _filled = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'With Leading',
          child: Column(
            children: [
              SingleChoiceTile<String>(
                variant: TileVariant.bordered,
                leading: const Text('\u{1F3E0}', style: TextStyle(fontSize: 24)),
                title: 'Home',
                subtitle: 'Your home address',
                value: 'home',
                groupValue: _withLeading,
                onChanged: (v) => setState(() => _withLeading = v),
              ),
              const SizedBox(height: 8),
              SingleChoiceTile<String>(
                variant: TileVariant.bordered,
                leading: const Text('\u{1F3E2}', style: TextStyle(fontSize: 24)),
                title: 'Office',
                subtitle: 'Your work address',
                value: 'office',
                groupValue: _withLeading,
                onChanged: (v) => setState(() => _withLeading = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Disabled',
          child: Column(
            children: [
              SingleChoiceTile<String>(
                variant: TileVariant.bordered,
                title: 'Option A',
                value: 'a',
                groupValue: 'a',
              ),
              const SizedBox(height: 8),
              SingleChoiceTile<String>(
                variant: TileVariant.bordered,
                title: 'Option B',
                value: 'b',
                groupValue: 'a',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
