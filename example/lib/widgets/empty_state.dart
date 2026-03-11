import 'package:example/style.dart';
import 'package:flutter/widgets.dart';

class EmptyState extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String? description;
  final Widget? action;

  const EmptyState({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(height: 16.0),
          ],
          Text(
            title,
            style: context.typography.title.bold,
          ),
          if (description != null && description!.isNotEmpty) ...[
            const SizedBox(height: 8.0),
            Text(
              description!,
              textAlign: TextAlign.center,
              style: context.typography.body.muted(context),
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: 32.0),
            action!,
          ],
        ],
      ),
    );
  }
}
