import 'dart:async';

import 'styling.dart';
import 'package:flutter/widgets.dart';

/// Duration for how long a toast remains visible before auto-dismissing.
const Duration _toastDuration = Duration(milliseconds: 3000);

/// Internal list tracking all currently active toast notifications.
List<_ToastEntry> _activeToasts = [];

/// A utility class for displaying non-intrusive toast notifications.
///
/// Toast provides a simple way to show temporary messages that appear
/// briefly on screen and automatically dismiss. They're perfect for
/// confirming actions, showing status updates, or providing brief feedback.
///
/// ## Example
///
/// ```dart
/// // Basic success toast
/// Toast.show(
///   context: context,
///   message: 'Settings saved successfully',
///   type: ToastType.success,
/// )
///
/// // Error toast at bottom
/// Toast.show(
///   context: context,
///   message: 'Failed to connect to server',
///   type: ToastType.error,
///   position: ToastPosition.bottom,
/// )
///
/// // Clear all active toasts
/// Toast.dismissAll();
/// ```
///
/// ## Behavior
///
/// - Auto-dismisses after 3 seconds
/// - Supports stacking multiple toasts
/// - Swipe to dismiss on supported platforms
/// - Respects safe areas and system UI
/// - Includes semantic labels for accessibility
///
/// ## Toast Types
///
/// - [ToastType.success] - Green checkmark for successful actions
/// - [ToastType.error] - Red X for errors and failures
/// - [ToastType.info] - Blue 'i' for informational messages
/// - [ToastType.warning] - Orange triangle for warnings
///
/// ## Positioning
///
/// - [ToastPosition.top] - Appears below the status bar
/// - [ToastPosition.bottom] - Appears above the navigation bar
///
/// ## Accessibility
///
/// - Automatically announced by screen readers
/// - Includes semantic labels with toast type and message
/// - Supports dismiss gestures for accessibility
class Toast {
  Toast._();

  /// Displays a toast notification with the specified message and styling.
  ///
  /// The toast will appear with a slide-in animation, remain visible for
  /// 3 seconds, then dismiss with a slide-out animation. Multiple toasts
  /// will stack vertically with 8px spacing.
  ///
  /// [context] is required and must have an accessible Overlay.
  /// [message] is the text content to display in the toast.
  /// [type] determines the icon and color scheme. Defaults to [ToastType.success].
  /// [position] controls where the toast appears. Defaults to [ToastPosition.top].
  ///
  /// If no overlay is available (e.g., during navigation transitions),
  /// the toast will not be displayed.
  static void show({
    required BuildContext context,
    required String message,
    ToastType type = ToastType.success,
    ToastPosition position = ToastPosition.top,
  }) {
    final OverlayState? overlayState = Navigator.of(context).overlay;
    if (overlayState == null) return;

    late final _ToastEntry entry;
    late final OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (_) {
        return _ToastWidget(
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
        );
      },
    );

    entry = _ToastEntry(
      key: GlobalKey<_ToastWidgetState>(),
      overlayEntry: overlayEntry,
    );

    _activeToasts.add(entry);
    overlayState.insert(overlayEntry);
  }

  /// Dismisses all currently active toast notifications.
  ///
  /// This method immediately removes all toasts from the screen,
  /// canceling any ongoing animations. Use this to clear the
  /// toast queue when navigating to a new screen or when
  /// user action makes the toasts irrelevant.
  static void dismissAll() {
    for (final _ToastEntry entry in _activeToasts) {
      entry.overlayEntry.remove();
    }

    _activeToasts.clear();
  }
}

double _calculateOffset(_ToastEntry self) {
  final int index = _activeToasts.indexOf(self);
  if (index == -1) return 0;

  final int stackIndex = _activeToasts.length - 1 - index;

  return stackIndex * 8.0;
}

void _repositionToasts() {
  for (final _ToastEntry entry in _activeToasts) {
    entry.key.currentState?.updatePosition();
  }
}

/// Defines the visual style and semantic meaning of a toast notification.
///
/// Each type includes a distinctive icon and color scheme that
/// conveys the nature of the message to users.
enum ToastType {
  /// Green toast with checkmark icon for successful actions
  success,

  /// Red toast with X icon for errors and failures
  error,

  /// Blue toast with 'i' icon for informational messages
  info,

  /// Orange toast with triangle icon for warnings
  warning,
}

/// Defines the vertical position where toast notifications appear.
///
/// Position affects the animation direction and respects system UI
/// elements like status bars and navigation bars.
enum ToastPosition {
  /// Toasts appear below the status bar and slide down from top
  top,

  /// Toasts appear above the navigation bar and slide up from bottom
  bottom,
}

class _ToastEntry {
  final GlobalKey<_ToastWidgetState> key;
  final OverlayEntry overlayEntry;

  _ToastEntry({
    required this.key,
    required this.overlayEntry,
  });
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
      duration: Styling.durations.normal,
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
                        borderRadius: BorderRadius.circular(
                          Styling.radii.medium,
                        ),
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

  const _ToastIcon({
    required this.type,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: CustomPaint(
        painter: _ToastIconPainter(
          type: type,
          color: color,
        ),
      ),
    );
  }
}

class _ToastIconPainter extends CustomPainter {
  final ToastType type;
  final Color color;

  _ToastIconPainter({
    required this.type,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint strokePaint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final Paint fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double w = size.width;
    final double h = size.height;
    final Offset center = Offset(w / 2, h / 2);
    final double radius = w * 0.45;

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
        final Path path = Path()
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
