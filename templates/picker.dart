import 'package:flutter/widgets.dart';

import 'style.dart';

class Picker<T> extends StatefulWidget {
  final String? label;
  final T? value;
  final ValueChanged<T>? onChanged;
  final List<T> items;
  final String Function(T)? itemLabel;

  const Picker({
    super.key,
    this.label,
    this.value,
    this.onChanged,
    required this.items,
    this.itemLabel,
  });

  @override
  State<Picker<T>> createState() {
    return _PickerState<T>();
  }
}

class _PickerState<T> extends State<Picker<T>> {
  bool _isOpen = false;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _triggerKey = GlobalKey();

  @override
  void dispose() {
    _close();
    super.dispose();
  }

  String _labelFor(T item) {
    return widget.itemLabel?.call(item) ?? item.toString();
  }

  void _toggle() {
    if (_isOpen) {
      _close();
    } else {
      _open();
    }
  }

  void _open() {
    _overlayEntry = _buildOverlay();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  void _close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOpen = false;
    });
  }

  void _select(T item) {
    widget.onChanged?.call(item);
    _close();
  }

  OverlayEntry _buildOverlay() {
    final RenderBox renderBox =
        _triggerKey.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset position = renderBox.localToGlobal(Offset.zero);

    final double screenHeight = MediaQuery.of(context).size.height;

    const double itemHeight = 48.0;
    final double menuHeight = widget.items.length * itemHeight;

    // Open upward if there's not enough space below
    final double spaceBelow = screenHeight - position.dy - size.height;
    final double spaceAbove = position.dy;
    final bool openUpward =
        spaceBelow < menuHeight + 4 && spaceAbove > spaceBelow;

    final Offset offset = openUpward
        ? Offset(0, -menuHeight - 4)
        : Offset(0, size.height + 4);

    return OverlayEntry(
      builder: (BuildContext context) {
        final Style style = Style.of(context);
        final ColorTokens colors = style.colors;

        // Overlays lack a DefaultTextStyle, causing yellow underlines
        return DefaultTextStyle(
          style: style.typography.body,
          child: Stack(
            children: [
              // Tap outside to close
              Positioned.fill(
                child: GestureDetector(
                  onTap: _close,
                  behavior: HitTestBehavior.translucent,
                ),
              ),
              Positioned(
                width: size.width,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: offset,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.background,
                      border: Border.all(color: colors.borderSubtle),
                      borderRadius: BorderRadius.circular(
                        Style.radii.medium,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF000000,
                          ).withValues(alpha: 0.08),
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
                          for (final T item in widget.items)
                            _PickerItem(
                              label: _labelFor(item),
                              isSelected: item == widget.value,
                              colors: colors,
                              onTap: () {
                                _select(item);
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);
    final ColorTokens colors = style.colors;

    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          key: _triggerKey,
          onTap: _toggle,
          behavior: HitTestBehavior.translucent,
          child: Container(
            height: 52,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: colors.background,
              border: Border.all(color: colors.border),
              borderRadius: BorderRadius.circular(Style.radii.medium),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.label != null)
                        Text(
                          widget.label!,
                          style: context.typography.bodySmall.muted(context),
                        ),
                      Text(
                        widget.value != null
                            ? _labelFor(widget.value as T)
                            : '',
                        style: context.typography.subtitle.w400,
                      ),
                    ],
                  ),
                ),
                _PickerChevron(
                  isOpen: _isOpen,
                  color: colors.mutedForeground,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PickerItem extends StatefulWidget {
  final String label;
  final bool isSelected;
  final ColorTokens colors;
  final VoidCallback onTap;

  const _PickerItem({
    required this.label,
    required this.isSelected,
    required this.colors,
    required this.onTap,
  });

  @override
  State<_PickerItem> createState() {
    return _PickerItemState();
  }
}

class _PickerItemState extends State<_PickerItem> {
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
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          color: _isHovered
              ? widget.colors.surfaceContainer
              : widget.colors.background,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.label,
                  style: context.typography.subtitle.w400.withColor(
                    widget.isSelected
                        ? widget.colors.accent
                        : widget.colors.foreground,
                  ),
                ),
              ),
              if (widget.isSelected)
                CustomPaint(
                  size: const Size(16, 16),
                  painter: _CheckPainter(color: widget.colors.accent),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PickerChevron extends StatefulWidget {
  final bool isOpen;
  final Color color;

  const _PickerChevron({
    required this.isOpen,
    required this.color,
  });

  @override
  State<_PickerChevron> createState() {
    return _PickerChevronState();
  }
}

class _PickerChevronState extends State<_PickerChevron>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Style.durations.normal,
      vsync: this,
      value: widget.isOpen ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(_PickerChevron oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      if (widget.isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween<double>(begin: 0.0, end: 0.5).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
      ),
      child: CustomPaint(
        size: const Size(20, 20),
        painter: _ChevronPainter(color: widget.color),
      ),
    );
  }
}

class _CheckPainter extends CustomPainter {
  final Color color;

  _CheckPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.5)
      ..lineTo(size.width * 0.4, size.height * 0.7)
      ..lineTo(size.width * 0.8, size.height * 0.3);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CheckPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}

class _ChevronPainter extends CustomPainter {
  final Color color;

  _ChevronPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.25
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..moveTo(5, 7.5)
      ..lineTo(10, 12.5)
      ..lineTo(15, 7.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ChevronPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
