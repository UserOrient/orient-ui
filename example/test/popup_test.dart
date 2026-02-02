import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/popup.dart';

import 'test_helper.dart';

/// Wraps widget with Navigator for route-based popup tests
Widget wrapWithNavigator(
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
        child: Navigator(
          onGenerateRoute: (_) {
            return PageRouteBuilder(
              pageBuilder: (_, _, _) {
                return child;
              },
            );
          },
        ),
      ),
    ),
  );
}

void main() {
  group('Popup', () {
    group('rendering', () {
      testWidgets('renders without error', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Popup(
            title: 'Test',
            child: SizedBox(),
          ),
        ));

        expect(find.byType(Popup), findsOneWidget);
      });

      testWidgets('renders with title', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Popup(
            title: 'My Title',
            child: SizedBox(),
          ),
        ));

        expect(find.text('My Title'), findsOneWidget);
      });

      testWidgets('renders without title', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Popup(
            child: Text('Content only'),
          ),
        ));

        expect(find.text('Content only'), findsOneWidget);
      });

      testWidgets('renders child widget', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Popup(
            title: 'Test',
            child: SizedBox(key: Key('child-widget')),
          ),
        ));

        expect(find.byKey(const Key('child-widget')), findsOneWidget);
      });

      testWidgets('renders close button', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Popup(
            title: 'Test',
            child: SizedBox(),
          ),
        ));

        expect(find.byType(CustomPaint), findsOneWidget);
      });

      testWidgets('renders close button even without title', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Popup(
            child: SizedBox(),
          ),
        ));

        expect(find.byType(CustomPaint), findsOneWidget);
      });
    });

    group('Popup.show', () {
      testWidgets('shows popup as route', (tester) async {
        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Popup.show(
                      context: context,
                      title: 'Route popup',
                      child: Text('Hello'),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        );

        expect(find.text('Route popup'), findsNothing);

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        expect(find.text('Route popup'), findsOneWidget);
        expect(find.text('Hello'), findsOneWidget);
      });

      testWidgets('shows popup without title', (tester) async {
        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Popup.show(
                      context: context,
                      child: Text('No title content'),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        expect(find.text('No title content'), findsOneWidget);
      });

      testWidgets('close button dismisses popup', (tester) async {
        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Popup.show(
                      context: context,
                      title: 'Closeable',
                      child: Text('Content'),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        expect(find.text('Closeable'), findsOneWidget);

        // Tap the close button (CustomPaint is the X icon)
        await tester.tap(find.byType(CustomPaint));
        await tester.pumpAndSettle();

        expect(find.text('Closeable'), findsNothing);
      });

      testWidgets('barrier tap closes popup', (tester) async {
        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Popup.show(
                      context: context,
                      title: 'Barrier test',
                      child: SizedBox(),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        expect(find.text('Barrier test'), findsOneWidget);

        // Tap on barrier (top-left corner, outside dialog)
        await tester.tapAt(const Offset(10, 10));
        await tester.pumpAndSettle();

        expect(find.text('Barrier test'), findsNothing);
      });

      testWidgets('child can pop the popup', (tester) async {
        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Popup.show(
                      context: context,
                      title: 'Child pops',
                      child: Builder(
                        builder: (popupContext) {
                          return GestureDetector(
                            onTap: () => Navigator.of(popupContext).pop(),
                            child: const Text('Close from child'),
                          );
                        },
                      ),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        expect(find.text('Child pops'), findsOneWidget);

        await tester.tap(find.text('Close from child'));
        await tester.pumpAndSettle();

        expect(find.text('Child pops'), findsNothing);
      });
    });

    group('accessibility', () {
      testWidgets('has semantics label with title', (tester) async {
        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Popup.show(
                      context: context,
                      title: 'Settings',
                      child: SizedBox(),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        expect(
          find.bySemanticsLabel('Popup: Settings'),
          findsOneWidget,
        );
      });

      testWidgets('has semantics label without title', (tester) async {
        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Popup.show(
                      context: context,
                      child: SizedBox(),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        expect(
          find.bySemanticsLabel('Popup'),
          findsOneWidget,
        );
      });
    });

    group('responsive padding', () {
      testWidgets('uses mobile padding on small screens', (tester) async {
        await tester.pumpWidget(
          wrapWithStylingAndSize(
            Popup(
              title: 'Test',
              child: SizedBox(),
            ),
            size: const Size(400, 800),
          ),
        );

        final container =
            tester.widget<Container>(find.byType(Container).first);
        final padding = container.padding as EdgeInsets;

        expect(padding.left, 24);
        expect(padding.right, 24);
        expect(padding.top, 24);
        expect(padding.bottom, 24);
      });

      testWidgets('uses desktop padding on large screens', (tester) async {
        await tester.pumpWidget(
          wrapWithStylingAndSize(
            Popup(
              title: 'Test',
              child: SizedBox(),
            ),
            size: const Size(800, 600),
          ),
        );

        final container =
            tester.widget<Container>(find.byType(Container).first);
        final padding = container.padding as EdgeInsets;

        expect(padding.left, 48);
        expect(padding.right, 48);
        expect(padding.top, 48);
        expect(padding.bottom, 48);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            Popup(
              title: 'Light mode',
              child: SizedBox(),
            ),
            brightness: Brightness.light,
          ),
        );

        expect(find.text('Light mode'), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            Popup(
              title: 'Dark mode',
              child: SizedBox(),
            ),
            brightness: Brightness.dark,
          ),
        );

        expect(find.text('Dark mode'), findsOneWidget);
      });
    });
  });
}
