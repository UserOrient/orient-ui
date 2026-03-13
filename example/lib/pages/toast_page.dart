import 'package:flutter/widgets.dart';
import 'package:example/style.dart';
import 'package:example/widgets/button.dart';
import 'package:example/widgets/toast.dart';
import 'package:example/widgets/toggle.dart';

class ToastPage extends StatefulWidget {
  const ToastPage({super.key});

  @override
  State<ToastPage> createState() => _ToastPageState();
}

class _ToastPageState extends State<ToastPage> {
  bool _bottom = false;

  static const _messages = {
    ToastType.success: 'Successfully saved!',
    ToastType.error: 'Something went wrong',
    ToastType.info: 'Here is some info',
    ToastType.warning: 'Please be careful',
  };

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);
    final position = _bottom ? ToastPosition.bottom : ToastPosition.top;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _toggle('Bottom', _bottom, (v) {
          setState(() => _bottom = v);
        }, style),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final type in ToastType.values)
              Button.small(
                onPressed: () {
                  Toast.show(
                    context: context,
                    message: _messages[type]!,
                    type: type,
                    position: position,
                  );
                },
                label: type.name[0].toUpperCase() + type.name.substring(1),
                variant: ButtonVariant.secondary,
              ),
            Button.small(
              onPressed: () {
                Toast.dismissAll();
              },
              label: 'Dismiss all',
              variant: ButtonVariant.ghost,
            ),
          ],
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
