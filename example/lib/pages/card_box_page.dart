import 'package:example/style.dart';
import 'package:example/widgets/card_box.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:example/widgets/toggle.dart';
import 'package:flutter/widgets.dart';

class CardBoxPage extends StatefulWidget {
  const CardBoxPage({super.key});

  @override
  State<CardBoxPage> createState() => _CardBoxPageState();
}

class _CardBoxPageState extends State<CardBoxPage> {
  bool _clickable = false;

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);
    final ColorTokens colors = style.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _toggle('Clickable', _clickable, (v) {
          setState(() => _clickable = v);
        }, style),
        const SizedBox(height: 24),
        for (final variant in CardBoxVariant.values) ...[
          DemoSection(
            title: variant.name,
            child: CardBox(
              variant: variant,
              onTap: _clickable ? () {} : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Monthly Revenue',
                    style: context.typography.bodySmall.muted(context),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$12,840',
                    style: context.typography.heading.copyWith(
                      color: colors.foreground,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ],
    );
  }

  Widget _toggle(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
    Style style,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Toggle.small(value: value, onChanged: onChanged),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: style.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}
