import 'package:example/pages/colors_page.dart';
import 'package:example/pages/components_page.dart';
import 'package:example/pages/typography_page.dart';
import 'package:flutter/material.dart';
import 'package:example/widgets/tappable_icon.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:example/style.dart';
import 'package:example/widgets/button.dart';
import 'package:example/widgets/nav_bar.dart';

final ValueNotifier<Brightness> _brightnessNotifier = ValueNotifier(
  Brightness.light,
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Brightness>(
      valueListenable: _brightnessNotifier,
      builder: (context, brightness, _) {
        final bool isDark = brightness == Brightness.dark;

        return Style(
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
            home: const RootPage(),
          ),
        );
      },
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  static const _pages = [
    _PageInfo(
      title: 'Components',
      icon: TablerIcons.layout_dashboard,
      page: ComponentsPage(),
    ),
    _PageInfo(
      title: 'Colors',
      icon: TablerIcons.palette,
      page: ColorsPage(),
    ),
    _PageInfo(
      title: 'Typography',
      icon: TablerIcons.typography,
      page: TypographyPage(),
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
              url: 'https://userorient.com',
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
    return TappableIcon(
      onPressed: () {
        launchUrl(Uri.parse(url));
      },
      icon: Icon(icon),
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
