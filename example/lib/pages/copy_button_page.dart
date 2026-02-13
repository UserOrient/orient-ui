import 'package:example/styling.dart';
import 'package:example/widgets/copy_button.dart';
import 'package:example/widgets/demo_section.dart';
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
        DemoSection(
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
                  Toast.show(
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
}
