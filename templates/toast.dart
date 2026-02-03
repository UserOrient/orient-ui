import 'dart:async';

import 'package:flutter/widgets.dart';

import 'styling.dart';

enum ToastType { success, error, info, warning }

enum ToastPosition { top, bottom }

const Duration _toastDuration = Duration(milliseconds: 3000);

List<_ToastEntry> _activeToasts = [];

/// Show a toast notification
void showToast({
  required BuildContext context,
  required String message,
  ToastType type = ToastType.success,
  ToastPosition position = ToastPosition.top,
}) {
  final overlayState = Navigator.of(context).overlay;
  if (overlayState == null) return;

  late final _ToastEntry entry;
  late final OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (_) => _ToastWidget(
      key: entry.key,
      message: message,
      type: type,
      position: position,
      onRemove: () {
        overlayEntry.remove();
        _activeToasts.remove(entry);
        _repositionToasts();
      },
      getOffset: () => _calculateOffset(entry),
    ),
  );

  entry = _ToastEntry(
    key: GlobalKey<_ToastWidgetState>(),
    overlayEntry: overlayEntry,
  );

  _activeToasts.add(entry);
  overlayState.insert(overlayEntry);
}

/// Dismiss all active toasts
void dismissAllToasts() {
  for (final entry in _activeToasts) {
    entry.overlayEntry.remove();
  }
  _activeToasts.clear();
}

double _calculateOffset(_ToastEntry self) {
  final index = _activeToasts.indexOf(self);
  if (index == -1) return 0;
  final stackIndex = _activeToasts.length - 1 - index;
  return stackIndex * 8.0;
}

void _repositionToasts() {
  for (final entry in _activeToasts) {
    entry.key.currentState?.updatePosition();
  }
}

class _ToastEntry {
  final GlobalKey<_ToastWidgetState> key;
  final OverlayEntry overlayEntry;

  _ToastEntry({required this.key, required this.overlayEntry});
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;
  final ToastPosition position;
  final VoidCallback onRemove;
  final double Function() getOffset;

  const _ToastWidget({
    super.key,
    required this.message,
    required this.type,
    required this.position,
    required this.onRemove,
    required this.getOffset,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  Timer? _dismissTimer;
  bool _isExiting = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Styling.durations.slow,
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    final slideBegin = widget.position == ToastPosition.top
        ? const Offset(0, -1)
        : const Offset(0, 1);

    _slideAnimation = Tween<Offset>(
      begin: slideBegin,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    _scheduleAutoDismiss();
  }

  void _scheduleAutoDismiss() {
    _dismissTimer = Timer(_toastDuration, () {
      if (mounted && !_isExiting) {
        _exit();
      }
    });
  }

  void _exit() {
    if (_isExiting) return;
    _isExiting = true;
    _controller.reverse().then((_) {
      if (mounted) widget.onRemove();
    });
  }

  void updatePosition() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styling = Styling.of(context);
    final toastColors = styling.colors.toast;
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top;
    final bottomPadding = mediaQuery.padding.bottom;

    final offset = widget.getOffset();
    final isTop = widget.position == ToastPosition.top;

    const fgColor = Color(0xFFFFFFFF);
    final bgColor = switch (widget.type) {
      ToastType.success => toastColors.success,
      ToastType.error => toastColors.error,
      ToastType.info => toastColors.info,
      ToastType.warning => toastColors.warning,
    };

    return Directionality(
      textDirection: TextDirection.ltr,
      child: AnimatedPositioned(
        duration: Styling.durations.normal,
        curve: Curves.easeOut,
        left: 0,
        right: 0,
        top: isTop ? topPadding + 12 + offset : null,
        bottom: !isTop ? bottomPadding + 12 + offset : null,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Dismissible(
              key: UniqueKey(),
              direction: isTop ? DismissDirection.up : DismissDirection.down,
              onDismissed: (_) => widget.onRemove(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Semantics(
                    liveRegion: true,
                    label: '${widget.type.name}: ${widget.message}',
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(Styling.radii.medium),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 2,
                            color: const Color(0xFF000000).withOpacity(0.08),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ToastIcon(type: widget.type, color: fgColor),
                          const SizedBox(width: 8),
                          Text(
                            widget.message,
                            style: TextStyle(
                              color: fgColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ToastIcon extends StatelessWidget {
  final ToastType type;
  final Color color;

  const _ToastIcon({required this.type, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: CustomPaint(
        painter: _ToastIconPainter(type: type, color: color),
      ),
    );
  }
}

class _ToastIconPainter extends CustomPainter {
  final ToastType type;
  final Color color;

  _ToastIconPainter({required this.type, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final center = Offset(w / 2, h / 2);
    final radius = w * 0.45;

    switch (type) {
      case ToastType.success:
        // Circle + checkmark
        canvas.drawCircle(center, radius, strokePaint);
        final path = Path()
          ..moveTo(w * 0.28, h * 0.5)
          ..lineTo(w * 0.44, h * 0.66)
          ..lineTo(w * 0.72, h * 0.36);
        canvas.drawPath(path, strokePaint);
        break;

      case ToastType.error:
        // Circle + X
        canvas.drawCircle(center, radius, strokePaint);
        canvas.drawLine(
          Offset(w * 0.32, h * 0.32),
          Offset(w * 0.68, h * 0.68),
          strokePaint,
        );
        canvas.drawLine(
          Offset(w * 0.68, h * 0.32),
          Offset(w * 0.32, h * 0.68),
          strokePaint,
        );
        break;

      case ToastType.info:
        // Circle + "i"
        canvas.drawCircle(center, radius, strokePaint);
        canvas.drawCircle(Offset(w * 0.5, h * 0.32), 1.2, fillPaint);
        canvas.drawLine(
          Offset(w * 0.5, h * 0.46),
          Offset(w * 0.5, h * 0.72),
          strokePaint,
        );
        break;

      case ToastType.warning:
        // Triangle + "!"
        final path = Path()
          ..moveTo(w * 0.5, h * 0.08)
          ..lineTo(w * 0.92, h * 0.88)
          ..lineTo(w * 0.08, h * 0.88)
          ..close();
        canvas.drawPath(path, strokePaint);
        canvas.drawLine(
          Offset(w * 0.5, h * 0.36),
          Offset(w * 0.5, h * 0.58),
          strokePaint,
        );
        canvas.drawCircle(Offset(w * 0.5, h * 0.72), 1.2, fillPaint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _ToastIconPainter oldDelegate) {
    return oldDelegate.type != type || oldDelegate.color != color;
  }
}
