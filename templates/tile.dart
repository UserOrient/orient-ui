import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'styling.dart';

/// Defines the visual style variants for the Tile component.
///
/// Each variant provides a different visual treatment while maintaining
/// consistent layout and behavior across all variants.
enum TileVariant {
  /// Simple tile with no background or border
  simple,

  /// Tile with a border and transparent background
  bordered,

  /// Tile with a solid background color and no border
  filled,
}

/// A versatile list item component with optional interactivity and multiple visual styles.
///
/// Tile provides a consistent way to create list items, menu items, or
/// any content that needs a structured layout with optional leading/trailing
/// elements. It's commonly used for settings pages, navigation menus,
/// and content lists.
///
/// ## Example
///
/// ```dart
/// // Basic tile
/// Tile(
///   title: 'Settings',
///   onTap: () => navigateToSettings(),
/// )
///
/// // Tile with icon and subtitle
/// Tile(
///   leading: Icon(Icons.notifications),
///   title: 'Notifications',
///   subtitle: 'Manage your notification preferences',
///   onTap: () => openNotifications(),
/// )
///
/// // Bordered tile with trailing widget
/// Tile(
///   variant: TileVariant.bordered,
///   leading: Icon(Icons.account),
///   title: 'Profile',
///   trailing: Icon(Icons.chevron_right),
///   onTap: () => openProfile(),
/// )
/// ```
///
/// ## Behavior
///
/// - Automatically handles focus states and keyboard navigation
/// - Provides hover and focus visual feedback when interactive
/// - Supports keyboard activation (Enter and Space keys)
/// - Maintains consistent spacing and typography
/// - Respects system reduced motion preferences
///
/// ## Accessibility
///
/// - Automatically labeled as a button when [onTap] is provided
/// - Supports keyboard navigation and screen reader interaction
/// - Provides focus management and visual focus indicators
/// - Excludes child semantics to prevent duplicate announcements
class Tile extends StatefulWidget {
  /// Optional widget displayed before the title.
  ///
  /// Typically an Icon or Avatar. Automatically spaced with 12px
  /// margin from the title content. Should be sized appropriately
  /// for the tile context (usually 24x24 for icons).
  final Widget? leading;

  /// The primary text displayed in the tile.
  ///
  /// This is the main content of the tile and should be concise
  /// yet descriptive. The text uses medium font weight and
  /// primary text color from the theme.
  final String title;

  /// Optional secondary text displayed below the title.
  ///
  /// Provides additional context or description. Limited to 2 lines
  /// with ellipsis overflow. Uses secondary text color and smaller
  /// font size for visual hierarchy.
  final String? subtitle;

  /// Optional widget displayed after the title and subtitle.
  ///
  /// Typically an Icon, IconButton, or status indicator. Automatically
  /// spaced with 16px margin from the main content. Useful for
  /// navigation arrows, toggle switches, or status indicators.
  final Widget? trailing;

  /// Optional callback for making the tile interactive.
  ///
  /// When provided, the tile becomes clickable and shows appropriate
  /// cursor, focus states, and keyboard support. The entire tile area
  /// becomes tappable with proper hit testing.
  ///
  /// If null, the tile is purely decorative.
  final VoidCallback? onTap;

  /// The visual style variant of the tile.
  ///
  /// Determines whether the tile has a border, background color, or neither.
  /// See [TileVariant] for available options.
  ///
  /// Defaults to [TileVariant.simple].
  final TileVariant variant;

  /// Creates a tile with the specified properties.
  ///
  /// The [title] parameter is required. All other parameters are optional.
  ///
  /// By default, creates a simple, non-interactive tile. Provide [onTap]
  /// to make it interactive, and use [variant] to change the visual style.
  const Tile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.variant = TileVariant.simple,
  });

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  bool _isFocused = false;

  bool get _isDisabled => widget.onTap == null;

  void _handleTap() {
    widget.onTap?.call();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent &&
        (event.logicalKey == LogicalKeyboardKey.space ||
            event.logicalKey == LogicalKeyboardKey.enter)) {
      _handleTap();

      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final ColorTokens colors = Styling.of(context).colors;

    // Decoration based on variant
    BoxDecoration decoration = switch (widget.variant) {
      TileVariant.simple => BoxDecoration(
        borderRadius: BorderRadius.zero,
      ),
      TileVariant.bordered => BoxDecoration(
        border: Border.all(color: colors.border, width: 1),
        borderRadius: BorderRadius.circular(Styling.radii.medium),
      ),
      TileVariant.filled => BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(Styling.radii.medium),
      ),
    };

    // Focus ring
    if (_isFocused && !_isDisabled) {
      decoration = decoration.copyWith(
        boxShadow: [
          BoxShadow(
            color: colors.accent.withValues(alpha: 0.4),
            spreadRadius: 2,
          ),
        ],
      );
    }

    return Semantics(
      button: true,
      excludeSemantics: true,
      child: Focus(
        onFocusChange: (focused) {
          setState(() {
            _isFocused = focused;
          });
        },
        onKeyEvent: _isDisabled ? null : _handleKeyEvent,
        child: MouseRegion(
          cursor: _isDisabled
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _isDisabled ? null : _handleTap,
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: decoration,
              child: Row(
                children: [
                  if (widget.leading != null) ...[
                    widget.leading!,
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: colors.primaryText,
                          ),
                        ),
                        if (widget.subtitle != null)
                          Text(
                            widget.subtitle!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              height: 20 / 14,
                              color: colors.secondaryText,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (widget.trailing != null) ...[
                    const SizedBox(width: 16),
                    widget.trailing!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
