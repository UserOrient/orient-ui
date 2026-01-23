import 'package:flutter/material.dart';

import 'styling.dart';

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
    final StylingData styling = Styling.of(context);

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
            style: TextStyle(
              fontSize: 18,
              height: 28 / 18,
              color: styling.colors.primaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (description != null && description!.isNotEmpty) ...[
            const SizedBox(height: 8.0),
            Text(
              description!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 20 / 14,
                color: styling.colors.secondaryText,
              ),
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
