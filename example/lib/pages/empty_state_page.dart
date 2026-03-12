import 'package:example/style.dart';
import 'package:example/widgets/button.dart';
import 'package:example/widgets/empty_state.dart';
import 'package:example/widgets/toggle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class EmptyStatePage extends StatefulWidget {
  const EmptyStatePage({super.key});

  @override
  State<EmptyStatePage> createState() => _EmptyStatePageState();
}

class _EmptyStatePageState extends State<EmptyStatePage> {
  bool _withIcon = true;
  bool _withDescription = true;
  bool _withAction = false;

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 24,
          runSpacing: 12,
          children: [
            _toggle('Icon', _withIcon, (v) {
              setState(() => _withIcon = v);
            }, style),
            _toggle('Description', _withDescription, (v) {
              setState(() => _withDescription = v);
            }, style),
            _toggle('Action', _withAction, (v) {
              setState(() => _withAction = v);
            }, style),
          ],
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: EmptyState(
          icon: _withIcon
              ? Icon(
                  TablerIcons.bell_off,
                  size: 48,
                  color: style.colors.mutedForeground,
                )
              : null,
          title: 'No notifications',
          description: _withDescription
              ? 'When we send you notifications, you\'ll be able to see them here.'
              : null,
          action: _withAction
              ? Button.small(
                  onPressed: () {},
                  icon: Icon(TablerIcons.settings),
                  label: 'Open Settings',
                )
              : null,
          ),
        ),
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
