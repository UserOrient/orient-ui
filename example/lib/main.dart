import 'package:example/pages/colors_page.dart';
import 'package:example/pages/widgets_page.dart';
import 'package:example/pages/typography_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:example/widgets/tappable_icon.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:example/style.dart';
import 'package:example/widgets/copy_button.dart';
import 'package:example/widgets/nav_bar.dart';
import 'package:example/widgets/picker.dart';
import 'package:example/widgets/popup.dart';

final ValueNotifier<Brightness> _brightnessNotifier = ValueNotifier(
  Brightness.light,
);

final ValueNotifier<TextDirection> _directionNotifier = ValueNotifier(
  TextDirection.ltr,
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

        return ValueListenableBuilder<TextDirection>(
          valueListenable: _directionNotifier,
          builder: (context, direction, _) {
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
                builder: (context, child) {
                  return Directionality(
                    textDirection: direction,
                    child: child!,
                  );
                },
                home: const RootPage(),
              ),
            );
          },
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
      title: 'Widgets',
      icon: TablerIcons.layout_dashboard,
      page: WidgetsPage(),
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
          child: ListView(
            padding: .zero,
            children: [
              _pages[_currentIndex].page,
            ],
          ),
        ),
        railFooter: _buildFooter(),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Popup.show(
              context: context,
              title: 'Built with Orient UI',
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Show some love! Add this badge to your app if you\'re building with Orient UI.',
                    style: context.typography.body.muted(context),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Style.of(context).colors.surfaceContainer,
                      borderRadius: BorderRadius.circular(Style.radii.small),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'https://userorient.com/built-with-orient-ui.svg',
                            style: context.typography.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        CopyButton(
                          value:
                              'https://userorient.com/built-with-orient-ui.svg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: SvgPicture.network(
              'https://userorient.com/built-with-orient-ui.svg',
            ),
          ),
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
            return Picker<Brightness>(
              label: 'Theme',
              value: brightness,
              items: Brightness.values,
              itemLabel: (b) => b == Brightness.light ? 'Light' : 'Dark',
              onChanged: (b) => _brightnessNotifier.value = b,
            );
          },
        ),
        const SizedBox(height: 4),
        ValueListenableBuilder<TextDirection>(
          valueListenable: _directionNotifier,
          builder: (context, direction, _) {
            return Picker<TextDirection>(
              label: 'Direction',
              value: direction,
              items: TextDirection.values,
              itemLabel: (d) => d == TextDirection.ltr ? 'LTR' : 'RTL',
              onChanged: (d) => _directionNotifier.value = d,
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
