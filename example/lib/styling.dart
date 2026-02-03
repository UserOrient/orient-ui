import 'package:flutter/widgets.dart';

// ============================================================================
// CUSTOMIZE THESE VALUES
// ============================================================================

// Breakpoints
const double _desktopBreakpoint = 600;

// Radii
const double _radiusSmall = 8;
const double _radiusMedium = 12;
const double _radiusLarge = 24;

// Durations
const Duration _durationFast = Duration(milliseconds: 100);
const Duration _durationNormal = Duration(milliseconds: 200);
const Duration _durationSlow = Duration(milliseconds: 300);

// Light Theme - Base
const Color _lightBackground = Color(0xFFFFFFFF);
const Color _lightBorder = Color(0xFFE4E4E7);
const Color _lightPrimaryText = Color(0xFF2A2A2A);
const Color _lightSecondaryText = Color(0xFFACAEAF);

// Light Theme - Button
const Color _lightButtonPrimary = Color(0xFF18181B);
const Color _lightButtonPrimaryForeground = Color(0xFFFAFAFA);
const Color _lightButtonSecondary = Color(0xFFF4F4F5);
const Color _lightButtonSecondaryForeground = Color(0xFF18181B);
const Color _lightButtonDestructive = Color(0xFFEF4444);
const Color _lightButtonDestructiveForeground = Color(0xFFFAFAFA);
const Color _lightButtonLink = Color(0xFF3B82F6);
const Color _lightButtonAccent = Color(0xFFF4F4F5);

// Light Theme - Navigation
const Color _lightNavRailBackground = Color(0xFFFAFAFA);
const Color _lightNavRailItemBackgroundActive = Color(0xFFFFFFFF);
const Color _lightNavRailItemBackgroundHover = Color(0xFFF2F2F2);
const Color _lightNavRailItemText = Color(0xFF2A2A2A);
const Color _lightNavBottomBarBackground = Color(0xFFFFFFFF);
const Color _lightNavBottomBarItemActive = Color(0xFF121212);
const Color _lightNavBottomBarItemInactive = Color(0xFFBBBBBB);

// Light Theme - Toast
const Color _lightToastSuccess = Color(0xFF52DF82);
const Color _lightToastError = Color(0xFFFF6D62);
const Color _lightToastInfo = Color(0xFF529BDF);
const Color _lightToastWarning = Color(0xFFFFB35A);

// Dark Theme - Base
const Color _darkBackground = Color(0xFF303030);
const Color _darkBorder = Color(0xFF27272A);
const Color _darkPrimaryText = Color(0xFFFAFAFA);
const Color _darkSecondaryText = Color(0xFFB2B2B2);

// Dark Theme - Button
const Color _darkButtonPrimary = Color(0xFFFAFAFA);
const Color _darkButtonPrimaryForeground = Color(0xFF18181B);
const Color _darkButtonSecondary = Color(0xFF27272A);
const Color _darkButtonSecondaryForeground = Color(0xFFFAFAFA);
const Color _darkButtonDestructive = Color(0xFFEF4444);
const Color _darkButtonDestructiveForeground = Color(0xFFFAFAFA);
const Color _darkButtonLink = Color(0xFF60A5FA);
const Color _darkButtonAccent = Color(0xFF27272A);

// Dark Theme - Navigation
const Color _darkNavRailBackground = Color(0xFF121212);
const Color _darkNavRailItemBackgroundActive = Color(0xFF2A2A2A);
const Color _darkNavRailItemBackgroundHover = Color(0xFF080808);
const Color _darkNavRailItemText = Color(0xFFFAFAFA);
const Color _darkNavBottomBarBackground = Color(0xFF121212);
const Color _darkNavBottomBarItemActive = Color(0xFFFAFAFA);
const Color _darkNavBottomBarItemInactive = Color(0xFF71717A);

// Dark Theme - Toast
const Color _darkToastSuccess = Color(0xFF52DF82);
const Color _darkToastError = Color(0xFFFF6D62);
const Color _darkToastInfo = Color(0xFF529BDF);
const Color _darkToastWarning = Color(0xFFFFB35A);

// ============================================================================
// INTERNAL - NO NEED TO EDIT BELOW
// ============================================================================

final BreakpointTokens _breakpoints = BreakpointTokens(
  desktop: _desktopBreakpoint,
);

final RadiusTokens _radii = RadiusTokens(
  small: _radiusSmall,
  medium: _radiusMedium,
  large: _radiusLarge,
);

final DurationTokens _durations = DurationTokens(
  fast: _durationFast,
  normal: _durationNormal,
  slow: _durationSlow,
);

final ColorTokens _colorsLight = ColorTokens(
  background: _lightBackground,
  border: _lightBorder,
  primaryText: _lightPrimaryText,
  secondaryText: _lightSecondaryText,
  button: ButtonColors(
    primary: _lightButtonPrimary,
    primaryForeground: _lightButtonPrimaryForeground,
    secondary: _lightButtonSecondary,
    secondaryForeground: _lightButtonSecondaryForeground,
    destructive: _lightButtonDestructive,
    destructiveForeground: _lightButtonDestructiveForeground,
    link: _lightButtonLink,
    accent: _lightButtonAccent,
  ),
  navigation: NavigationColors(
    railBackground: _lightNavRailBackground,
    railItemBackgroundActive: _lightNavRailItemBackgroundActive,
    railItemBackgroundHover: _lightNavRailItemBackgroundHover,
    railItemText: _lightNavRailItemText,
    bottomBarBackground: _lightNavBottomBarBackground,
    bottomBarItemActive: _lightNavBottomBarItemActive,
    bottomBarItemInactive: _lightNavBottomBarItemInactive,
  ),
  toast: ToastColors(
    success: _lightToastSuccess,
    error: _lightToastError,
    info: _lightToastInfo,
    warning: _lightToastWarning,
  ),
);

final ColorTokens _colorsDark = ColorTokens(
  background: _darkBackground,
  border: _darkBorder,
  primaryText: _darkPrimaryText,
  secondaryText: _darkSecondaryText,
  button: ButtonColors(
    primary: _darkButtonPrimary,
    primaryForeground: _darkButtonPrimaryForeground,
    secondary: _darkButtonSecondary,
    secondaryForeground: _darkButtonSecondaryForeground,
    destructive: _darkButtonDestructive,
    destructiveForeground: _darkButtonDestructiveForeground,
    link: _darkButtonLink,
    accent: _darkButtonAccent,
  ),
  navigation: NavigationColors(
    railBackground: _darkNavRailBackground,
    railItemBackgroundActive: _darkNavRailItemBackgroundActive,
    railItemBackgroundHover: _darkNavRailItemBackgroundHover,
    railItemText: _darkNavRailItemText,
    bottomBarBackground: _darkNavBottomBarBackground,
    bottomBarItemActive: _darkNavBottomBarItemActive,
    bottomBarItemInactive: _darkNavBottomBarItemInactive,
  ),
  toast: ToastColors(
    success: _darkToastSuccess,
    error: _darkToastError,
    info: _darkToastInfo,
    warning: _darkToastWarning,
  ),
);

class Styling extends InheritedWidget {
  final Brightness brightness;

  const Styling({
    super.key,
    required this.brightness,
    required super.child,
  });

  // Static - no context needed
  static RadiusTokens get radii => _radii;
  static DurationTokens get durations => _durations;
  static BreakpointTokens get breakpoints => _breakpoints;

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
      colors: isDark ? _colorsDark : _colorsLight,
      radii: _radii,
      durations: _durations,
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
  final ColorTokens colors;
  final RadiusTokens radii;
  final DurationTokens durations;
  final BreakpointTokens breakpoints;

  const StylingData({
    required this.isDark,
    required this.colors,
    required this.radii,
    required this.durations,
    required this.breakpoints,
  });
}

class BreakpointTokens {
  final double desktop;

  const BreakpointTokens({
    required this.desktop,
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

class ColorTokens {
  final Color background;
  final Color border;
  final Color primaryText;
  final Color secondaryText;
  final ButtonColors button;
  final NavigationColors navigation;
  final ToastColors toast;

  const ColorTokens({
    required this.background,
    required this.border,
    required this.primaryText,
    required this.secondaryText,
    required this.button,
    required this.navigation,
    required this.toast,
  });
}
