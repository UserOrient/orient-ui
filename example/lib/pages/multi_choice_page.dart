import 'package:flutter/widgets.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:example/widgets/multi_choice.dart';

class MultiChoicePage extends StatefulWidget {
  const MultiChoicePage({super.key});

  @override
  State<MultiChoicePage> createState() => _MultiChoicePageState();
}

class _MultiChoicePageState extends State<MultiChoicePage> {
  bool _a = true;
  bool _b = false;
  bool _c = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DemoSection(
          title: 'Default',
          child: Row(
            children: [
              MultiChoice(
                value: _a,
                onChanged: (v) => setState(() => _a = v),
              ),
              const SizedBox(width: 16),
              MultiChoice(
                value: _b,
                onChanged: (v) => setState(() => _b = v),
              ),
              const SizedBox(width: 16),
              MultiChoice(
                value: _c,
                onChanged: (v) => setState(() => _c = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Disabled',
          child: Row(
            children: [
              const MultiChoice(
                value: false,
              ),
              const SizedBox(width: 16),
              const MultiChoice(
                value: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
