import 'package:flutter/material.dart';
import 'package:example/widgets/button.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:example/widgets/toast.dart';

class ToastPage extends StatelessWidget {
  const ToastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DemoSection(
          title: 'Toast Types',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              Button.small(
                onPressed: () => Toast.show(
                  context: context,
                  message: 'Successfully saved!',
                  type: ToastType.success,
                ),
                label: 'Success',
                variant: ButtonVariant.primary,
              ),
              Button.small(
                onPressed: () => Toast.show(
                  context: context,
                  message: 'Something went wrong',
                  type: ToastType.error,
                ),
                label: 'Error',
                variant: ButtonVariant.destructive,
              ),
              Button.small(
                onPressed: () => Toast.show(
                  context: context,
                  message: 'Here is some info',
                  type: ToastType.info,
                ),
                label: 'Info',
                variant: ButtonVariant.secondary,
              ),
              Button.small(
                onPressed: () => Toast.show(
                  context: context,
                  message: 'Please be careful',
                  type: ToastType.warning,
                ),
                label: 'Warning',
                variant: ButtonVariant.outline,
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'Position',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              Button.small(
                onPressed: () => Toast.show(
                  context: context,
                  message: 'Toast at top',
                  position: ToastPosition.top,
                ),
                label: 'Top',
                variant: ButtonVariant.secondary,
              ),
              Button.small(
                onPressed: () => Toast.show(
                  context: context,
                  message: 'Toast at bottom',
                  position: ToastPosition.bottom,
                ),
                label: 'Bottom',
                variant: ButtonVariant.secondary,
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'Stacking',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              Button.small(
                onPressed: () {
                  Toast.show(context: context, message: 'First', type: ToastType.success);
                  Future.delayed(const Duration(milliseconds: 200), () {
                    Toast.show(context: context, message: 'Second', type: ToastType.info);
                  });
                  Future.delayed(const Duration(milliseconds: 400), () {
                    Toast.show(context: context, message: 'Third', type: ToastType.warning);
                  });
                },
                label: 'Show 3 toasts',
                variant: ButtonVariant.primary,
              ),
              Button.small(
                onPressed: () => Toast.dismissAll(),
                label: 'Dismiss all',
                variant: ButtonVariant.ghost,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
