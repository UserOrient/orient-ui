import 'package:example/style.dart';
import 'package:example/widgets/picker.dart';
import 'package:example/widgets/toggle.dart';
import 'package:flutter/widgets.dart';

class PickerPage extends StatefulWidget {
  const PickerPage({super.key});

  @override
  State<PickerPage> createState() => _PickerPageState();
}

class _PickerPageState extends State<PickerPage> {
  bool _withLabel = true;
  String _value = 'None';

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 24,
          runSpacing: 12,
          children: [
            _toggle('Label', _withLabel, (v) {
              setState(() => _withLabel = v);
            }, style),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 200,
          child: Picker<String>(
            label: _withLabel ? 'Status' : null,
            value: _value,
            onChanged: (v) {
              setState(() => _value = v);
            },
            items: const ['None', 'In progress', 'Planned', 'Implemented'],
          ),
        ),
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
