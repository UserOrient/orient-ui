import 'package:flutter/widgets.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:example/widgets/tile.dart';
import 'package:example/widgets/multi_choice_tile.dart';

class MultiChoiceTilePage extends StatefulWidget {
  const MultiChoiceTilePage({super.key});

  @override
  State<MultiChoiceTilePage> createState() => _MultiChoiceTilePageState();
}

class _MultiChoiceTilePageState extends State<MultiChoiceTilePage> {
  bool _email = true;
  bool _sms = false;
  bool _push = true;
  bool _darkBordered = true;
  bool _lightBordered = false;
  bool _monthlyFilled = true;
  bool _yearlyFilled = false;
  bool _home = true;
  bool _office = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DemoSection(
          title: 'Simple',
          child: Column(
            children: [
              MultiChoiceTile(
                title: 'Email',
                subtitle: 'Receive notifications via email',
                value: _email,
                onChanged: (v) => setState(() => _email = v),
              ),
              MultiChoiceTile(
                title: 'SMS',
                subtitle: 'Receive notifications via text',
                value: _sms,
                onChanged: (v) => setState(() => _sms = v),
              ),
              MultiChoiceTile(
                title: 'Push',
                subtitle: 'Receive push notifications',
                value: _push,
                onChanged: (v) => setState(() => _push = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Bordered',
          child: Column(
            children: [
              MultiChoiceTile(
                variant: TileVariant.bordered,
                title: 'Light',
                subtitle: 'Use light theme',
                value: _lightBordered,
                onChanged: (v) => setState(() => _lightBordered = v),
              ),
              const SizedBox(height: 8),
              MultiChoiceTile(
                variant: TileVariant.bordered,
                title: 'Dark',
                subtitle: 'Use dark theme',
                value: _darkBordered,
                onChanged: (v) => setState(() => _darkBordered = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Filled',
          child: Column(
            children: [
              MultiChoiceTile(
                variant: TileVariant.filled,
                title: 'Monthly',
                value: _monthlyFilled,
                onChanged: (v) => setState(() => _monthlyFilled = v),
              ),
              const SizedBox(height: 8),
              MultiChoiceTile(
                variant: TileVariant.filled,
                title: 'Yearly',
                value: _yearlyFilled,
                onChanged: (v) => setState(() => _yearlyFilled = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'With Leading',
          child: Column(
            children: [
              MultiChoiceTile(
                variant: TileVariant.bordered,
                leading: const Text('\u{1F3E0}', style: TextStyle(fontSize: 24)),
                title: 'Home',
                subtitle: 'Your home address',
                value: _home,
                onChanged: (v) => setState(() => _home = v),
              ),
              const SizedBox(height: 8),
              MultiChoiceTile(
                variant: TileVariant.bordered,
                leading: const Text('\u{1F3E2}', style: TextStyle(fontSize: 24)),
                title: 'Office',
                subtitle: 'Your work address',
                value: _office,
                onChanged: (v) => setState(() => _office = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Disabled',
          child: Column(
            children: [
              MultiChoiceTile(
                variant: TileVariant.bordered,
                title: 'Option A',
                value: true,
              ),
              const SizedBox(height: 8),
              MultiChoiceTile(
                variant: TileVariant.bordered,
                title: 'Option B',
                value: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
