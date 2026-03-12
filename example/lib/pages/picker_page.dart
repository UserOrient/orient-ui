import 'package:flutter/widgets.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:example/widgets/picker.dart';

class PickerPage extends StatefulWidget {
  const PickerPage({super.key});

  @override
  State<PickerPage> createState() => _PickerPageState();
}

class _PickerPageState extends State<PickerPage> {
  String _status = 'None';
  String _size = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DemoSection(
          title: 'With label',
          child: SizedBox(
            width: 200,
            child: Picker<String>(
              label: 'Status tag',
              value: _status,
              onChanged: (v) => setState(() => _status = v),
              items: const ['None', 'In progress', 'Planned', 'Implemented'],
            ),
          ),
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'Without label',
          child: SizedBox(
            width: 200,
            child: Picker<String>(
              value: _size,
              onChanged: (v) => setState(() => _size = v),
              items: const ['Small', 'Medium', 'Large', 'Extra large'],
            ),
          ),
        ),
      ],
    );
  }
}
