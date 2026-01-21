import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class NavBarItem {
  final Widget icon;
  final String label;

  const NavBarItem({required this.icon, required this.label});
}

class NavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavBarItem> items;
  final Widget body;
  final Widget? railHeader;
  final Widget? railFooter;
  final double railWidth;

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
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                widget.icon,
                const SizedBox(width: 16),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: navColors.railItemText,
                    fontSize: 16,
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
              style: TextStyle(color: color, fontSize: 12, height: 16 / 12),
            ),
          ],
        ),
      ),
    );
  }
}
