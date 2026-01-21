import 'package:flutter/widgets.dart';
import 'package:example/styling.dart';

export 'package:example/styling.dart';

/// Wraps a widget with Styling for testing
Widget wrapWithStyling(Widget child, {Brightness brightness = Brightness.light}) {
  return Styling(
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

/// Wraps a widget with Styling and custom screen size
Widget wrapWithStylingAndSize(
  Widget child, {
  Brightness brightness = Brightness.light,
  Size size = const Size(800, 600),
}) {
  return Styling(
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
