import 'package:example/style.dart';
import 'package:example/widgets/tag.dart';
import 'package:flutter/widgets.dart';

class TagPage extends StatelessWidget {
  const TagPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Tag(label: 'Implemented', color: style.colors.success),
        Tag(label: 'In Progress', color: style.colors.info),
        Tag(label: 'Planned', color: style.colors.warning),
        Tag(label: 'Cancelled', color: style.colors.error),
        Tag(label: 'Custom', color: const Color(0xFF8B5CF6)),
      ],
    );
  }
}
