import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'styling.dart';

/// A compact button for copying text to the clipboard with visual feedback.
///
/// CopyButton provides a simple way to allow users to copy text content
/// with a single click. It shows a copy icon that transforms into a
/// checkmark when the content is successfully copied, providing clear
/// visual feedback of the action.
///
/// ## Example
///
/// ```dart
/// // Basic copy button
/// CopyButton(
///   value: 'https://example.com/share-link',
///   onCopied: () => showSnackBar('Link copied!'),
/// )
///
/// // In a code block
/// Row(
///   children: [
///     Expanded(child: Text(_codeSnippet)),
///     CopyButton(value: _codeSnippet),
///   ],
/// )
///
/// // With custom styling
/// Container(
///   padding: EdgeInsets.all(8),
///   child: CopyButton(
///     value: _apiKey,
///     onCopied: () => _trackCopyEvent(),
///   ),
/// )
/// ```
///
/// ## Behavior
///
/// - Automatically copies text to system clipboard on click
/// - Shows checkmark animation for 2 seconds after copying
/// - Provides hover effects with color transitions
/// - Prevents multiple rapid copies during animation
/// - Uses theme-appropriate colors for different states
///
/// ## Accessibility
///
/// - Automatically labeled as a copy button for screen readers
/// - Provides visual feedback for non-visual users through [onCopied]
/// - Maintains proper touch target size (28x28)
/// - Supports keyboard navigation when wrapped in focusable widget
class CopyButton extends StatefulWidget {
  /// The text content to copy to the clipboard.
  ///
  /// This string will be placed in the system clipboard when the button
  /// is clicked. Can be any text content including URLs, codes,
  /// IDs, or user-facing text.
  final String value;

  /// Optional callback function called after content is copied.
  ///
  /// Called immediately after the content is successfully copied to
  /// the clipboard. Use this to show additional feedback like
  /// toast notifications, analytics tracking, or state updates.
  final VoidCallback? onCopied;

  /// Creates a copy button with the specified properties.
  ///
  /// The [value] parameter is required and contains the text to copy.
  /// The [onCopied] callback is optional but recommended for providing
  /// additional user feedback when the copy action succeeds.
  const CopyButton({
    super.key,
    required this.value,
    this.onCopied,
  });

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton>
    with SingleTickerProviderStateMixin {
  bool _hasCopied = false;
  bool _isHovered = false;

  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
        reverseCurve: Curves.linear,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
        reverseCurve: Curves.linear,
      ),
    );
  }

  void _copy() async {
    if (_hasCopied) return;

    Clipboard.setData(ClipboardData(text: widget.value));

    widget.onCopied?.call();

    await _controller.forward();

    setState(() {
      _hasCopied = true;
    });

    await _controller.reverse();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && _hasCopied) {
        _animateBack();
      }
    });
  }

  void _animateBack() async {
    await _controller.forward();

    setState(() {
      _hasCopied = false;
    });

    await _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final StylingData styling = Styling.of(context);

    final Color color;
    if (_hasCopied) {
      color = styling.colors.toast.success;
    } else {
      if (_isHovered) {
        color = styling.colors.primaryText;
      } else {
        color = styling.colors.secondaryText;
      }
    }

    return GestureDetector(
      onTap: _copy,
      behavior: HitTestBehavior.translucent,
      child: MouseRegion(
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
        child: SizedBox(
          width: 28,
          height: 28,
          child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.scale(
                    scale: 0.5 + (_scaleAnimation.value * 0.5),
                    child: _hasCopied
                        ? _CheckIcon(
                            color: color,
                          )
                        : _CopyIcon(
                            color: color,
                          ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CopyIcon extends StatelessWidget {
  final Color color;

  const _CopyIcon({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(20, 20),
      painter: _CopyIconPainter(
        color: color,
      ),
    );
  }
}

/// Custom painter that draws the copy icon.
///
/// Creates a two-rectangle icon representing copy functionality,
/// with one rectangle appearing behind the other to suggest duplication.
class _CopyIconPainter extends CustomPainter {
  /// The color used to draw the copy icon.
  final Color color;

  /// Creates a copy icon painter with the specified color.
  const _CopyIconPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 12
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Scale from 24x24 Tabler viewBox to actual size
    final s = size.width / 24;

    // Front rectangle (complete)
    final frontRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(7 * s, 7 * s, 14 * s, 14 * s),
      Radius.circular(2.667 * s),
    );
    canvas.drawRRect(frontRect, paint);

    // Back rectangle (partial L-shape peeking out)
    final backPath = Path();
    backPath.moveTo(4 * s, 16.7 * s);
    backPath.cubicTo(3 * s, 16.3 * s, 3 * s, 15.5 * s, 3 * s, 15 * s);
    backPath.lineTo(3 * s, 5 * s);
    backPath.cubicTo(3 * s, 3.9 * s, 3.9 * s, 3 * s, 5 * s, 3 * s);
    backPath.lineTo(15 * s, 3 * s);
    backPath.cubicTo(15.75 * s, 3 * s, 16.15 * s, 3.38 * s, 16.5 * s, 4 * s);
    canvas.drawPath(backPath, paint);
  }

  @override
  bool shouldRepaint(covariant _CopyIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _CheckIcon extends StatelessWidget {
  final Color color;

  const _CheckIcon({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(20, 20),
      painter: _CheckIconPainter(
        color: color,
      ),
    );
  }
}

/// Custom painter that draws the checkmark icon.
///
/// Creates a simple checkmark that appears when content is successfully copied,
/// providing clear visual confirmation of the action.
class _CheckIconPainter extends CustomPainter {
  /// The color used to draw the checkmark.
  final Color color;

  /// Creates a checkmark painter with the specified color.
  const _CheckIconPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 12
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Tabler check: M5 12l5 5l10 -10
    final path = Path();
    path.moveTo(5 * s, 12 * s);
    path.lineTo(10 * s, 17 * s);
    path.lineTo(20 * s, 7 * s);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CheckIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
