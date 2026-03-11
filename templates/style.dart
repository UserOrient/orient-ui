import 'package:flutter/widgets.dart';

// Light Theme

final ColorTokens _colorsLight = ColorTokens(
  background: Color(0xFFFFFFFF),
  border: Color(0xFFE4E4E7),
  foreground: Color(0xFF2A2A2A),
  mutedForeground: Color(0xFFACAEAF),
  accent: Color(0xFF18181B),
  accentForeground: Color(0xFFFAFAFA),
  surfaceContainer: Color(0xFFFAFAFA),
  button: ButtonColors(
    primary: Color(0xFF18181B),
    primaryForeground: Color(0xFFFAFAFA),
    secondary: Color(0xFFF4F4F5),
    secondaryForeground: Color(0xFF18181B),
    destructive: Color(0xFFEF4444),
    destructiveForeground: Color(0xFFFAFAFA),
    link: Color(0xFF3B82F6),
    accent: Color(0xFFF4F4F5),
  ),
  navigation: NavigationColors(
    railBackground: Color(0xFFFAFAFA),
    railItemBackgroundActive: Color(0xFFFFFFFF),
    railItemBackgroundHover: Color(0xFFF2F2F2),
    railItemText: Color(0xFF2A2A2A),
    bottomBarBackground: Color(0xFFFFFFFF),
    bottomBarItemActive: Color(0xFF121212),
    bottomBarItemInactive: Color(0xFFBBBBBB),
  ),
  toast: ToastColors(
    success: Color(0xFF52DF82),
    error: Color(0xFFFF6D62),
    info: Color(0xFF529BDF),
    warning: Color(0xFFFFB35A),
  ),
);

// Dark Theme

final ColorTokens _colorsDark = ColorTokens(
  background: Color(0xFF303030),
  border: Color(0xFF27272A),
  foreground: Color(0xFFFAFAFA),
  mutedForeground: Color(0xFFB2B2B2),
  accent: Color(0xFFFAFAFA),
  accentForeground: Color(0xFF18181B),
  surfaceContainer: Color(0xFF121212),
  button: ButtonColors(
    primary: Color(0xFFFAFAFA),
    primaryForeground: Color(0xFF18181B),
    secondary: Color(0xFF27272A),
    secondaryForeground: Color(0xFFFAFAFA),
    destructive: Color(0xFFEF4444),
    destructiveForeground: Color(0xFFFAFAFA),
    link: Color(0xFF60A5FA),
    accent: Color(0xFF27272A),
  ),
  navigation: NavigationColors(
    railBackground: Color(0xFF121212),
    railItemBackgroundActive: Color(0xFF2A2A2A),
    railItemBackgroundHover: Color(0xFF080808),
    railItemText: Color(0xFFFAFAFA),
    bottomBarBackground: Color(0xFF121212),
    bottomBarItemActive: Color(0xFFFAFAFA),
    bottomBarItemInactive: Color(0xFF71717A),
  ),
  toast: ToastColors(
    success: Color(0xFF52DF82),
    error: Color(0xFFFF6D62),
    info: Color(0xFF529BDF),
    warning: Color(0xFFFFB35A),
  ),
);

// Tokens

final RadiusTokens _radii = RadiusTokens(
  small: 8,
  medium: 12,
  large: 24,
);

final DurationTokens _durations = DurationTokens(
  fast: Duration(milliseconds: 100),
  normal: Duration(milliseconds: 200),
  slow: Duration(milliseconds: 300),
);

final BreakpointTokens _breakpoints = BreakpointTokens(
  desktop: 600,
);

// Style

class Style extends InheritedWidget {
  final Brightness brightness;

  const Style({
    super.key,
    required this.brightness,
    required super.child,
  });

  Style._fallback(this.brightness) : super(child: const SizedBox.shrink());

  bool get isDark => brightness == Brightness.dark;
  ColorTokens get colors => isDark ? _colorsDark : _colorsLight;

  static RadiusTokens get radii => _radii;
  static DurationTokens get durations => _durations;
  static BreakpointTokens get breakpoints => _breakpoints;

  static Style of(BuildContext context) {
    final style = context.dependOnInheritedWidgetOfExactType<Style>();
    if (style != null) return style;
    final brightness = MediaQuery.platformBrightnessOf(context);
    return Style._fallback(brightness);
  }

  @override
  bool updateShouldNotify(Style oldWidget) {
    return brightness != oldWidget.brightness;
  }
}

// Token Definitions

class ColorTokens {
  final Color background;
  final Color border;
  final Color foreground;
  final Color mutedForeground;
  final Color accent;
  final Color accentForeground;
  final Color surfaceContainer;
  final ButtonColors button;
  final NavigationColors navigation;
  final ToastColors toast;

  const ColorTokens({
    required this.background,
    required this.border,
    required this.foreground,
    required this.mutedForeground,
    required this.accent,
    required this.accentForeground,
    required this.surfaceContainer,
    required this.button,
    required this.navigation,
    required this.toast,
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

class RadiusTokens {
  final double small;
  final double medium;
  final double large;

  const RadiusTokens({
    required this.small,
    required this.medium,
    required this.large,
  });
}

class DurationTokens {
  final Duration fast;
  final Duration normal;
  final Duration slow;

  const DurationTokens({
    required this.fast,
    required this.normal,
    required this.slow,
  });
}

class BreakpointTokens {
  final double desktop;

  const BreakpointTokens({
    required this.desktop,
  });
}

// Extensions

extension StyleX on BuildContext {
  Style get style => Style.of(this);
}
