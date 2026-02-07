import 'package:example/styling.dart';
import 'package:example/widgets/button.dart';
import 'package:example/widgets/popup.dart';
import 'package:flutter/material.dart';

class PopupPage extends StatelessWidget {
  const PopupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Button.small(
          onPressed: () {
            Popup.show(
              context: context,
              title: 'Comments (3)',
              child: _CommentsList(),
            );
          },
          label: 'Show Popup',
        ),
      ],
    );
  }
}

class _CommentsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final styling = Styling.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CommentTile(
          initials: 'SC',
          name: 'Sarah Chen',
          time: '2h ago',
          text: 'Looks great! Can we also add dark mode support?',
        ),
        const SizedBox(height: 24),
        _CommentTile(
          initials: 'AM',
          name: 'Alex Morgan',
          time: '5h ago',
          text:
              'The padding on mobile feels a bit tight. Maybe bump it to 24px?',
        ),
        const SizedBox(height: 24),
        _CommentTile(
          initials: 'JL',
          name: 'James Lee',
          time: '1d ago',
          text: 'Shipped to staging. Let me know if anything looks off.',
        ),
        const SizedBox(height: 32),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: styling.colors.border.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'Write a comment...',
            style: TextStyle(
              fontSize: 16,
              height: 24 / 16,
              fontWeight: FontWeight.w400,
              color: styling.colors.secondaryText,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _CommentTile extends StatelessWidget {
  final String initials;
  final String name;
  final String time;
  final String text;

  const _CommentTile({
    required this.initials,
    required this.name,
    required this.time,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final styling = Styling.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: styling.colors.border,
          ),
          alignment: Alignment.center,
          child: Text(
            initials,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: styling.colors.secondaryText,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 15,
                      height: 20 / 15,
                      fontWeight: FontWeight.w600,
                      color: styling.colors.primaryText,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 14,
                      height: 20 / 14,
                      fontWeight: FontWeight.w400,
                      color: styling.colors.secondaryText,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  height: 24 / 16,
                  color: styling.colors.primaryText,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
