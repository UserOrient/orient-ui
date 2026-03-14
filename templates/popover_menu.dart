import 'package:flutter/widgets.dart';

import 'style.dart';

const double _itemHeight = 48.0;
const double _verticalPadding = 4.0;
const double _iconSize = 24.0;
const double _iconLabelGap = 12.0;
const double _horizontalPadding = 16.0;
const double _rightBreathing = 40.0;
const double _minWidth = 220.0;
const double _gap = 4.0;

/// Wraps a trigger widget. Tapping the trigger opens a floating
/// menu anchored to it. The menu auto-positions itself to stay
/// on screen (flips up/down, shifts left/right).
///
/// Can also be used imperatively via [PopoverMenu.show].
class PopoverMenu extends StatefulWidget {
  final Widget child;
  final List<PopoverMenuItem> items;

  const PopoverMenu({
    super.key,
    required this.child,
    required this.items,
  });

  /// Opens a popover menu anchored to the widget at [context].
  /// Call this from any tap handler — no wrapper widget needed.
  static void show({
    required BuildContext context,
    required List<PopoverMenuItem> items,
  }) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size triggerSize = renderBox.size;
    final Offset triggerPos = renderBox.localToGlobal(Offset.zero);
    final Size screenSize = MediaQuery.of(context).size;

    final TextDirection direction = Directionality.of(context);
    final double menuWidth = _measureMenuWidth(items);
    final double menuHeight = _measureMenuHeight(items);
    final Offset position = _calculatePosition(
      triggerSize: triggerSize,
      triggerPos: triggerPos,
      screenSize: screenSize,
      menuWidth: menuWidth,
      menuHeight: menuHeight,
    );

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (BuildContext overlayContext) {
        final ColorTokens colors = Style.of(overlayContext).colors;

        return Directionality(
          textDirection: direction,
          child: DefaultTextStyle(
            style: Style.of(overlayContext).typography.body,
            child: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      entry.remove();
                    },
                    behavior: HitTestBehavior.translucent,
                  ),
                ),
                Positioned(
                  left: position.dx,
                  top: position.dy,
                  child: _MenuPanel(
                    width: menuWidth,
                    colors: colors,
                    items: items,
                    onItemTap: (PopoverMenuItem item) {
                      item.onTap?.call();
                      entry.remove();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(entry);
  }

  @override
  State<PopoverMenu> createState() {
    return _PopoverMenuState();
  }
}

// Uses TextPainter to find the widest label, then adds
// icon space + padding + breathing room.
double _measureMenuWidth(List<PopoverMenuItem> items) {
  const TextStyle labelStyle = TextStyle(fontSize: 16, height: 1);
  double maxLabelWidth = 0;

  for (final PopoverMenuItem item in items) {
    final TextPainter tp = TextPainter(
      text: TextSpan(text: item.label, style: labelStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    if (tp.width > maxLabelWidth) maxLabelWidth = tp.width;
  }

  final bool hasIcons = items.any((PopoverMenuItem i) {
    return i.icon != null;
  });
  final double iconSpace = hasIcons ? _iconSize + _iconLabelGap : 0;
  final double intrinsic =
      _horizontalPadding +
      iconSpace +
      maxLabelWidth +
      _rightBreathing +
      _horizontalPadding;

  return intrinsic < _minWidth ? _minWidth : intrinsic;
}

double _measureMenuHeight(List<PopoverMenuItem> items) {
  return items.length * _itemHeight + _verticalPadding * 2;
}

// Computes absolute screen position for the menu.
// Prefers below + left-aligned. Flips up if clipped at bottom,
// shifts left if clipped at right edge.
Offset _calculatePosition({
  required Size triggerSize,
  required Offset triggerPos,
  required Size screenSize,
  required double menuWidth,
  required double menuHeight,
}) {
  final double spaceBelow =
      screenSize.height - triggerPos.dy - triggerSize.height;
  final double spaceAbove = triggerPos.dy;
  final bool openUpward =
      spaceBelow < menuHeight + _gap && spaceAbove > spaceBelow;

  final double top = openUpward
      ? triggerPos.dy - menuHeight - _gap
      : triggerPos.dy + triggerSize.height + _gap;

  double left = triggerPos.dx;
  if (left + menuWidth > screenSize.width - 8) {
    left = triggerPos.dx + triggerSize.width - menuWidth;
  }

  return Offset(left, top);
}

class _PopoverMenuState extends State<PopoverMenu> {
  bool _isOpen = false;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _triggerKey = GlobalKey();

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  void _toggle() {
    _isOpen ? _close() : _open();
  }

  void _open() {
    final RenderBox renderBox =
        _triggerKey.currentContext!.findRenderObject() as RenderBox;
    final Size triggerSize = renderBox.size;
    final Offset triggerPos = renderBox.localToGlobal(Offset.zero);
    final Size screenSize = MediaQuery.of(context).size;

    final double menuWidth = _measureMenuWidth(widget.items);
    final double menuHeight = _measureMenuHeight(widget.items);
    final Offset offset = _calculateOffset(
      triggerSize: triggerSize,
      triggerPos: triggerPos,
      screenSize: screenSize,
      menuWidth: menuWidth,
      menuHeight: menuHeight,
    );

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        final ColorTokens colors = Style.of(context).colors;

        // DefaultTextStyle prevents yellow underlines in overlays
        return DefaultTextStyle(
          style: Style.of(context).typography.body,
          child: Stack(
            children: [
              // Tap outside to dismiss
              Positioned.fill(
                child: GestureDetector(
                  onTap: _close,
                  behavior: HitTestBehavior.translucent,
                ),
              ),
              Positioned(
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: offset,
                  child: _MenuPanel(
                    width: menuWidth,
                    colors: colors,
                    items: widget.items,
                    onItemTap: (PopoverMenuItem item) {
                      item.onTap?.call();
                      _close();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  // Offset relative to the LayerLink anchor.
  Offset _calculateOffset({
    required Size triggerSize,
    required Offset triggerPos,
    required Size screenSize,
    required double menuWidth,
    required double menuHeight,
  }) {
    final double spaceBelow =
        screenSize.height - triggerPos.dy - triggerSize.height;
    final double spaceAbove = triggerPos.dy;
    final bool openUpward =
        spaceBelow < menuHeight + _gap && spaceAbove > spaceBelow;
    final double dy = openUpward
        ? -menuHeight - _gap
        : triggerSize.height + _gap;

    double dx = 0;
    if (triggerPos.dx + menuWidth > screenSize.width - 8) {
      dx = triggerSize.width - menuWidth;
    }

    return Offset(dx, dy);
  }

  void _close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        key: _triggerKey,
        onTap: _toggle,
        behavior: HitTestBehavior.translucent,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: widget.child,
        ),
      ),
    );
  }
}

// The floating container that holds all menu items.
class _MenuPanel extends StatelessWidget {
  final double width;
  final ColorTokens colors;
  final List<PopoverMenuItem> items;
  final ValueChanged<PopoverMenuItem> onItemTap;

  const _MenuPanel({
    required this.width,
    required this.colors,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
      decoration: BoxDecoration(
        color: colors.background,
        border: Border.all(color: colors.borderSubtle),
        borderRadius: BorderRadius.circular(Style.radii.medium),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Style.radii.medium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final PopoverMenuItem item in items)
              _MenuItemWidget(
                item: item,
                colors: colors,
                onTap: () {
                  onItemTap(item);
                },
              ),
          ],
        ),
      ),
    );
  }
}

// Single row: optional icon + label, with hover highlight.
class _MenuItemWidget extends StatefulWidget {
  final PopoverMenuItem item;
  final ColorTokens colors;
  final VoidCallback onTap;

  const _MenuItemWidget({
    required this.item,
    required this.colors,
    required this.onTap,
  });

  @override
  State<_MenuItemWidget> createState() {
    return _MenuItemWidgetState();
  }
}

class _MenuItemWidgetState extends State<_MenuItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: _itemHeight,
          padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
          color: _isHovered
              ? widget.colors.surfaceContainer
              : widget.colors.background,
          child: Row(
            children: [
              if (widget.item.icon != null) ...[
                IconTheme(
                  data: IconThemeData(
                    size: _iconSize,
                    color: widget.colors.foreground,
                  ),
                  child: widget.item.icon!,
                ),
                const SizedBox(width: _iconLabelGap),
              ],
              Expanded(
                child: Text(
                  widget.item.label,
                  style: context.typography.subtitle.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopoverMenuItem {
  final Widget? icon;
  final String label;
  final VoidCallback? onTap;

  const PopoverMenuItem({
    this.icon,
    required this.label,
    this.onTap,
  });
}
