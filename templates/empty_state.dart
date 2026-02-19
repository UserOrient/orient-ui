import 'package:flutter/material.dart';

import 'styling.dart';

/// A component for displaying empty state content with optional icon, description, and action.
///
/// EmptyState provides a consistent way to show users when there's no content
/// to display. It's commonly used for empty lists, search results, or initial
/// states where user action might be required.
///
/// ## Example
///
/// ```dart
/// // Basic empty state
/// EmptyState(
///   title: 'No items found',
///   description: 'Try adjusting your search or filters',
/// )
///
/// // With icon and action
/// EmptyState(
///   icon: Icon(Icons.inbox_outlined, size: 64),
///   title: 'No messages',
///   description: 'Start a conversation to see messages here',
///   action: Button(
///     label: 'New Message',
///     onPressed: () => createMessage(),
///   ),
/// )
///
/// // Custom illustration
/// EmptyState(
///   icon: CustomIllustration(),
///   title: 'Welcome!',
///   description: 'Get started by creating your first project',
///   action: Button(
///     label: 'Create Project',
///     onPressed: () => createProject(),
///   ),
/// )
/// ```
///
/// ## Behavior
///
/// - Automatically centers content in available space
/// - Uses theme-appropriate colors and typography
/// - Provides consistent spacing between elements
/// - Supports custom widgets for icon and action
///
/// ## Accessibility
///
/// - Content is automatically readable by screen readers
/// - Consider adding semantic labels for custom icons
/// - Ensure action buttons have proper accessibility labels
class EmptyState extends StatelessWidget {
  /// Optional icon or illustration displayed above the title.
  ///
  /// Typically an Icon, Image, or custom illustration widget.
  /// Automatically spaced with 16px margin from the title.
  /// Consider using 48-64px size for icons to maintain visual hierarchy.
  final Widget? icon;

  /// The main title text displayed prominently.
  ///
  /// This should be concise and clearly communicate the empty state.
  /// Uses bold font weight and primary text color from the theme.
  /// Required parameter.
  final String title;

  /// Optional descriptive text providing more context.
  ///
  /// Gives users additional information about why the state is empty
  /// and what they can do about it. Center-aligned and uses secondary
  /// text color for visual hierarchy.
  final String? description;

  /// Optional action button or widget for user interaction.
  ///
  /// Typically a Button or similar interactive widget that helps users
  /// resolve the empty state. Automatically spaced with 32px margin
  /// from the description. Should provide a clear call-to-action.
  final Widget? action;

  /// Creates an empty state with the specified properties.
  ///
  /// The [title] parameter is required. All other parameters are optional.
  ///
  /// The component automatically handles layout, spacing, and styling.
  /// Provide [icon] for visual interest, [description] for context,
  /// and [action] to guide users toward resolution.
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
