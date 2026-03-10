import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:example/style.dart';
import 'package:example/widgets/button.dart';
import 'package:example/widgets/toggle.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool _disabled = false;
  bool _loading = false;
  bool _withIcon = false;
  bool _small = false;

  static const _variantIcons = {
    ButtonVariant.primary: TablerIcons.send,
    ButtonVariant.secondary: TablerIcons.settings,
    ButtonVariant.destructive: TablerIcons.trash,
    ButtonVariant.outline: TablerIcons.download,
    ButtonVariant.ghost: TablerIcons.dots,
    ButtonVariant.link: TablerIcons.external_link,
  };

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 24,
          runSpacing: 12,
          children: [
            _toggle('Small', _small, (v) => setState(() => _small = v), style),
            _toggle('Icon', _withIcon, (v) => setState(() => _withIcon = v), style),
            _toggle('Loading', _loading, (v) => setState(() => _loading = v), style),
            _toggle('Disabled', _disabled, (v) => setState(() => _disabled = v), style),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final variant in ButtonVariant.values)
              _small
                  ? Button.small(
                      onPressed: _disabled ? null : () {},
                      label: variant.name[0].toUpperCase() +
                          variant.name.substring(1),
                      variant: variant,
                      loading: _loading,
                      icon: _withIcon ? Icon(_variantIcons[variant]) : null,
                    )
                  : Button(
                      onPressed: _disabled ? null : () {},
                      label: variant.name[0].toUpperCase() +
                          variant.name.substring(1),
                      variant: variant,
                      loading: _loading,
                      icon: _withIcon ? Icon(_variantIcons[variant]) : null,
                    ),
          ],
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
