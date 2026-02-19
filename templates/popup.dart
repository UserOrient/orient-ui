import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'styling.dart';

const double _maxWidth = 560;
final Duration _animationDuration = Styling.durations.normal;
final Duration _tapScaleAnimationDuration = Styling.durations.fast;

/// A modal popup component with responsive design and smooth animations.
///
/// Popup provides a flexible modal dialog that adapts to different screen sizes
/// and includes a backdrop, close functionality, and smooth transitions. It's
/// designed as a base component for more specific popup types like alerts
/// and confirmation dialogs.
///
/// ## Example
///
/// ```dart
/// // Basic popup
/// Popup.show(
///   context: context,
///   title: 'Settings',
///   child: Column(
///     mainAxisSize: MainAxisSize.min,
///     children: [
///       Text('Configure your preferences'),
///       SizedBox(height: 16),
///       Button(
///         label: 'Save',
///         onPressed: () => Navigator.pop(context),
///       ),
///     ],
///   ),
/// )
///
/// // Custom content popup
/// Popup.show(
///   context: context,
///   child: UserProfileForm(),
/// )
/// ```
///
/// ## Behavior
///
/// - Displays as a modal overlay with backdrop blur
/// - Responsive padding (48px desktop, 24px mobile)
/// - Can be dismissed by tapping outside, pressing Escape, or close button
/// - Respects system reduced motion preferences
/// - Includes smooth scale and fade animations
/// - Maximum width of 560px for readability
///
/// ## Accessibility
///
/// - Properly labeled for screen readers
/// - Supports keyboard navigation and dismissal
/// - Includes semantic route information
/// - Maintains focus management
class Popup extends StatelessWidget {
  /// Optional title displayed in the popup header.
  ///
  /// When provided, appears prominently at the top of the popup
  /// with large, bold typography. Also used for accessibility labeling.
  final String? title;

  /// The main content widget displayed in the popup.
  ///
  /// This can be any widget but is typically a Column, Form,
  /// or other container with the popup's main content.
  final Widget child;

  /// Creates a popup widget with the specified properties.
  ///
  /// The [child] parameter is required. The [title] parameter is optional.
  /// This constructor is typically used when creating custom popup types
  /// or when embedding popup content in other components.
  const Popup({
    super.key,
    this.title,
    required this.child,
  });

  /// Displays a modal popup with the specified content.
  ///
  /// This is the preferred way to show popups. It handles the
  /// navigation, animation, and overlay management automatically.
  ///
  /// [context] is required and must have a valid Navigator.
  /// [title] is optional and appears in the popup header.
  /// [child] is required and contains the popup's main content.
  ///
  /// Returns a Future that completes when the popup is dismissed.
  static Future<void> show({
    required BuildContext context,
    String? title,
    required Widget child,
  }) {
    return Navigator.of(context).push(
      _PopupRoute(
        title: title,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final StylingData styling = Styling.of(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= styling.breakpoints.desktop;

    final EdgeInsets padding = isDesktop
        ? const EdgeInsets.all(48)
        : const EdgeInsets.all(24);

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: styling.colors.background,
        borderRadius: BorderRadius.circular(Styling.radii.large),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            spreadRadius: 0,
            offset: const Offset(0, 8),
            color: const Color(0xFF000000).withAlpha(12),
          ),
          BoxShadow(
            blurRadius: 64,
            spreadRadius: 0,
            offset: const Offset(0, 24),
            color: const Color(0xFF000000).withAlpha(8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Expanded(
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontSize: 28,
                      height: 36 / 28,
                      fontWeight: FontWeight.bold,
                      color: styling.colors.primaryText,
                      decoration: TextDecoration.none,
                    ),
                  ),
                )
              else
                const Spacer(),
              _CloseButton(
                color: styling.colors.secondaryText,
              ),
            ],
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}

// Wraps a child with a subtle scale-down effect on press.
class _TapScale extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;

  const _TapScale({
    required this.onTap,
    required this.child,
  });

  @override
  State<_TapScale> createState() => _TapScaleState();
}

class _TapScaleState extends State<_TapScale>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: _tapScaleAnimationDuration,
      vsync: this,
    );

    _animation =
        Tween<double>(
          begin: 1.0,
          end: 0.975,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) {
        _controller.forward();
      },
      onTapUp: (_) {
        _controller.reverse();
      },
      onTapCancel: () {
        _controller.reverse();
      },
      behavior: HitTestBehavior.translucent,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}

class _CloseButton extends StatefulWidget {
  final Color color;

  const _CloseButton({
    required this.color,
  });

  @override
  State<_CloseButton> createState() => _CloseButtonState();
}

class _CloseButtonState extends State<_CloseButton> {
  bool _isHovered = false;

  Color _getButtonColor(Color base) {
    if (_isHovered) {
      return base.withValues(alpha: 0.8);
    }

    return base;
  }

  @override
  Widget build(BuildContext context) {
    final StylingData styling = Styling.of(context);
    final Color buttonColor = _getButtonColor(
      styling.colors.button.secondary,
    );

    return _TapScale(
      onTap: () {
        Navigator.of(context).pop();
      },
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
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: buttonColor,
          ),
          child: CustomPaint(
            size: const Size(20, 20),
            painter: _CloseIconPainter(
              color: styling.colors.primaryText,
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom painter that draws the close icon.
///
/// Creates a simple X icon for closing popups and dialogs,
/// with rounded line caps for a modern appearance.
class _CloseIconPainter extends CustomPainter {
  /// The color used to draw the close icon.
  final Color color;

  /// Creates a close icon painter with the specified color.
  const _CloseIconPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double s = size.width / 24;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 12
      ..strokeCap = StrokeCap.round;

    // Two diagonal lines forming an X
    canvas.drawLine(Offset(6 * s, 6 * s), Offset(18 * s, 18 * s), paint);
    canvas.drawLine(Offset(18 * s, 6 * s), Offset(6 * s, 18 * s), paint);
  }

  @override
  bool shouldRepaint(covariant _CloseIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _PopupRoute extends PageRouteBuilder {
  final String? title;
  final Widget child;

  _PopupRoute({
    this.title,
    required this.child,
  }) : super(
         opaque: false,
         barrierDismissible: true,
         barrierColor: const Color(0x00000000),
         transitionDuration: _animationDuration,
         reverseTransitionDuration: _animationDuration,
         pageBuilder: (_, _, _) {
           return const SizedBox.shrink();
         },
       );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final bool reduceMotion = MediaQuery.of(context).disableAnimations;

    // Animate opacity, scale, and backdrop blur together
    final double fade = reduceMotion
        ? 1.0
        : CurvedAnimation(parent: animation, curve: Curves.easeOut).value;
    final double scale = reduceMotion
        ? 1.0
        : Tween<double>(begin: 0.95, end: 1.0)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              )
              .value;
    final double blur = reduceMotion
        ? 8.0
        : Tween<double>(begin: 0, end: 8.0)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              )
              .value;

    // Close on Escape key
    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.escape) {
          Navigator.of(context).pop();
        }
      },
      child: Stack(
        children: [
          // Tap outside to dismiss
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: ColoredBox(
                  color: Color.fromRGBO(0, 0, 0, 0.5 * fade),
                ),
              ),
            ),
          ),
          // Dialog
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Opacity(
                  opacity: fade,
                  child: Transform.scale(
                    scale: scale,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: _maxWidth,
                      ),
                      child: Semantics(
                        scopesRoute: true,
                        explicitChildNodes: true,
                        label: title != null ? 'Popup: $title' : 'Popup',
                        child: Popup(
                          title: title,
                          child: this.child,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
