import 'package:example/style.dart';
import 'package:flutter/widgets.dart';

class DemoSection extends StatelessWidget {
  final String title;
  final Widget child;

  const DemoSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: style.colors.mutedForeground,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
