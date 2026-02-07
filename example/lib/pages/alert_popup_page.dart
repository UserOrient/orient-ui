import 'package:example/widgets/alert_popup.dart';
import 'package:example/widgets/button.dart';
import 'package:flutter/material.dart';

class AlertPopupPage extends StatelessWidget {
  const AlertPopupPage({super.key});

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
                label: 'Full',
              ),
              Button.small(
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
                label: 'No icon',
                variant: ButtonVariant.outline,
              ),
              Button.small(
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
                label: 'No description',
                variant: ButtonVariant.outline,
              ),
              Button.small(
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
                label: 'No action',
                variant: ButtonVariant.outline,
              ),
          ],
        ),
      ],
    );
  }
}
