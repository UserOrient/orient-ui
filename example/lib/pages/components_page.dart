import 'package:example/pages/alert_popup_page.dart';
import 'package:example/pages/info_banner_page.dart';
import 'package:example/pages/picker_page.dart';
import 'package:example/pages/button_page.dart';
import 'package:example/pages/card_box_page.dart';
import 'package:example/pages/multi_choice_page.dart';
import 'package:example/pages/multi_choice_tile_page.dart';
import 'package:example/pages/single_choice_page.dart';
import 'package:example/pages/single_choice_tile_page.dart';
import 'package:example/pages/confirmation_popup_page.dart';
import 'package:example/pages/copy_button_page.dart';
import 'package:example/pages/empty_state_page.dart';
import 'package:example/pages/nav_bar_page.dart';
import 'package:example/pages/popup_page.dart';
import 'package:example/pages/search_field_page.dart';
import 'package:example/pages/spinner_page.dart';
import 'package:example/pages/toast_page.dart';
import 'package:example/pages/toggle_page.dart';
import 'package:example/pages/tile_page.dart';
import 'package:example/pages/toggle_tile_page.dart';
import 'package:example/style.dart';
import 'package:example/widgets/copy_button.dart';
import 'package:example/widgets/toast.dart';
import 'package:flutter/widgets.dart';

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final isDesktop =
        MediaQuery.of(context).size.width >= Style.breakpoints.desktop;

    final sections = [
      _componentSection(
        context,
        'InfoBanner',
        'info_banner',
        style,
        const InfoBannerPage(),
      ),
      _componentSection(context, 'Picker', 'picker', style, const PickerPage()),
      _componentSection(
        context,
        'CardBox',
        'card_box',
        style,
        const CardBoxPage(),
      ),
      _componentSection(context, 'Button', 'button', style, const ButtonPage()),
      _componentSection(context, 'Toggle', 'toggle', style, const TogglePage()),
      _componentSection(
        context,
        'SingleChoice',
        'single_choice',
        style,
        const SingleChoicePage(),
      ),
      _componentSection(context, 'Tile', 'tile', style, const TilePage()),
      _componentSection(
        context,
        'ToggleTile',
        'toggle_tile',
        style,
        const ToggleTilePage(),
      ),
      _componentSection(
        context,
        'SingleChoiceTile',
        'single_choice_tile',
        style,
        const SingleChoiceTilePage(),
      ),
      _componentSection(
        context,
        'MultiChoice',
        'multi_choice',
        style,
        const MultiChoicePage(),
      ),
      _componentSection(
        context,
        'MultiChoiceTile',
        'multi_choice_tile',
        style,
        const MultiChoiceTilePage(),
      ),
      _componentSection(
        context,
        'SearchField',
        'search_field',
        style,
        const SearchFieldPage(),
      ),
      _componentSection(context, 'Toast', 'toast', style, const ToastPage()),
      _componentSection(
        context,
        'Spinner',
        'spinner',
        style,
        const SpinnerPage(),
      ),
      _componentSection(
        context,
        'AlertPopup',
        'alert_popup',
        style,
        const AlertPopupPage(),
      ),
      _componentSection(
        context,
        'CopyButton',
        'copy_button',
        style,
        const CopyButtonPage(),
      ),
      _componentSection(
        context,
        'ConfirmationPopup',
        'confirmation_popup',
        style,
        const ConfirmationPopupPage(),
      ),
      _componentSection(context, 'Popup', 'popup', style, const PopupPage()),
      _componentSection(
        context,
        'EmptyState',
        'empty_state',
        style,
        const EmptyStatePage(),
      ),
      _componentSection(
        context,
        'NavBar',
        'nav_bar',
        style,
        const NavBarPage(),
      ),
    ];

    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Components', style: context.typography.display),
        const SizedBox(height: 8),
        Text(
          '${sections.length} ready-to-use widgets. No Material, no Cupertino.',
          style: context.typography.body.muted(context),
        ),
        const SizedBox(height: 48),
      ],
    );

    if (!isDesktop) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header,
            for (int i = 0; i < sections.length; i++) ...[
              sections[i],
              if (i < sections.length - 1) const SizedBox(height: 40),
            ],
          ],
        ),
      );
    }

    final left = <Widget>[];
    final right = <Widget>[];
    for (int i = 0; i < sections.length; i++) {
      (i.isEven ? left : right).add(sections[i]);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    for (int i = 0; i < left.length; i++) ...[
                      left[i],
                      if (i < left.length - 1) const SizedBox(height: 40),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  children: [
                    for (int i = 0; i < right.length; i++) ...[
                      right[i],
                      if (i < right.length - 1) const SizedBox(height: 40),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _componentSection(
    BuildContext context,
    String title,
    String cliName,
    Style style,
    Widget child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: style.colors.foreground,
              ),
            ),
            const SizedBox(width: 4),
            CopyButton(
              value: 'orient_ui add $cliName',
              onCopied: () {
                Toast.show(
                  context: context,
                  message: 'Copied: orient_ui add $cliName',
                  type: ToastType.success,
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            border: Border.all(color: style.colors.border),
            borderRadius: BorderRadius.circular(Style.radii.medium),
          ),
          child: child,
        ),
      ],
    );
  }
}
