import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'styling.dart';
import 'toggle.dart';

/// Defines the visual style variants for the ToggleTile component.
///
/// Each variant provides a different visual treatment while maintaining
/// consistent layout and behavior across all variants.
enum ToggleTileVariant {
  /// Simple tile with no background or border
  simple,

  /// Tile with a border and transparent background
  bordered,

  /// Tile with a solid background color and no border
  filled,
}

/// A list item component with an integrated toggle switch.
///
/// ToggleTile combines the layout of a [Tile] with a [Toggle] component,
/// creating a perfect component for settings pages, preference lists,
/// and any interface where users need to toggle boolean options with
/// descriptive labels and additional context.
///
/// ## Example
///
/// ```dart
/// // Basic toggle tile
/// ToggleTile(
///   title: 'Enable Notifications',
///   value: _notificationsEnabled,
///   onChanged: (value) => setState(() => _notificationsEnabled = value),
/// )
///
/// // With icon and subtitle
/// ToggleTile(
///   leading: Icon(Icons.dark_mode),
///   title: 'Dark Mode',
///   subtitle: 'Reduce eye strain in low light environments',
///   value: _darkMode,
///   onChanged: (value) => setState(() => _darkMode = value),
/// )
///
/// // Bordered variant
/// ToggleTile(
///   variant: ToggleTileVariant.bordered,
///   leading: Icon(Icons.location_on),
///   title: 'Location Services',
///   subtitle: 'Allow app to access your location',
///   value: _locationEnabled,
///   onChanged: (value) => setState(() => _locationEnabled = value),
/// )
/// ```
///
/// ## Behavior
///
/// - Automatically handles focus states and keyboard navigation
/// - Provides hover and focus visual feedback when interactive
/// - Supports keyboard activation (Space key)
/// - Integrates seamlessly with Toggle component behavior
/// - Maintains consistent spacing and typography
///
/// ## Accessibility
///
/// - Automatically labeled as a toggle for screen readers
/// - Supports keyboard navigation and screen reader interaction
/// - Provides focus management and visual focus indicators
/// - Excludes child semantics to prevent duplicate announcements
class ToggleTile extends StatefulWidget {
  /// Optional widget displayed before the title.
  ///
  /// Typically an Icon or Avatar. Automatically spaced with 12px
  /// margin from the title content. Should be sized appropriately
  /// for the tile context (usually 24x24 for icons).
  final Widget? leading;

  /// The primary text displayed in the tile.
  ///
  /// This is the main content of the tile and should be concise
  /// yet descriptive of the setting being controlled. The text uses
  /// medium font weight and primary text color from the theme.
  final String title;

  /// Optional secondary text displayed below the title.
  ///
  /// Provides additional context or description about the toggle.
  /// Limited to 2 lines with ellipsis overflow. Uses secondary
  /// text color and smaller font size for visual hierarchy.
  final String? subtitle;

  /// Whether the toggle is in the 'on' position.
  ///
  /// When true, the integrated toggle switch shows the 'on' state.
  /// When false, it shows the 'off' state.
  final bool value;

  /// Callback function called when the toggle state changes.
  ///
  /// Called with the new boolean value when the user interacts with
  /// the toggle. If null, the entire tile is disabled and not interactive.
  final ValueChanged<bool>? onChanged;

  /// The visual style variant of the tile.
  ///
  /// Determines whether the tile has a border, background color, or neither.
  /// See [ToggleTileVariant] for available options.
  ///
  /// Defaults to [ToggleTileVariant.simple].
  final ToggleTileVariant variant;

  /// Creates a toggle tile with the specified properties.
  ///
  /// The [title] and [value] parameters are required. All other parameters are optional.
  ///
  /// By default, creates a simple tile. Use [variant] to change the visual style,
  /// [leading] for an icon, [subtitle] for additional context, and [onChanged]
  /// to handle toggle interactions.
  const ToggleTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    required this.value,
    this.onChanged,
    this.variant = ToggleTileVariant.simple,
  });

  @override
  State<ToggleTile> createState() => _ToggleTileState();
}

class _ToggleTileState extends State<ToggleTile> {
  bool _isFocused = false;

  bool get _isDisabled => widget.onChanged == null;

  void _handleTap() {
    widget.onChanged?.call(!widget.value);
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {
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
      ToggleTileVariant.simple => BoxDecoration(
        borderRadius: BorderRadius.zero,
      ),
      ToggleTileVariant.bordered => BoxDecoration(
        border: Border.all(color: colors.border, width: 1),
        borderRadius: BorderRadius.circular(Styling.radii.medium),
      ),
      ToggleTileVariant.filled => BoxDecoration(
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
      toggled: widget.value,
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
                  const SizedBox(width: 16),
                  Toggle(
                    value: widget.value,
                    onChanged: widget.onChanged,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
