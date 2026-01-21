import 'package:example/styling.dart';
import 'package:example/widgets/button.dart';
import 'package:example/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

final ValueNotifier<Brightness> brightnessNotifier = ValueNotifier(
  Brightness.light,
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: brightnessNotifier,
      builder: (context, Brightness brightness, child) {
        return Styling(
          brightness: brightness,
          child: MaterialApp(
            themeMode: brightness == Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: AppBarThemeData(backgroundColor: Colors.black),
            ),
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarThemeData(backgroundColor: Colors.white),
            ),
            title: 'Flutter Demo',
            home: const MyHomePage(),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loggingIn = false;
  bool _creatingProject = false;
  int _navBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavBar(
        railHeader: FlutterLogo(size: 120, style: FlutterLogoStyle.horizontal),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              ValueListenableBuilder<Brightness>(
                valueListenable: brightnessNotifier,
                builder: (context, value, child) {
                  return Button(
                    onPressed: () async {
                      brightnessNotifier.value = value == Brightness.light
                          ? Brightness.dark
                          : Brightness.light;
                    },
                    icon: Icon(
                      value == Brightness.light
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                    label: 'Toggle theme',
                    variant: ButtonVariant.outline,
                  );
                },
              ),
              const SizedBox(height: 24),
              Button(
                onPressed: () async {
                  setState(() {
                    _loggingIn = true;
                  });

                  await Future.delayed(const Duration(seconds: 1));

                  setState(() {
                    _loggingIn = false;
                  });
                },
                label: _loggingIn ? 'Checking...' : 'Log in',
                variant: ButtonVariant.primary,
                loading: _loggingIn,
              ),
              const SizedBox(height: 24),
              Button(
                onPressed: () async {
                  setState(() {
                    _creatingProject = true;
                  });

                  await Future.delayed(const Duration(seconds: 1));

                  setState(() {
                    _creatingProject = false;
                  });
                },
                label: _creatingProject ? 'Deleting...' : 'Delete project',
                loading: _creatingProject,
                variant: ButtonVariant.destructive,
                icon: Icon(Icons.delete),
              ),
              const SizedBox(height: 24),
              Button(
                label: 'This button disabled',
                loading: _creatingProject,
                variant: ButtonVariant.primary,
                icon: Icon(Icons.disabled_by_default),
              ),
              const SizedBox(height: 24),
              Button.small(
                onPressed: () async {},
                label: 'Translate',
                variant: ButtonVariant.secondary,
                icon: Icon(Icons.translate),
              ),
              const SizedBox(height: 24),
              Button.small(
                onPressed: () async {},
                label: 'Invite members',
                variant: ButtonVariant.ghost,
              ),
              const SizedBox(height: 24),
              Button.small(
                onPressed: () async {},
                label: 'Visit website',
                variant: ButtonVariant.link,
              ),
            ],
          ),
        ),
        currentIndex: _navBarIndex,
        onTap: (int index) {
          setState(() {
            _navBarIndex = index;
          });
        },
        items: [
          NavBarItem(
            icon: Icon(TablerIcons.layout_dashboard),
            label: 'Dashboard',
          ),
          NavBarItem(icon: Icon(TablerIcons.users), label: 'Members'),
          NavBarItem(icon: Icon(TablerIcons.plug), label: 'Docs'),
          NavBarItem(icon: Icon(TablerIcons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
