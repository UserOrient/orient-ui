import 'package:flutter/widgets.dart';
import 'package:example/style.dart';

export 'package:example/style.dart';

/// Wraps a widget with Style for testing
Widget wrapWithStyle(Widget child, {Brightness brightness = Brightness.light}) {
  return Style(
    brightness: brightness,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: const MediaQueryData(),
        child: child,
      ),
    ),
  );
}

/// Wraps a widget with Style and custom screen size
Widget wrapWithStyleAndSize(
  Widget child, {
  Brightness brightness = Brightness.light,
  Size size = const Size(800, 600),
}) {
  return Style(
    brightness: brightness,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: MediaQueryData(size: size),
        child: child,
      ),
    ),
  );
}
