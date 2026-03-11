import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'style.dart';

// Variants for the tile appearance
enum TileVariant { simple, bordered, filled }

class Tile extends StatefulWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final TileVariant variant;

  const Tile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.variant = TileVariant.simple,
  });

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  bool _isFocused = false;

  bool get _isDisabled => widget.onTap == null;

  void _handleTap() {
    widget.onTap?.call();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent &&
        (event.logicalKey == LogicalKeyboardKey.space ||
            event.logicalKey == LogicalKeyboardKey.enter)) {
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
      TileVariant.simple => BoxDecoration(
        borderRadius: BorderRadius.zero,
      ),
      TileVariant.bordered => BoxDecoration(
        border: Border.all(color: colors.border, width: 1),
        borderRadius: BorderRadius.circular(Style.radii.medium),
      ),
      TileVariant.filled => BoxDecoration(
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
      button: true,
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
                          style: context.typography.subtitle,
                        ),
                        if (widget.subtitle != null)
                          Text(
                            widget.subtitle!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.typography.body.muted(context),
                          ),
                      ],
                    ),
                  ),
                  if (widget.trailing != null) ...[
                    const SizedBox(width: 16),
                    widget.trailing!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
