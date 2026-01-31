import 'package:example/widgets/alert_popup.dart';
import 'package:example/widgets/button.dart';
import 'package:flutter/material.dart';

class AlertPopupPage extends StatelessWidget {
  const AlertPopupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            title: 'Success',
            child: Button.small(
              onPressed: () {
                AlertPopup.show(
                  context: context,
                  icon: Icon(
                    Icons.check_circle_outline,
                    size: 48,
                    color: Colors.green.shade300,
                  ),
                  title: 'Payment successful',
                  description:
                      'Your payment of \$49.99 has been processed successfully.',
                  action: Button(
                    label: 'Done',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                );
              },
              label: 'Show Alert',
            ),
          ),
          _buildSection(
            title: 'Error',
            child: Button.small(
              onPressed: () {
                AlertPopup.show(
                  context: context,
                  icon: Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red.shade300,
                  ),
                  title: 'Something went wrong',
                  description:
                      'We couldn\'t process your request. Please try again later.',
                  action: Button(
                    label: 'Try again',
                    variant: ButtonVariant.destructive,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                );
              },
              label: 'Show Alert',
            ),
          ),
          _buildSection(
            title: 'Warning',
            child: Button.small(
              onPressed: () {
                AlertPopup.show(
                  context: context,
                  icon: Icon(
                    Icons.warning_amber_rounded,
                    size: 48,
                    color: Colors.orange.shade300,
                  ),
                  title: 'Session expiring soon',
                  description:
                      'Your session will expire in 5 minutes. Save your work to avoid losing progress.',
                  action: Button(
                    label: 'Got it',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                );
              },
              label: 'Show Alert',
            ),
          ),
          _buildSection(
            title: 'Info',
            child: Button.small(
              onPressed: () {
                AlertPopup.show(
                  context: context,
                  icon: Icon(
                    Icons.info_outline,
                    size: 48,
                    color: Colors.blue.shade300,
                  ),
                  title: 'New update available',
                  description:
                      'Version 2.0 is available with new features and improvements.',
                  action: Button(
                    label: 'Update now',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                );
              },
              label: 'Show Alert',
            ),
          ),
          _buildSection(
            title: 'No icon',
            child: Button.small(
              onPressed: () {
                AlertPopup.show(
                  context: context,
                  title: 'Terms updated',
                  description:
                      'We\'ve updated our terms of service. Please review them at your convenience.',
                  action: Button(
                    label: 'OK',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                );
              },
              label: 'Show Alert',
            ),
          ),
          _buildSection(
            title: 'No description',
            child: Button.small(
              onPressed: () {
                AlertPopup.show(
                  context: context,
                  icon: Icon(
                    Icons.cloud_done_outlined,
                    size: 48,
                    color: Colors.green.shade300,
                  ),
                  title: 'All changes saved',
                  action: Button(
                    label: 'OK',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                );
              },
              label: 'Show Alert',
            ),
          ),
          _buildSection(
            title: 'No action (tap outside to dismiss)',
            child: Button.small(
              onPressed: () {
                AlertPopup.show(
                  context: context,
                  icon: Icon(
                    Icons.hourglass_bottom,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                  title: 'Processing your request',
                  description: 'This may take a moment. Tap outside to dismiss.',
                );
              },
              label: 'Show Alert',
            ),
          ),
          _buildSection(
            title: 'Minimal (title only)',
            child: Button.small(
              onPressed: () {
                AlertPopup.show(
                  context: context,
                  title: 'Copied to clipboard',
                );
              },
              label: 'Show Alert',
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
