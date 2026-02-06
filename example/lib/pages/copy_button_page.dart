import 'package:example/styling.dart';
import 'package:example/widgets/copy_button.dart';
import 'package:example/widgets/toast.dart';
import 'package:flutter/widgets.dart';

class CopyButtonPage extends StatelessWidget {
  const CopyButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final styling = Styling.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          title: 'Default',
          child: Row(
            children: [
              Text(
                'kamran@userorient.com',
                style: TextStyle(
                  fontSize: 14,
                  color: styling.colors.primaryText,
                ),
              ),
              const SizedBox(width: 8),
              CopyButton(
                value: 'kamran@userorient.com',
                onCopied: () {
                  showToast(
                    context: context,
                    message: 'Copied to clipboard',
                  );
                },
              ),
            ],
          ),
        ),
      ],
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
