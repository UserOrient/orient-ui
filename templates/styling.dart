import 'package:flutter/widgets.dart';

// GLOBALS
final Breakpoints _breakpoints = Breakpoints(
  desktop: 600,
);

// LIGHT
const Color _borderLight = Color(0xFFE4E4E7);
const Color _primaryTextLight = Color(0xff2A2A2A);
const Color _secondaryTextLight = Color(0xffACAEAF);

final ButtonColors _buttonColorsLight = ButtonColors(
  primary: const Color(0xFF18181B),
  primaryForeground: const Color(0xFFFAFAFA),
  secondary: const Color(0xFFF4F4F5),
  secondaryForeground: const Color(0xFF18181B),
  destructive: const Color(0xFFEF4444),
  destructiveForeground: const Color(0xFFFAFAFA),
  link: const Color(0xFF3B82F6),
  accent: const Color(0xFFF4F4F5),
);

final NavigationColors _navigationColorsLight = NavigationColors(
  railBackground: const Color(0xFFFAFAFA),
  railItemBackgroundActive: const Color(0xFFFFFFFF),
  railItemBackgroundHover: const Color(0xFFF2F2F2),
  railItemText: const Color(0xFF2A2A2A),
  bottomBarBackground: const Color(0xFFFFFFFF),
  bottomBarItemActive: const Color(0xFF121212),
  bottomBarItemInactive: const Color(0xFFBBBBBB),
);

const ToastColors _toastColorsLight = ToastColors(
  success: Color(0xFF52DF82),
  error: Color(0xFFFF6D62),
  info: Color(0xFF529BDF),
  warning: Color(0xFFFFB35A),
);

// DARK
const Color _borderDark = Color(0xFF27272A);
const Color _primaryTextDark = Color(0xffFAFAFA);
const Color _secondaryTextDark = Color(0xffB2B2B2);

final ButtonColors _buttonColorsDark = ButtonColors(
  primary: Color(0xFFFAFAFA),
  primaryForeground: Color(0xFF18181B),
  secondary: Color(0xFF27272A),
  secondaryForeground: Color(0xFFFAFAFA),
  destructive: Color(0xFFEF4444),
  destructiveForeground: Color(0xFFFAFAFA),
  link: Color(0xFF60A5FA),
  accent: Color(0xFF27272A),
);

final NavigationColors _navigationColorsDark = NavigationColors(
  railBackground: Color(0xFF121212),
  railItemBackgroundActive: Color(0xFF2A2A2A),
  railItemBackgroundHover: Color(0xFF080808),
  railItemText: Color(0xFFFAFAFA),
  bottomBarBackground: Color(0xFF121212),
  bottomBarItemActive: Color(0xFFFAFAFA),
  bottomBarItemInactive: Color(0xFF71717A),
);

const ToastColors _toastColorsDark = ToastColors(
  success: Color(0xFF52DF82),
  error: Color(0xFFFF6D62),
  info: Color(0xFF529BDF),
  warning: Color(0xFFFFB35A),
);

// NO TOUCHING
final AppColors _appColorsLight = AppColors(
  border: _borderLight,
  primaryText: _primaryTextLight,
  secondaryText: _secondaryTextLight,
  navigation: _navigationColorsLight,
  button: _buttonColorsLight,
  toast: _toastColorsLight,
);

final AppColors _appColorsDark = AppColors(
  border: _borderDark,
  primaryText: _primaryTextDark,
  secondaryText: _secondaryTextDark,
  button: _buttonColorsDark,
  navigation: _navigationColorsDark,
  toast: _toastColorsDark,
);

class Styling extends InheritedWidget {
  final Brightness brightness;

  const Styling({
    super.key,
    required this.brightness,
    required super.child,
  });

  static StylingData of(BuildContext context) {
    final Styling? styling = context
        .dependOnInheritedWidgetOfExactType<Styling>();

    assert(
      styling != null,
      'No Styling found in context. Wrap your app with Styling widget.',
    );

    final bool isDark = styling!.brightness == Brightness.dark;

    return StylingData(
      isDark: isDark,
      colors: isDark ? _appColorsDark : _appColorsLight,
      breakpoints: _breakpoints,
    );
  }

  @override
  bool updateShouldNotify(Styling oldWidget) {
    return brightness != oldWidget.brightness;
  }
}

class StylingData {
  final bool isDark;
  final AppColors colors;
  final Breakpoints breakpoints;

  StylingData({
    required this.isDark,
    required this.colors,
    required this.breakpoints,
  });
}

class Breakpoints {
  final double desktop;

  const Breakpoints({
    required this.desktop,
  });
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
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.destructive,
    required this.destructiveForeground,
    required this.link,
    required this.accent,
  });
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
    required this.railBackground,
    required this.railItemBackgroundActive,
    required this.railItemBackgroundHover,
    required this.railItemText,
    required this.bottomBarBackground,
    required this.bottomBarItemActive,
    required this.bottomBarItemInactive,
  });
}

class ToastColors {
  final Color success;
  final Color error;
  final Color info;
  final Color warning;

  const ToastColors({
    required this.success,
    required this.error,
    required this.info,
    required this.warning,
  });
}

class AppColors {
  final Color border;
  final Color primaryText;
  final Color secondaryText;

  // Component colors
  final ButtonColors button;
  final NavigationColors navigation;
  final ToastColors toast;

  const AppColors({
    required this.border,
    required this.primaryText,
    required this.secondaryText,
    required this.button,
    required this.navigation,
    required this.toast,
  });
}
