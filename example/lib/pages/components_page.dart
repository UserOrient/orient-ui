import 'package:example/pages/alert_popup_page.dart';
import 'package:example/pages/button_page.dart';
import 'package:example/pages/confirmation_popup_page.dart';
import 'package:example/pages/copy_button_page.dart';
import 'package:example/pages/empty_state_page.dart';
import 'package:example/pages/nav_bar_page.dart';
import 'package:example/pages/popup_page.dart';
import 'package:example/pages/search_field_page.dart';
import 'package:example/pages/spinner_page.dart';
import 'package:example/pages/toast_page.dart';
import 'package:example/pages/toggle_page.dart';
import 'package:example/styling.dart';
import 'package:flutter/widgets.dart';

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final styling = Styling.of(context);
    final isDesktop =
        MediaQuery.of(context).size.width >= Styling.breakpoints.desktop;

    final sections = [
      _componentSection('Button', styling, const ButtonPage()),
      _componentSection('Toggle', styling, const TogglePage()),
      _componentSection('Copy Button', styling, const CopyButtonPage()),
      _componentSection('Search Field', styling, const SearchFieldPage()),
      _componentSection('Spinner', styling, const SpinnerPage()),
      _componentSection('Toast', styling, const ToastPage()),
      _componentSection('Alert Popup', styling, const AlertPopupPage()),
      _componentSection(
        'Confirmation Popup',
        styling,
        const ConfirmationPopupPage(),
      ),
      _componentSection('Popup', styling, const PopupPage()),
      _componentSection('Empty State', styling, const EmptyStatePage()),
      _componentSection('NavBar', styling, const NavBarPage()),
    ];

    if (!isDesktop) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < sections.length; i++) ...[
              sections[i],
              if (i < sections.length - 1) const SizedBox(height: 24),
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
                  if (i < left.length - 1) const SizedBox(height: 24),
                ],
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              children: [
                for (int i = 0; i < right.length; i++) ...[
                  right[i],
                  if (i < right.length - 1) const SizedBox(height: 24),
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
    StylingData styling,
    Widget child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: styling.colors.secondaryText,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: styling.colors.border),
            borderRadius: BorderRadius.circular(Styling.radii.medium),
          ),
          child: child,
        ),
      ],
    );
  }
}
