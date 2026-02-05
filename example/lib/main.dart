import 'package:example/pages/alert_popup_page.dart';
import 'package:example/pages/search_field_page.dart';
import 'package:example/pages/toggle_page.dart';
import 'package:example/pages/popup_page.dart';
import 'package:example/pages/confirmation_popup_page.dart';
import 'package:example/pages/copy_button_page.dart';
import 'package:example/pages/empty_state_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:example/styling.dart';
import 'package:example/widgets/button.dart';
import 'package:example/widgets/nav_bar.dart';
import 'package:example/pages/button_page.dart';
import 'package:example/pages/spinner_page.dart';
import 'package:example/pages/nav_bar_page.dart';
import 'package:example/pages/toast_page.dart';

final _brightnessNotifier = ValueNotifier(Brightness.light);

void main() {
  runApp(const OrientUIPlayground());
}

class OrientUIPlayground extends StatelessWidget {
  const OrientUIPlayground({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Brightness>(
      valueListenable: _brightnessNotifier,
      builder: (context, brightness, _) {
        final isDark = brightness == Brightness.dark;

        return Styling(
          brightness: brightness,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Orient UI',
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF09090B),
            ),
            home: const PlaygroundShell(),
          ),
        );
      },
    );
  }
}

class PlaygroundShell extends StatefulWidget {
  const PlaygroundShell({super.key});

  @override
  State<PlaygroundShell> createState() => _PlaygroundShellState();
}

class _PlaygroundShellState extends State<PlaygroundShell> {
  int _currentIndex = 0;

  static const _pages = [
    _PageInfo(
      title: 'Button',
      icon: Icons.smart_button_outlined,
      page: ButtonPage(),
    ),
    _PageInfo(
      title: 'Spinner',
      icon: Icons.refresh,
      page: SpinnerPage(),
    ),
    _PageInfo(
      title: 'NavBar',
      icon: Icons.menu,
      page: NavBarPage(),
    ),
    _PageInfo(
      title: 'Toast',
      icon: Icons.notifications_outlined,
      page: ToastPage(),
    ),
    _PageInfo(
      title: 'Empty State',
      icon: Icons.inbox_outlined,
      page: EmptyStatePage(),
    ),
    _PageInfo(
      title: 'Confirmation',
      icon: Icons.help_outline,
      page: ConfirmationPopupPage(),
    ),
    _PageInfo(
      title: 'Copy Button',
      icon: Icons.copy,
      page: CopyButtonPage(),
    ),
    _PageInfo(
      title: 'Alert Popup',
      icon: Icons.campaign_outlined,
      page: AlertPopupPage(),
    ),
    _PageInfo(
      title: 'Popup',
      icon: Icons.web_asset_outlined,
      page: PopupPage(),
    ),
    _PageInfo(
      title: 'Search Field',
      icon: Icons.search,
      page: SearchFieldPage(),
    ),
    _PageInfo(
      title: 'Toggle',
      icon: Icons.toggle_on_outlined,
      page: TogglePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _pages.map((p) {
          return NavBarItem(
            icon: Icon(p.icon),
            label: p.title,
          );
        }).toList(),
        railHeader: _buildHeader(),
        body: SafeArea(
          child: _pages[_currentIndex].page,
        ),
        railFooter: _buildFooter(),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: [
        Text(
          'Orient UI',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 4),
        Text(
          'Widget Playground',
          style: TextStyle(fontSize: 14, color: Color(0xFF71717A)),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLinkButton(
              icon: TablerIcons.world,
              url: 'https://ui.userorient.com',
            ),
            const SizedBox(width: 8),
            _buildLinkButton(
              icon: TablerIcons.brand_github,
              url: 'https://github.com/userorient/orient-ui',
            ),
            const SizedBox(width: 8),
            _buildLinkButton(
              icon: TablerIcons.package,
              url: 'https://pub.dev/packages/orient_ui',
            ),
          ],
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<Brightness>(
          valueListenable: _brightnessNotifier,
          builder: (context, brightness, _) {
            final bool isDark = brightness == Brightness.dark;

            return Button.small(
              onPressed: () {
                _brightnessNotifier.value = isDark
                    ? Brightness.light
                    : Brightness.dark;
              },
              icon: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
              ),
              label: isDark ? 'Light mode' : 'Dark mode',
              variant: ButtonVariant.ghost,
            );
          },
        ),
      ],
    );
  }

  Widget _buildLinkButton({
    required IconData icon,
    required String url,
  }) {
    return IconButton(
      onPressed: () {
        launchUrl(Uri.parse(url));
      },
      icon: Icon(
        icon,
        size: 20,
      ),
      style: IconButton.styleFrom(
        foregroundColor: const Color(0xFF71717A),
      ),
    );
  }
}

class _PageInfo {
  final String title;
  final IconData icon;
  final Widget page;

  const _PageInfo({
    required this.title,
    required this.icon,
    required this.page,
  });
}
