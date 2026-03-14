import 'package:flutter/widgets.dart';

import 'style.dart';

class Tag extends StatelessWidget {
  final String label;
  final Color color;

  const Tag({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: context.typography.bodySmall.copyWith(color: color),
      ),
    );
  }
}
