import 'package:flutter/widgets.dart';

import 'styling.dart';

/// Defines the visual style variants for the CardBox component.
///
/// Each variant provides a different visual treatment for containing
/// and grouping related content.
enum CardBoxVariant {
  /// Card with only a border and transparent background
  bordered,

  /// Card with a solid background color and no border
  filled,
}

/// A flexible container component for grouping and displaying related content.
///
/// CardBox provides a consistent way to create container elements with
/// optional interactivity and multiple visual styles. It's commonly used
/// for grouping related information, creating list items, or building
/// card-based layouts.
///
/// ## Example
///
/// ```dart
/// // Basic filled card
/// CardBox(
///   child: Column(
///     children: [
///       Text('Card Title'),
///       Text('Card content goes here'),
///     ],
///   ),
/// )
///
/// // Bordered card with custom padding
/// CardBox(
///   variant: CardBoxVariant.bordered,
///   padding: EdgeInsets.all(24),
///   child: Text('Bordered card'),
/// )
///
/// // Interactive card
/// CardBox(
///   onTap: () => print('Card tapped'),
///   child: Text('Clickable card'),
/// )
/// ```
///
/// ## Behavior
///
/// - Automatically fills available width
/// - Provides hover cursor when [onTap] is provided
/// - Uses theme-appropriate colors and borders
/// - Maintains consistent border radius across variants
///
/// ## Accessibility
///
/// - Automatically becomes tappable when [onTap] is provided
/// - Maintains proper hit testing behavior
/// - Respects system cursor preferences
class CardBox extends StatelessWidget {
  /// The content widget displayed inside the card.
  ///
  /// This is typically a Column, Row, or other layout widget containing
  /// the card's content. The child widget has access to the full width
  /// of the card container.
  final Widget child;

  /// The padding inside the card container.
  ///
  /// If null, defaults to `EdgeInsets.all(16)`. Use this to customize
  /// the spacing between the card border and its content.
  final EdgeInsetsGeometry? padding;

  /// The visual style variant of the card.
  ///
  /// Determines whether the card has a border, background color, or both.
  /// See [CardBoxVariant] for available options.
  ///
  /// Defaults to [CardBoxVariant.filled].
  final CardBoxVariant variant;

  /// Optional callback for making the card interactive.
  ///
  /// When provided, the card becomes clickable and shows a pointer cursor
  /// on hover. The entire card area becomes tappable with proper hit testing.
  ///
  /// If null, the card is purely decorative.
  final VoidCallback? onTap;

  /// Creates a CardBox with the specified properties.
  ///
  /// The [child] parameter is required. All other parameters are optional.
  ///
  /// By default, creates a filled card with standard 16px padding.
  /// Use [variant] to change the visual style and [padding] to customize
  /// the internal spacing. Provide [onTap] to make the card interactive.
  const CardBox({
    super.key,
    required this.child,
    this.padding,
    this.variant = CardBoxVariant.filled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ColorTokens colors = Styling.of(context).colors;

    final BoxDecoration decoration = switch (variant) {
      CardBoxVariant.bordered => BoxDecoration(
        border: Border.all(color: colors.border, width: 1),
        borderRadius: BorderRadius.circular(Styling.radii.medium),
      ),
      CardBoxVariant.filled => BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(Styling.radii.medium),
      ),
    };

    Widget card = Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: decoration,
      child: child,
    );

    if (onTap != null) {
      card = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: card,
        ),
      );
    }

    return card;
  }
}
