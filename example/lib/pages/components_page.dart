import 'package:example/pages/alert_popup_page.dart';
import 'package:example/pages/button_page.dart';
import 'package:example/pages/card_box_page.dart';
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
import 'package:flutter/widgets.dart';

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final isDesktop =
        MediaQuery.of(context).size.width >= Style.breakpoints.desktop;

    final sections = [
      _componentSection('CardBox', 'card_box', style, const CardBoxPage()),
      _componentSection('Button', 'button', style, const ButtonPage()),
      _componentSection('Toggle', 'toggle', style, const TogglePage()),
      _componentSection('Tile', 'tile', style, const TilePage()),
      _componentSection('ToggleTile', 'toggle_tile', style, const ToggleTilePage()),
      _componentSection('SearchField', 'search_field', style, const SearchFieldPage()),
      _componentSection('Toast', 'toast', style, const ToastPage()),
      _componentSection('Spinner', 'spinner', style, const SpinnerPage()),
      _componentSection('AlertPopup', 'alert_popup', style, const AlertPopupPage()),
      _componentSection('CopyButton', 'copy_button', style, const CopyButtonPage()),
      _componentSection('ConfirmationPopup', 'confirmation_popup', style, const ConfirmationPopupPage()),
      _componentSection('Popup', 'popup', style, const PopupPage()),
      _componentSection('EmptyState', 'empty_state', style, const EmptyStatePage()),
      _componentSection('NavBar', 'nav_bar', style, const NavBarPage()),
    ];

    if (!isDesktop) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < sections.length; i++) ...[
              sections[i],
              if (i < sections.length - 1) const SizedBox(height: 32),
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
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                for (int i = 0; i < left.length; i++) ...[
                  left[i],
                  if (i < left.length - 1) const SizedBox(height: 32),
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
                  if (i < right.length - 1) const SizedBox(height: 32),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _componentSection(
    String title,
    String cliName,
    StyleData style,
    Widget child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: style.colors.primaryText,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              cliName,
              style: TextStyle(
                fontSize: 14,
                color: style.colors.secondaryText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
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
