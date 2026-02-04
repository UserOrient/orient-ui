import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:example/styling.dart';

// Customizable constants
//
// Default: Universal pill style (works on all platforms)
const double _kHeight = 44;
const double _kHorizontalPadding = 14;
const double _kBorderRadius = 22;
//
// Alternative: Compact Cupertino-like style (iOS only, not recommended for Android)
// const double _kHeight = 36;
// const double _kHorizontalPadding = 8;
// const double _kBorderRadius = 10;

class SearchField extends StatefulWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;

  const SearchField({
    super.key,
    this.controller,
    this.placeholder,
    this.onChanged,
    this.onSubmitted,
    this.autofocus = false,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_onTextChange);

    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _controller.removeListener(_onTextChange);
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onTextChange() {
    setState(() {});
    widget.onChanged?.call(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final StylingData styling = Styling.of(context);
    final bool showPlaceholder =
        _controller.text.isEmpty && widget.placeholder != null;

    return Semantics(
      textField: true,
      focused: _isFocused,
      hint: widget.placeholder,
      child: GestureDetector(
        onTap: () {
          _focusNode.requestFocus();
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          height: _kHeight,
          padding: const EdgeInsets.symmetric(horizontal: _kHorizontalPadding),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: styling.colors.button.secondary,
            borderRadius: BorderRadius.circular(_kBorderRadius),
          ),
          child: Row(
            children: [
              CustomPaint(
                size: const Size(20, 20),
                painter: _SearchIconPainter(
                  color: styling.colors.secondaryText,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    if (showPlaceholder)
                      Text(
                        widget.placeholder!,
                        style: TextStyle(
                          fontSize: 16,
                          height: 16 / 16,
                          color: styling.colors.secondaryText,
                        ),
                      ),
                    EditableText(
                      controller: _controller,
                      focusNode: _focusNode,
                      scrollPadding: EdgeInsets.zero,
                      style: TextStyle(
                        fontSize: 16,
                        height: 16 / 16,
                        color: styling.colors.primaryText,
                      ),
                      cursorColor: styling.colors.primaryText,
                      cursorHeight: 18,
                      backgroundCursorColor: const Color(0x00000000),
                      textInputAction: TextInputAction.search,
                      onChanged: widget.onChanged,
                      onSubmitted: widget.onSubmitted,
                    ),
                  ],
                ),
              ),
              if (_controller.text.isNotEmpty) ...[
                const SizedBox(width: 6),
                Semantics(
                  button: true,
                  label: 'Clear search',
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        _controller.clear();
                        widget.onChanged?.call('');
                      },
                      child: CustomPaint(
                        size: const Size(20, 20),
                        painter: _ClearIconPainter(
                          backgroundColor: styling.colors.button.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Tabler search icon
class _SearchIconPainter extends CustomPainter {
  final Color color;

  const _SearchIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final double s = size.width / 24;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 * s
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Circle: center (10, 10), radius 7
    canvas.drawCircle(
      Offset(10 * s, 10 * s),
      7 * s,
      paint,
    );

    // Handle: from edge of circle to (21, 21)
    canvas.drawLine(
      Offset(15 * s, 15 * s),
      Offset(21 * s, 21 * s),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _SearchIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

// Clear (X) icon with filled square background
class _ClearIconPainter extends CustomPainter {
  final Color backgroundColor;

  const _ClearIconPainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final double s = size.width / 24;

    // Filled rounded square background
    final bgPaint = Paint()
      ..color = const Color(0xFFACAEAF)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(2 * s, 2 * s, 20 * s, 20 * s),
        Radius.circular(10 * s),
      ),
      bgPaint,
    );

    // X icon - same color as container background for "cut out" effect
    final xPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 * s
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(8 * s, 8 * s), Offset(16 * s, 16 * s), xPaint);
    canvas.drawLine(Offset(16 * s, 8 * s), Offset(8 * s, 16 * s), xPaint);
  }

  @override
  bool shouldRepaint(covariant _ClearIconPainter oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor;
  }
}
