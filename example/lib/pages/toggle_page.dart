import 'package:flutter/widgets.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:example/widgets/toggle.dart';

class TogglePage extends StatefulWidget {
  const TogglePage({super.key});

  @override
  State<TogglePage> createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage> {
  bool _default1 = false;
  bool _default2 = true;
  bool _small1 = false;
  bool _small2 = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DemoSection(
          title: 'Default',
          child: Row(
            children: [
              Toggle(
                value: _default1,
                onChanged: (v) => setState(() => _default1 = v),
              ),
              const SizedBox(width: 16),
              Toggle(
                value: _default2,
                onChanged: (v) => setState(() => _default2 = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Small',
          child: Row(
            children: [
              Toggle.small(
                value: _small1,
                onChanged: (v) => setState(() => _small1 = v),
              ),
              const SizedBox(width: 16),
              Toggle.small(
                value: _small2,
                onChanged: (v) => setState(() => _small2 = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Disabled',
          child: Row(
            children: [
              const Toggle(value: false),
              const SizedBox(width: 16),
              const Toggle(value: true),
            ],
          ),
        ),
      ],
    );
  }
}
