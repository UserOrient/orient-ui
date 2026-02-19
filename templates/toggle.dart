import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'styling.dart';

// Toggle dimensions
const double _kTrackWidth = 48;
const double _kTrackHeight = 26;
const double _kThumbSize = 20;
const double _kThumbPadding = 3;

// Small toggle dimensions
const double _kSmallTrackWidth = 40;
const double _kSmallTrackHeight = 22;
const double _kSmallThumbSize = 16;
const double _kSmallThumbPadding = 3;

// Thumb stretches horizontally by this many pixels when pressed
const double _kThumbExtension = 5;
const double _kSmallThumbExtension = 3;

/// A toggle switch component with smooth animations and haptic feedback.
///
/// Toggle provides a familiar on/off switch interface with drag-to-toggle
/// functionality, smooth animations, and accessibility features. It supports
/// both standard and small sizes for different use cases.
///
/// ## Example
///
/// ```dart
/// // Basic toggle
/// bool _isEnabled = false;
/// Toggle(
///   value: _isEnabled,
///   onChanged: (value) => setState(() => _isEnabled = value),
/// )
///
/// // Small toggle for compact layouts
/// bool _notifications = true;
/// Toggle.small(
///   value: _notifications,
///   onChanged: (value) => setState(() => _notifications = value),
/// )
///
/// // Disabled toggle
/// Toggle(
///   value: true,
///   onChanged: null, // Disabled
/// )
/// ```
///
/// ## Behavior
///
/// - Supports both tap and drag interactions
/// - Provides haptic feedback on iOS devices
/// - Smooth thumb animation with spring physics
/// - Visual feedback on hover and focus
/// - Maintains state when value changes programmatically
///
/// ## Accessibility
///
/// - Automatically labeled as a toggle for screen readers
/// - Supports keyboard navigation (Space key)
/// - Provides semantic state information
/// - Includes focus management and visual indicators
class Toggle extends StatefulWidget {
  /// Whether the toggle is in the 'on' position.
  ///
  /// When true, the thumb is positioned at the right end of the track.
  /// When false, the thumb is positioned at the left end.
  final bool value;

  /// Callback function called when the toggle state changes.
  ///
  /// Called with the new boolean value when the user interacts with
  /// the toggle. If null, the toggle is disabled and not interactive.
  final ValueChanged<bool>? onChanged;

  /// Internal flag indicating if this is a small toggle.
  ///
  /// Set automatically based on which constructor is used.
  /// Use the [Toggle.small] constructor for compact toggles.
  final bool _isSmall;

  /// Creates a standard-sized toggle switch.
  ///
  /// The toggle will have dimensions of 48x26 pixels with a 20px thumb.
  /// Use this constructor for most toggle needs.
  ///
  /// The [value] parameter is required. [onChanged] is optional.
  const Toggle({
    super.key,
    required this.value,
    this.onChanged,
  }) : _isSmall = false;

  /// Creates a compact toggle switch.
  ///
  /// The toggle will have dimensions of 40x22 pixels with a 16px thumb.
  /// Use this constructor for tight spaces or secondary toggles.
  ///
  /// The [value] parameter is required. [onChanged] is optional.
  const Toggle.small({
    super.key,
    required this.value,
    this.onChanged,
  }) : _isSmall = true;

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> with TickerProviderStateMixin {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _needsPositionAnimation = false;

  late final AnimationController _positionController;
  late final CurvedAnimation _positionAnimation;
  late final AnimationController _reactionController;

  @override
  void initState() {
    super.initState();

    _positionController = AnimationController(
      duration: Styling.durations.normal,
      vsync: this,
      value: widget.value ? 1.0 : 0.0,
    );

    _positionAnimation = CurvedAnimation(
      parent: _positionController,
      curve: Curves.ease,
      reverseCurve: Curves.ease.flipped,
    );

    _reactionController = AnimationController(
      duration: Styling.durations.normal,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(Toggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (_positionController.value == 0.0 ||
          _positionController.value == 1.0) {
        _positionAnimation
          ..curve = Curves.ease
          ..reverseCurve = Curves.ease.flipped;
      }
      widget.value
          ? _positionController.forward()
          : _positionController.reverse();
    }
  }

  @override
  void dispose() {
    _positionAnimation.dispose();
    _positionController.dispose();
    _reactionController.dispose();
    super.dispose();
  }

  bool get _isDisabled => widget.onChanged == null;

  double get _thumbExtension =>
      widget._isSmall ? _kSmallThumbExtension : _kThumbExtension;

  double get _trackInnerLength {
    final double trackW = widget._isSmall ? _kSmallTrackWidth : _kTrackWidth;
    final double thumb = widget._isSmall ? _kSmallThumbSize : _kThumbSize;
    final double pad = widget._isSmall ? _kSmallThumbPadding : _kThumbPadding;

    return trackW - thumb - pad * 2;
  }

  void _handleTap() {
    widget.onChanged?.call(!widget.value);
    _emitHaptic();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!_isDisabled) _reactionController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _reactionController.reverse();
  }

  void _handleTapCancel() {
    _reactionController.reverse();
  }

  void _handleDragStart(DragStartDetails details) {
    if (!_isDisabled) {
      _reactionController.forward();
      _emitHaptic();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_isDisabled) {
      _positionAnimation
        ..curve = Curves.linear
        ..reverseCurve = Curves.linear;

      final double delta = details.primaryDelta! / _trackInnerLength;

      _positionController.value += delta;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    _reactionController.reverse();

    if (_positionController.value >= 0.5 != widget.value) {
      widget.onChanged?.call(!widget.value);

      setState(() {
        _needsPositionAnimation = true;
      });
    } else {
      _positionAnimation
        ..curve = Curves.easeOutBack
        ..reverseCurve = Curves.easeOutBack.flipped;

      widget.value
          ? _positionController.forward()
          : _positionController.reverse();
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
    if (_needsPositionAnimation) {
      _needsPositionAnimation = false;
      _positionAnimation
        ..curve = Curves.easeOutBack
        ..reverseCurve = Curves.easeOutBack.flipped;
      widget.value
          ? _positionController.forward()
          : _positionController.reverse();
    }

    final ColorTokens colors = Styling.of(context).colors;

    final double trackW = widget._isSmall ? _kSmallTrackWidth : _kTrackWidth;
    final double trackH = widget._isSmall ? _kSmallTrackHeight : _kTrackHeight;
    final double thumbH = widget._isSmall ? _kSmallThumbSize : _kThumbSize;
    final double pad = widget._isSmall ? _kSmallThumbPadding : _kThumbPadding;

    return Semantics(
      toggled: widget.value,
      enabled: !_isDisabled,
      label: 'Toggle',
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
          cursor: _isDisabled
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _isDisabled ? null : _handleTap,
            onTapDown: _isDisabled ? null : _handleTapDown,
            onTapUp: _isDisabled ? null : _handleTapUp,
            onTapCancel: _isDisabled ? null : _handleTapCancel,
            onHorizontalDragStart: _isDisabled ? null : _handleDragStart,
            onHorizontalDragUpdate: _isDisabled ? null : _handleDragUpdate,
            onHorizontalDragEnd: _isDisabled ? null : _handleDragEnd,
            dragStartBehavior: DragStartBehavior.start,
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _positionAnimation,
                _reactionController,
              ]),
              builder: (context, _) {
                final double t = _positionAnimation.value;
                final double ext = _reactionController.value * _thumbExtension;

                final double thumbW = thumbH + ext;
                final double travel = trackW - thumbH - pad * 2 - ext;

                final Color inactiveTrack = _isHovered && !widget.value
                    ? Color.lerp(colors.border, colors.primaryText, 0.1)!
                    : colors.border;

                final Color trackColor = Color.lerp(
                  inactiveTrack,
                  colors.accent,
                  t,
                )!;
                final Color thumbColor = Color.lerp(
                  const Color(0xFFFFFFFF),
                  colors.accentForeground,
                  t,
                )!;

                return Opacity(
                  opacity: _isDisabled ? 0.5 : 1.0,
                  child: Container(
                    width: trackW,
                    height: trackH,
                    decoration: BoxDecoration(
                      color: trackColor,
                      borderRadius: BorderRadius.circular(trackH / 2),
                      boxShadow: _isFocused && !_isDisabled
                          ? [
                              BoxShadow(
                                color: colors.accent.withValues(alpha: 0.4),
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: pad + t * travel,
                          top: pad,
                          child: Container(
                            width: thumbW,
                            height: thumbH,
                            decoration: BoxDecoration(
                              color: thumbColor,
                              borderRadius: BorderRadius.circular(thumbH / 2),
                            ),
                          ),
                        ),
                      ],
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
