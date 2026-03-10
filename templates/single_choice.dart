import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'style.dart';

// SingleChoice dimensions
const double _kSize = 24;
const double _kCircleSize = 22;
const double _kStrokeWidth = 1.5;

class SingleChoice<T> extends StatefulWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T>? onChanged;

  const SingleChoice({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
  });

  bool get selected => value == groupValue;

  @override
  State<SingleChoice<T>> createState() => _SingleChoiceState<T>();
}

class _SingleChoiceState<T> extends State<SingleChoice<T>> {
  bool _isHovered = false;
  bool _isFocused = false;

  bool get _isDisabled => widget.onChanged == null;

  void _handleTap() {
    if (!widget.selected) {
      widget.onChanged?.call(widget.value);
      _emitHaptic();
    }
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

    final Color borderColor = _isHovered && !widget.selected
        ? Color.lerp(colors.border, colors.foreground, 0.1)!
        : colors.border;

    return Semantics(
      checked: widget.selected,
      enabled: !_isDisabled,
      label: 'SingleChoice',
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
                    width: _kCircleSize,
                    height: _kCircleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.selected ? colors.accent : null,
                      border: widget.selected
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
                    child: widget.selected
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
