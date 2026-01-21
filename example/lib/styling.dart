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

class ButtonColors {
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryForeground;
  final Color destructive;
  final Color destructiveForeground;
  final Color link;
  final Color accent;

  const ButtonColors({
    this.primary = const Color(0xFF18181B),
    this.primaryForeground = const Color(0xFFFAFAFA),
    this.secondary = const Color(0xFFF4F4F5),
    this.secondaryForeground = const Color(0xFF18181B),
    this.destructive = const Color(0xFFEF4444),
    this.destructiveForeground = const Color(0xFFFAFAFA),
    this.link = const Color(0xFF3B82F6),
    this.accent = const Color(0xFFF4F4F5),
  });

  static const dark = ButtonColors(
    primary: Color(0xFFFAFAFA),
    primaryForeground: Color(0xFF18181B),
    secondary: Color(0xFF27272A),
    secondaryForeground: Color(0xFFFAFAFA),
    destructive: Color(0xFFEF4444),
    destructiveForeground: Color(0xFFFAFAFA),
    link: Color(0xFF60A5FA),
    accent: Color(0xFF27272A),
  );
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

class ToastColors {
  final Color success;
  final Color error;
  final Color info;
  final Color warning;

  const ToastColors({
    this.success = const Color(0xFF52DF82),
    this.error = const Color(0xFFFF6D62),
    this.info = const Color(0xFF529BDF),
    this.warning = const Color(0xFFFFB35A),
  });

  static const light = ToastColors();

  static const dark = ToastColors();
}

class AppColors {
  final Color border;

  // Component colors
  final ButtonColors button;
  final NavigationColors navigation;
  final ToastColors toast;

  const AppColors({
    required this.border,
    this.button = const ButtonColors(),
    this.navigation = const NavigationColors(),
    this.toast = const ToastColors(),
  });

  // Light mode defaults - CUSTOMIZE THESE
  static const light = AppColors(border: Color(0xFFE4E4E7));

  // Dark mode defaults - CUSTOMIZE THESE
  static const dark = AppColors(
    border: Color(0xFF27272A),
    button: ButtonColors.dark,
    navigation: NavigationColors.dark,
    toast: ToastColors.dark,
  );
}
