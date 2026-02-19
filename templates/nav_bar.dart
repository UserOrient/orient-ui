import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'styling.dart';

/// Represents a navigation item in the NavBar component.
///
/// Each item contains an icon and label that will be displayed
/// in either the navigation rail (desktop) or bottom navigation bar (mobile).
class NavBarItem {
  /// The icon widget displayed for this navigation item.
  ///
  /// Typically an Icon widget. Should be sized appropriately for
  /// the navigation context (24x24 for rail, 24x24 for bottom bar).
  final Widget icon;

  /// The text label displayed for this navigation item.
  ///
  /// Used for accessibility labels and as text in the navigation
  /// rail. Should be concise yet descriptive.
  final String label;

  /// Creates a navigation item with the specified icon and label.
  ///
  /// Both [icon] and [label] are required.
  const NavBarItem({required this.icon, required this.label});
}

/// A responsive navigation component that adapts between rail and bottom bar layouts.
///
/// NavBar automatically switches between a side navigation rail on desktop
/// (width >= 600px) and a bottom navigation bar on mobile devices.
/// It provides a consistent navigation experience across all screen sizes
/// with proper accessibility and responsive design.
///
/// ## Example
///
/// ```dart
/// // Basic navigation
/// int _currentIndex = 0;
/// NavBar(
///   currentIndex: _currentIndex,
///   onTap: (index) => setState(() => _currentIndex = index),
///   items: [
///     NavBarItem(icon: Icon(Icons.home), label: 'Home'),
///     NavBarItem(icon: Icon(Icons.search), label: 'Search'),
///     NavBarItem(icon: Icon(Icons.profile), label: 'Profile'),
///   ],
///   body: _getCurrentPage(),
/// )
///
/// // With header and footer (desktop only)
/// NavBar(
///   currentIndex: _currentIndex,
///   onTap: (index) => setState(() => _currentIndex = index),
///   items: _navItems,
///   body: _getCurrentPage(),
///   railHeader: UserAvatar(),
///   railFooter: SettingsButton(),
///   railWidth: 280,
/// )
/// ```
///
/// ## Behavior
///
/// - Automatically switches between rail and bottom bar based on screen width
/// - Provides haptic feedback on mobile navigation
/// - Maintains active state with proper visual indicators
/// - Supports optional header and footer on desktop rail
/// - Respects system safe areas and navigation bars
///
/// ## Accessibility
///
/// - Each navigation item is properly labeled for screen readers
/// - Supports keyboard navigation and screen reader interaction
/// - Provides semantic state information for active items
/// - Includes proper focus management
class NavBar extends StatelessWidget {
  /// The index of the currently active navigation item.
  ///
  /// Determines which item appears as selected and receives
  /// the active styling treatment.
  final int currentIndex;

  /// Callback function called when a navigation item is tapped.
  ///
  /// Called with the index of the selected item. Use this to
  /// update the current page or navigation state.
  final ValueChanged<int> onTap;

  /// The list of navigation items to display.
  ///
  /// Must contain at least 2 items. Each item will be displayed
  /// with its icon and label in the appropriate navigation layout.
  final List<NavBarItem> items;

  /// The main content widget displayed alongside the navigation.
  ///
  /// This is typically a Scaffold or page content that occupies
  /// the main area of the screen. Takes up all available space
  /// next to the navigation rail or above the bottom bar.
  final Widget body;

  /// Optional widget displayed at the top of the navigation rail (desktop only).
  ///
  /// Useful for user avatars, logos, or branding elements.
  /// Only visible when the navigation rail is shown on desktop.
  final Widget? railHeader;

  /// Optional widget displayed at the bottom of the navigation rail (desktop only).
  ///
  /// Useful for settings buttons, logout controls, or secondary actions.
  /// Only visible when the navigation rail is shown on desktop.
  final Widget? railFooter;

  /// The width of the navigation rail when displayed on desktop.
  ///
  /// Defaults to 240 pixels. Adjust this based on your content
  /// needs and design requirements.
  final double railWidth;

  /// Creates a responsive navigation bar.
  ///
  /// The [currentIndex], [onTap], [items], and [body] parameters are required.
  /// The [railHeader], [railFooter], and [railWidth] parameters are optional
  /// and only affect the desktop navigation rail appearance.
  ///
  /// Asserts that at least 2 navigation items are provided.
  const NavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    required this.body,
    this.railHeader,
    this.railFooter,
    this.railWidth = 240,
  }) : assert(items.length >= 2, 'At least 2 navigation items required');

  @override
  Widget build(BuildContext context) {
    final StylingData styling = Styling.of(context);
    final bool isDesktop =
        MediaQuery.of(context).size.width >= styling.breakpoints.desktop;

    if (isDesktop) {
      return Row(
        children: [
          _NavigationRail(
            currentIndex: currentIndex,
            onTap: onTap,
            items: items,
            header: railHeader,
            footer: railFooter,
            width: railWidth,
          ),
          Expanded(child: body),
        ],
      );
    }

    return Column(
      children: [
        Expanded(child: body),
        _BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          items: items,
        ),
      ],
    );
  }
}

class _NavigationRail extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavBarItem> items;
  final Widget? header;
  final Widget? footer;
  final double width;

  const _NavigationRail({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.header,
    this.footer,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final styling = Styling.of(context);
    final navColors = styling.colors.navigation;

    return Container(
      width: width,
      color: navColors.railBackground,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          if (header != null) ...[
            const SizedBox(height: 24),
            header!,
            const SizedBox(height: 32),
          ] else
            const SizedBox(height: 24),
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: _RailItem(
                icon: item.icon,
                label: item.label,
                active: index == currentIndex,
                onTap: () => onTap(index),
              ),
            );
          }),
          if (footer != null) ...[
            const Spacer(),
            footer!,
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }
}

class _RailItem extends StatefulWidget {
  final Widget icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _RailItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  State<_RailItem> createState() => _RailItemState();
}

class _RailItemState extends State<_RailItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final StylingData styling = Styling.of(context);
    final NavigationColors navColors = styling.colors.navigation;

    Color? backgroundColor;
    if (widget.active) {
      backgroundColor = navColors.railItemBackgroundActive;
    } else if (_isHovered) {
      backgroundColor = navColors.railItemBackgroundHover;
    }

    return Semantics(
      button: true,
      label: widget.label,
      selected: widget.active,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(Styling.radii.medium),
            ),
            child: Row(
              children: [
                widget.icon,
                const SizedBox(width: 16),
                Text(
                  widget.label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: navColors.railItemText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavBarItem> items;

  const _BottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final styling = Styling.of(context);
    final navColors = styling.colors.navigation;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: navColors.bottomBarBackground,
        border: Border(top: BorderSide(color: styling.colors.border, width: 1)),
      ),
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: SizedBox(
        height: 72,
        child: Row(
          children: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Expanded(
              child: _BottomBarItem(
                icon: item.icon,
                label: item.label,
                active: index == currentIndex,
                onTap: () => onTap(index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _BottomBarItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final styling = Styling.of(context);
    final navColors = styling.colors.navigation;

    final Color color = active
        ? navColors.bottomBarItemActive
        : navColors.bottomBarItemInactive;

    return Semantics(
      button: true,
      label: label,
      selected: active,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onTap.call();

          HapticFeedback.selectionClick();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconTheme(
              data: IconThemeData(color: color, size: 24),
              child: icon,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 12,
                height: 16 / 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
