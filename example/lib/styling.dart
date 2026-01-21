import 'package:flutter/widgets.dart';

class Styling extends InheritedWidget {
  final Brightness brightness;

  const Styling({super.key, required this.brightness, required super.child});

  static StylingData of(BuildContext context) {
    final styling = context.dependOnInheritedWidgetOfExactType<Styling>();
    assert(
      styling != null,
      'No Styling found in context. Wrap your app with Styling widget.',
    );

    final isDark = styling!.brightness == Brightness.dark;

    return StylingData(
      isDark: isDark,
      colors: isDark ? AppColors.dark : AppColors.light,
    );
  }

  @override
  bool updateShouldNotify(Styling oldWidget) =>
      brightness != oldWidget.brightness;
}

class StylingData {
  final bool isDark;
  final AppColors colors;
  final Breakpoints breakpoints;

  StylingData({
    required this.isDark,
    required this.colors,
    this.breakpoints = const Breakpoints(),
  });
}

class Breakpoints {
  final double desktop;

  const Breakpoints({this.desktop = 600});
}

class NavigationColors {
  final Color railBackground;
  final Color railItemBackgroundActive;
  final Color railItemBackgroundHover;
  final Color railItemText;
  final Color bottomBarBackground;
  final Color bottomBarItemActive;
  final Color bottomBarItemInactive;

  const NavigationColors({
    this.railBackground = const Color(0xFFFAFAFA),
    this.railItemBackgroundActive = const Color(0xFFFFFFFF),
    this.railItemBackgroundHover = const Color(0xFFF2F2F2),
    this.railItemText = const Color(0xFF2A2A2A),
    this.bottomBarBackground = const Color(0xFFFFFFFF),
    this.bottomBarItemActive = const Color(0xFF121212),
    this.bottomBarItemInactive = const Color(0xFFBBBBBB),
  });

  static const dark = NavigationColors(
    railBackground: Color(0xFF121212),
    railItemBackgroundActive: Color(0xFF2A2A2A),
    railItemBackgroundHover: Color(0xFF080808),
    railItemText: Color(0xFFFAFAFA),
    bottomBarBackground: Color(0xFF121212),
    bottomBarItemActive: Color(0xFFFAFAFA),
    bottomBarItemInactive: Color(0xFF71717A),
  );
}

class AppColors {
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryForeground;
  final Color destructive;
  final Color destructiveForeground;
  final Color border;
  final Color accent;
  final Color link;

  // Navigation colors
  final NavigationColors navigation;

  const AppColors({
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.destructive,
    required this.destructiveForeground,
    required this.border,
    required this.accent,
    required this.link,
    this.navigation = const NavigationColors(),
  });

  // Light mode defaults - CUSTOMIZE THESE
  static const light = AppColors(
    primary: Color(0xFF18181B),
    primaryForeground: Color(0xFFFAFAFA),
    secondary: Color(0xFFF4F4F5),
    secondaryForeground: Color(0xFF18181B),
    destructive: Color(0xFFEF4444),
    destructiveForeground: Color(0xFFFAFAFA),
    border: Color(0xFFE4E4E7),
    accent: Color(0xFFF4F4F5), // Light gray for hover
    link: Color(0xFF3B82F6), // Standard blue link
  );

  // Dark mode defaults - CUSTOMIZE THESE
  static const dark = AppColors(
    primary: Color(0xFFFAFAFA),
    primaryForeground: Color(0xFF18181B),
    secondary: Color(0xFF27272A),
    secondaryForeground: Color(0xFFFAFAFA),
    destructive: Color(0xFFEF4444),
    destructiveForeground: Color(0xFFFAFAFA),
    border: Color(0xFF27272A),
    accent: Color(0xFF27272A), // Dark gray for hover
    link: Color(0xFF60A5FA), // Lighter blue for dark mode
    navigation: NavigationColors.dark,
  );
}
