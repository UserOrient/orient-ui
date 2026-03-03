import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'style.dart';
import 'toggle.dart';

// Variants for the toggle tile appearance
enum ToggleTileVariant { simple, bordered, filled }

class ToggleTile extends StatefulWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final ToggleTileVariant variant;

  const ToggleTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    required this.value,
    this.onChanged,
    this.variant = ToggleTileVariant.simple,
  });

  @override
  State<ToggleTile> createState() => _ToggleTileState();
}

class _ToggleTileState extends State<ToggleTile> {
  bool _isFocused = false;

  bool get _isDisabled => widget.onChanged == null;

  void _handleTap() {
    widget.onChanged?.call(!widget.value);
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

    // Decoration based on variant
    BoxDecoration decoration = switch (widget.variant) {
      ToggleTileVariant.simple => BoxDecoration(
        borderRadius: BorderRadius.zero,
      ),
      ToggleTileVariant.bordered => BoxDecoration(
        border: Border.all(color: colors.border, width: 1),
        borderRadius: BorderRadius.circular(Style.radii.medium),
      ),
      ToggleTileVariant.filled => BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(Style.radii.medium),
      ),
    };

    // Focus ring
    if (_isFocused && !_isDisabled) {
      decoration = decoration.copyWith(
        boxShadow: [
          BoxShadow(
            color: colors.accent.withValues(alpha: 0.4),
            spreadRadius: 2,
          ),
        ],
      );
    }

    return Semantics(
      toggled: widget.value,
      excludeSemantics: true,
      child: Focus(
        onFocusChange: (focused) {
          setState(() {
            _isFocused = focused;
          });
        },
        onKeyEvent: _isDisabled ? null : _handleKeyEvent,
        child: MouseRegion(
          cursor: _isDisabled
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _isDisabled ? null : _handleTap,
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: decoration,
              child: Row(
                children: [
                  if (widget.leading != null) ...[
                    widget.leading!,
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: colors.foreground,
                          ),
                        ),
                        if (widget.subtitle != null)
                          Text(
                            widget.subtitle!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              height: 20 / 14,
                              color: colors.mutedForeground,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Toggle(
                    value: widget.value,
                    onChanged: widget.onChanged,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
