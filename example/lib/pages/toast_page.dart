import 'package:flutter/widgets.dart';
import 'package:example/style.dart';
import 'package:example/widgets/button.dart';
import 'package:example/widgets/toast.dart';
import 'package:example/widgets/toggle.dart';
import 'package:example/widgets/variant_tabs.dart';

class ToastPage extends StatefulWidget {
  const ToastPage({super.key});

  @override
  State<ToastPage> createState() => _ToastPageState();
}

class _ToastPageState extends State<ToastPage> {
  ToastType _type = ToastType.success;
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 24,
          runSpacing: 12,
          children: [
            _toggle(
              'Bottom',
              _bottom,
              (v) {
                setState(() => _bottom = v);
              },
              style,
            ),
          ],
        ),
        const SizedBox(height: 16),
        VariantTabs<ToastType>(
          values: ToastType.values,
          selected: _type,
          onChanged: (v) {
            setState(() => _type = v);
          },
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            Button.small(
              onPressed: () {
                Toast.show(
                  context: context,
                  message: _messages[_type]!,
                  type: _type,
                  position: _bottom ? ToastPosition.bottom : ToastPosition.top,
                );
              },
              label: 'Show toast',
              variant: ButtonVariant.primary,
            ),
            Button.small(
              onPressed: () {
                Toast.show(
                  context: context,
                  message: 'First',
                  type: ToastType.success,
                  position:
                      _bottom ? ToastPosition.bottom : ToastPosition.top,
                );

                Future.delayed(const Duration(milliseconds: 200), () {
                  if (context.mounted) {
                    Toast.show(
                      context: context,
                      message: 'Second',
                      type: ToastType.info,
                      position:
                          _bottom ? ToastPosition.bottom : ToastPosition.top,
                    );
                  }
                });

                Future.delayed(const Duration(milliseconds: 400), () {
                  if (context.mounted) {
                    Toast.show(
                      context: context,
                      message: 'Third',
                      type: ToastType.warning,
                      position:
                          _bottom ? ToastPosition.bottom : ToastPosition.top,
                    );
                  }
                });
              },
              label: 'Show 3 toasts',
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
