import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'style.dart';

// MultiChoice dimensions
const double _kSize = 24;
const double _kBoxSize = 22;
const double _kStrokeWidth = 1.5;

class MultiChoice extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const MultiChoice({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  State<MultiChoice> createState() => _MultiChoiceState();
}

class _MultiChoiceState extends State<MultiChoice> {
  bool _isHovered = false;
  bool _isFocused = false;

  bool get _isDisabled => widget.onChanged == null;

  void _handleTap() {
    widget.onChanged?.call(!widget.value);
    _emitHaptic();
  }

  void _emitHaptic() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      HapticFeedback.lightImpact();
    }
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {
      _handleTap();

      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final ColorTokens colors = Style.of(context).colors;

    final Color borderColor = _isHovered && !widget.value
        ? Color.lerp(colors.border, colors.foreground, 0.1)!
        : colors.border;

    return Semantics(
      checked: widget.value,
      enabled: !_isDisabled,
      label: 'MultiChoice',
      child: Focus(
        onFocusChange: (focused) {
          setState(() {
            _isFocused = focused;
          });
        },
        onKeyEvent: _isDisabled ? null : _handleKeyEvent,
        child: MouseRegion(
          onEnter: (_) {
            if (!_isDisabled) {
              setState(() {
                _isHovered = true;
              });
            }
          },
          onExit: (_) {
            if (!_isDisabled) {
              setState(() {
                _isHovered = false;
              });
            }
          },
          cursor:
              _isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _isDisabled ? null : _handleTap,
            child: Opacity(
              opacity: _isDisabled ? 0.5 : 1.0,
              child: SizedBox(
                width: _kSize,
                height: _kSize,
                child: Center(
                  child: Container(
                    width: _kBoxSize,
                    height: _kBoxSize,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Style.radii.small),
                      color: widget.value ? colors.accent : null,
                      border: widget.value
                          ? null
                          : Border.all(
                              color: borderColor,
                              width: _kStrokeWidth,
                            ),
                      boxShadow: _isFocused && !_isDisabled
                          ? [
                              BoxShadow(
                                color: colors.accent.withValues(alpha: 0.4),
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: widget.value
                        ? CustomPaint(
                            painter: _CheckmarkPainter(
                              color: colors.accentForeground,
                            ),
                          )
                        : null,
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

class _CheckmarkPainter extends CustomPainter {
  final Color color;

  _CheckmarkPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    final path = Path()
      ..moveTo(cx - 3, cy)
      ..lineTo(cx - 1, cy + 1.65)
      ..lineTo(cx + 3, cy - 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CheckmarkPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
