import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:example/style.dart';
import 'package:example/widgets/info_banner.dart';
import 'package:example/widgets/toggle.dart';
import 'package:example/widgets/variant_tabs.dart';

class InfoBannerPage extends StatefulWidget {
  const InfoBannerPage({super.key});

  @override
  State<InfoBannerPage> createState() => _InfoBannerPageState();
}

class _InfoBannerPageState extends State<InfoBannerPage> {
  InfoBannerVariant _variant = InfoBannerVariant.info;
  bool _withDescription = false;
  bool _withIcon = true;

  static const _titles = {
    InfoBannerVariant.info:
        'Revise the content before presenting it to the users.',
    InfoBannerVariant.warning: 'Please be careful with this setting.',
    InfoBannerVariant.error: 'This action cannot be undone.',
    InfoBannerVariant.success: 'Your changes have been saved.',
    InfoBannerVariant.neutral: 'This is a neutral message.',
  };

  static const _descriptions = {
    InfoBannerVariant.info:
        'Make sure all content is reviewed and approved before publishing.',
    InfoBannerVariant.warning:
        'Changing this may affect other parts of your application.',
    InfoBannerVariant.error:
        'Deleting your account will remove all data permanently.',
    InfoBannerVariant.success:
        'All modifications have been saved and will take effect immediately.',
    InfoBannerVariant.neutral: 'No action is required at this time.',
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
            _toggle(
              'Icon',
              _withIcon,
              (v) => setState(() => _withIcon = v),
              style,
            ),
            _toggle(
              'Description',
              _withDescription,
              (v) => setState(() => _withDescription = v),
              style,
            ),
          ],
        ),
        const SizedBox(height: 16),
        VariantTabs<InfoBannerVariant>(
          values: InfoBannerVariant.values,
          selected: _variant,
          onChanged: (v) {
            setState(() => _variant = v);
          },
        ),
        const SizedBox(height: 24),
        InfoBanner(
          title: _titles[_variant]!,
          description: _withDescription ? _descriptions[_variant] : null,
          variant: _variant,
          icon: _withIcon ? _buildIcon(style) : null,
        ),
      ],
    );
  }

  static const _variantIcons = {
    InfoBannerVariant.info: TablerIcons.info_circle,
    InfoBannerVariant.warning: TablerIcons.alert_triangle,
    InfoBannerVariant.error: TablerIcons.circle_x,
    InfoBannerVariant.success: TablerIcons.circle_check,
  };

  Widget? _buildIcon(Style style) {
    if (_variant == InfoBannerVariant.neutral) return null;

    final Color color = switch (_variant) {
      InfoBannerVariant.info => style.colors.info,
      InfoBannerVariant.warning => style.colors.warning,
      InfoBannerVariant.error => style.colors.error,
      InfoBannerVariant.success => style.colors.success,
      InfoBannerVariant.neutral => style.colors.mutedForeground,
    };

    return Icon(
      _variantIcons[_variant],
      color: color,
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
