import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'styling.dart';

const double _maxWidth = 560;
const Duration _animationDuration = Duration(milliseconds: 200);
const Duration _tapScaleAnimationDuration = Duration(milliseconds: 100);

class Popup extends StatelessWidget {
  final String? title;
  final Widget child;

  const Popup({
    super.key,
    this.title,
    required this.child,
  });

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
        borderRadius: BorderRadius.circular(24),
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

class _CloseIconPainter extends CustomPainter {
  final Color color;

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
