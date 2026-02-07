import 'package:example/widgets/button.dart';
import 'package:example/widgets/confirmation_popup.dart';
import 'package:example/widgets/toast.dart';
import 'package:flutter/material.dart';

class ConfirmationPopupPage extends StatelessWidget {
  const ConfirmationPopupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            Button.small(
              onPressed: () {
                ConfirmationPopup.show(
                  context: context,
                  icon: Icon(
                    Icons.check_circle_outline,
                    size: 48,
                    color: Colors.green.shade300,
                  ),
                  title: 'Sure to approve this feature?',
                  description:
                      'Once approved, it will be visible to the public.',
                  confirmLabel: 'Yes, approve',
                  cancelLabel: 'Cancel',
                  onConfirm: () {
                    showToast(
                      context: context,
                      message: 'Feature approved.',
                    );
                  },
                );
              },
              label: 'Default',
            ),
            Button.small(
              onPressed: () {
                ConfirmationPopup.show(
                  context: context,
                  icon: Icon(
                    Icons.delete_outline,
                    size: 48,
                    color: Colors.red.shade300,
                  ),
                  title: 'Delete this item?',
                  description: 'This action cannot be undone.',
                  confirmLabel: 'Delete',
                  cancelLabel: 'Keep it',
                  destructive: true,
                  onConfirm: () {
                    showToast(
                      context: context,
                      message: 'Item deleted',
                    );
                  },
                );
              },
              label: 'Destructive',
              variant: ButtonVariant.destructive,
            ),
            Button.small(
              onPressed: () {
                ConfirmationPopup.show(
                  context: context,
                  title: 'Are you sure?',
                  confirmLabel: 'Yes',
                  cancelLabel: 'No',
                  onConfirm: () {
                    showToast(
                      context: context,
                      message: 'Clicked yes',
                    );
                  },
                );
              },
              label: 'Minimal',
              variant: ButtonVariant.outline,
            ),
          ],
        ),
      ],
    );
  }
}
