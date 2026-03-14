import 'package:example/style.dart';
import 'package:flutter/widgets.dart';

enum SegmentBarLayout { scroll, wrap }

class SegmentBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  final List<SegmentItem> items;
  final SegmentBarLayout layout;

  const SegmentBar({
    super.key,
    required this.index,
    required this.onChanged,
    required this.items,
    this.layout = SegmentBarLayout.scroll,
  });

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);

    final List<Widget> children = <Widget>[
      for (int i = 0; i < items.length; i++)
        _SegmentItemWidget(
          item: items[i],
          selected: i == index,
          onTap: () => onChanged(i),
          style: style,
        ),
    ];

    if (layout == SegmentBarLayout.wrap) {
      return Wrap(
        spacing: 4,
        runSpacing: 4,
        children: children,
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(width: 4),
            children[i],
          ],
        ],
      ),
    );
  }
}

class _SegmentItemWidget extends StatefulWidget {
  final SegmentItem item;
  final bool selected;
  final VoidCallback onTap;
  final Style style;

  const _SegmentItemWidget({
    required this.item,
    required this.selected,
    required this.onTap,
    required this.style,
  });

  @override
  State<_SegmentItemWidget> createState() => _SegmentItemWidgetState();
}

class _SegmentItemWidgetState extends State<_SegmentItemWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.style.colors;
    final typography = widget.style.typography;

    final Color background;
    if (widget.selected) {
      background = colors.surfaceContainer;
    } else if (_hovered) {
      background = colors.surfaceContainer.withValues(alpha: 0.5);
    } else {
      background = const Color(0x00000000);
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _hovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(Style.radii.medium),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.item.icon != null)
                IconTheme(
                  data: IconThemeData(
                    size: 24,
                    color: colors.foreground,
                  ),
                  child: widget.item.icon!,
                ),
              if (widget.item.icon != null && widget.item.label != null)
                const SizedBox(width: 8),
              if (widget.item.label != null)
                Text(
                  widget.item.label!,
                  style: typography.subtitle,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SegmentItem {
  final Widget? icon;
  final String? label;

  const SegmentItem({
    this.icon,
    this.label,
  }) : assert(
         icon != null || label != null,
         'SegmentItem requires at least an icon or a label',
       );
}
