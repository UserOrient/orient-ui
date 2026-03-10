import 'package:flutter/widgets.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:example/widgets/single_choice.dart';

class SingleChoicePage extends StatefulWidget {
  const SingleChoicePage({super.key});

  @override
  State<SingleChoicePage> createState() => _SingleChoicePageState();
}

class _SingleChoicePageState extends State<SingleChoicePage> {
  String _fruit = 'apple';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DemoSection(
          title: 'Default',
          child: Row(
            children: [
              SingleChoice<String>(
                value: 'apple',
                groupValue: _fruit,
                onChanged: (v) => setState(() => _fruit = v),
              ),
              const SizedBox(width: 16),
              SingleChoice<String>(
                value: 'banana',
                groupValue: _fruit,
                onChanged: (v) => setState(() => _fruit = v),
              ),
              const SizedBox(width: 16),
              SingleChoice<String>(
                value: 'cherry',
                groupValue: _fruit,
                onChanged: (v) => setState(() => _fruit = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Disabled',
          child: Row(
            children: [
              const SingleChoice<String>(
                value: 'a',
                groupValue: 'b',
              ),
              const SizedBox(width: 16),
              const SingleChoice<String>(
                value: 'a',
                groupValue: 'a',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
