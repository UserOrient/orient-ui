import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'style.dart';

class Tabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  final List<String> items;

  const Tabs({
    super.key,
    required this.index,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: style.colors.border,
            width: 1,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < items.length; i++) ...[
              if (i > 0) const SizedBox(width: 8),
              _TabItem(
                label: items[i],
                selected: i == index,
                onTap: () {
                  onChanged(i);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);
    final ColorTokens colors = style.colors;

    return MouseRegion(
      cursor: SystemMouseCursors.click,

      child: GestureDetector(
        onTap: () {
          onTap();

          HapticFeedback.selectionClick();
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? colors.accent : const Color(0x00000000),
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            style: context.typography.body,
          ),
        ),
      ),
    );
  }
}
