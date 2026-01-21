import 'package:flutter/material.dart';
import 'package:example/widgets/button.dart';
import 'package:example/widgets/toast.dart';

class ToastPage extends StatelessWidget {
  const ToastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            title: 'Toast Types',
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                Button.small(
                  onPressed: () => showToast(
                    context: context,
                    message: 'Successfully saved!',
                    type: ToastType.success,
                  ),
                  label: 'Success',
                  variant: ButtonVariant.primary,
                ),
                Button.small(
                  onPressed: () => showToast(
                    context: context,
                    message: 'Something went wrong',
                    type: ToastType.error,
                  ),
                  label: 'Error',
                  variant: ButtonVariant.destructive,
                ),
                Button.small(
                  onPressed: () => showToast(
                    context: context,
                    message: 'Here is some info',
                    type: ToastType.info,
                  ),
                  label: 'Info',
                  variant: ButtonVariant.secondary,
                ),
                Button.small(
                  onPressed: () => showToast(
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
          _buildSection(
            title: 'Position',
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                Button.small(
                  onPressed: () => showToast(
                    context: context,
                    message: 'Toast at top',
                    position: ToastPosition.top,
                  ),
                  label: 'Top',
                  variant: ButtonVariant.secondary,
                ),
                Button.small(
                  onPressed: () => showToast(
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
          _buildSection(
            title: 'Stacking',
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                Button.small(
                  onPressed: () {
                    showToast(context: context, message: 'First', type: ToastType.success);
                    Future.delayed(const Duration(milliseconds: 200), () {
                      showToast(context: context, message: 'Second', type: ToastType.info);
                    });
                    Future.delayed(const Duration(milliseconds: 400), () {
                      showToast(context: context, message: 'Third', type: ToastType.warning);
                    });
                  },
                  label: 'Show 3 toasts',
                  variant: ButtonVariant.primary,
                ),
                Button.small(
                  onPressed: () => dismissAllToasts(),
                  label: 'Dismiss all',
                  variant: ButtonVariant.ghost,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF71717A),
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
