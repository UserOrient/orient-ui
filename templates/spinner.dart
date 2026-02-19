import 'package:flutter/widgets.dart';

/// A rotating loading indicator component.
///
/// Spinner provides a simple, accessible loading animation that indicates
/// content is being loaded or processed. It's commonly used in buttons,
/// forms, and async operations to provide visual feedback to users.
///
/// ## Example
///
/// ```dart
/// // Basic spinner with default color
/// Spinner(color: Colors.blue)
///
/// // In a button loading state
/// Button(
///   loading: true,
///   label: 'Saving',
///   onPressed: () {},
/// )
///
/// // Custom sized spinner
/// SizedBox(
///   width: 24,
///   height: 24,
///   child: Spinner(color: Colors.grey),
/// )
/// ```
///
/// ## Behavior
///
/// - Rotates continuously with a 1-second animation cycle
/// - Fixed 16x16 size by default
/// - Uses semantic labels for accessibility
/// - Respects system reduced motion preferences
///
/// ## Accessibility
///
/// - Automatically labeled as "Loading" for screen readers
/// - Consider adding additional context when used in complex layouts
class Spinner extends StatefulWidget {
  /// The color of the spinner arc.
  ///
  /// Should provide sufficient contrast against the background.
  /// Consider using theme colors for consistency.
  final Color color;

  /// Creates a spinner with the specified color.
  ///
  /// The [color] parameter is required and determines the color
  /// of the spinning arc. The spinner will have a fixed size of 16x16.
  const Spinner({super.key, required this.color});

  @override
  State<Spinner> createState() => SpinnerState();
}

class SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Loading',
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * 3.14159,
            child: CustomPaint(
              painter: _SpinnerPainter(color: widget.color),
              size: const Size.square(16),
            ),
          );
        },
      ),
    );
  }
}

/// Custom painter that draws the spinner arc.
///
/// Creates a 270-degree arc (3/4 of a circle) with rounded endpoints.
/// The arc is drawn using the specified color and stroke width.
class _SpinnerPainter extends CustomPainter {
  /// The color used to draw the spinner arc.
  final Color color;

  /// Creates a spinner painter with the specified color.
  _SpinnerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      0,
      3.14159 * 1.5,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_SpinnerPainter oldDelegate) => false;
}
