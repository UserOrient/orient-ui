import 'package:example/styling.dart';
import 'package:example/widgets/spinner.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum ButtonVariant { primary, secondary, ghost, destructive, outline, link }

class Button extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;
  final bool loading;
  final ButtonVariant variant;
  final bool _isSmall;

  const Button({
    super.key,
    this.onPressed,
    required this.label,
    this.icon,
    this.loading = false,
    this.variant = ButtonVariant.primary,
  }) : _isSmall = false;

  const Button.small({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.loading = false,
    this.variant = ButtonVariant.primary,
  }) : _isSmall = true;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isFocused = false;

  late final AnimationController _clickAnimationController;
  late final Animation<double> _clickAnimation;

  @override
  void initState() {
    super.initState();

    _clickAnimationController = AnimationController(
      duration: Styling.durations.fast,
      vsync: this,
    );

    _clickAnimation =
        Tween<double>(
          begin: 1.0,
          end: 0.975,
        ).animate(
          CurvedAnimation(
            parent: _clickAnimationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _clickAnimationController.dispose();
    super.dispose();
  }

  // Handle Enter and Space keys to activate button
  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent &&
        (event.logicalKey == LogicalKeyboardKey.enter ||
            event.logicalKey == LogicalKeyboardKey.space)) {
      widget.onPressed?.call();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final styling = Styling.of(context);
    final colors = styling.colors;
    final buttonColors = colors.button;
    final isDisabled = widget.onPressed == null || widget.loading;

    // Select colors based on variant
    final (bg, fg, border) = switch (widget.variant) {
      ButtonVariant.primary => (
        buttonColors.primary,
        buttonColors.primaryForeground,
        colors.border,
      ),
      ButtonVariant.secondary => (
        buttonColors.secondary,
        buttonColors.secondaryForeground,
        colors.border,
      ),
      ButtonVariant.destructive => (
        buttonColors.destructive,
        buttonColors.destructiveForeground,
        colors.border,
      ),
      ButtonVariant.outline => (
        const Color(0x00000000),
        buttonColors.primary,
        colors.border,
      ),
      ButtonVariant.ghost => (
        const Color(0x00000000),
        buttonColors.primary,
        colors.border,
      ),
      ButtonVariant.link => (
        const Color(0x00000000),
        buttonColors.link,
        const Color(0x00000000),
      ),
    };

    final height = widget._isSmall ? 40.0 : 52.0;
    final padding = widget._isSmall
        ? const EdgeInsets.symmetric(horizontal: 12)
        : const EdgeInsets.symmetric(horizontal: 16);
    final fontSize = widget._isSmall ? 14.0 : 16.0;
    final iconSize = widget._isSmall ? 18.0 : 20.0;
    final iconSpacing = widget._isSmall ? 6.0 : 8.0;

    return Semantics(
      button: true,
      enabled: !isDisabled,
      label: widget.label,
      excludeSemantics: true,
      child: Focus(
        onFocusChange: (focused) => setState(() => _isFocused = focused),
        onKeyEvent: isDisabled ? null : _handleKeyEvent,
        child: MouseRegion(
          onEnter: (_) {
            if (!isDisabled) setState(() => _isHovered = true);
          },
          onExit: (_) {
            if (!isDisabled) setState(() => _isHovered = false);
          },
          cursor: isDisabled
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          child: GestureDetector(
            onTap: isDisabled ? null : widget.onPressed,
            onTapDown: isDisabled
                ? null
                : (_) {
                    _clickAnimationController.forward();
                  },
            onTapUp: isDisabled
                ? null
                : (_) {
                    _clickAnimationController.reverse();
                  },
            onTapCancel: isDisabled
                ? null
                : () {
                    _clickAnimationController.reverse();
                  },
            child: AnimatedBuilder(
              animation: _clickAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _clickAnimation.value,
                  child: child,
                );
              },
              child: Opacity(
                opacity: isDisabled ? 0.5 : 1.0,
                child: Container(
                  padding: padding,
                  height: height,
                  width: widget._isSmall ? null : double.maxFinite,
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(bg),
                    border: widget.variant == ButtonVariant.outline
                        ? Border.all(color: border, width: 1)
                        : null,
                    borderRadius: widget.variant == ButtonVariant.link
                        ? null
                        : BorderRadius.circular(Styling.radii.medium),
                    boxShadow: _isFocused && !isDisabled
                        ? [
                            BoxShadow(
                              color: buttonColors.primary.withOpacity(0.4),
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: widget._isSmall
                        ? MainAxisSize.min
                        : MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null || widget.loading) ...[
                        if (widget.loading)
                          SizedBox(
                            height: iconSize,
                            width: iconSize,
                            child: Center(child: Spinner(color: fg)),
                          )
                        else if (widget.icon != null)
                          IconTheme(
                            data: IconThemeData(color: fg, size: iconSize),
                            child: widget.icon!,
                          ),
                        SizedBox(width: iconSpacing),
                      ],
                      Flexible(
                        child: Text(
                          widget.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: fg,
                            fontSize: fontSize,
                            decorationColor: fg,
                            fontWeight: FontWeight.w500,
                            decoration:
                                widget.variant == ButtonVariant.link &&
                                    _isHovered
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
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
    );
  }

  Color _getBackgroundColor(Color base) {
    if (_isHovered) return _getHoverColor(base);
    return base;
  }

  Color _getHoverColor(Color base) {
    final styling = Styling.of(context);
    // Link variant stays transparent on hover
    if (widget.variant == ButtonVariant.link) return const Color(0x00000000);

    // For transparent backgrounds (outline/ghost), use accent color
    if ((base.a * 255.0).round().clamp(0, 255) == 0) {
      return styling.colors.button.accent;
    }

    // For solid backgrounds, reduce opacity (shadcn approach)
    // Secondary uses 80%, others use 90%
    final opacity = widget.variant == ButtonVariant.secondary ? 0.8 : 0.9;
    return base.withValues(alpha: opacity);
  }
}
