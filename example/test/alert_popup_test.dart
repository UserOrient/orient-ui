import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/alert_popup.dart';
import 'package:example/widgets/button.dart';

import 'test_helper.dart';

/// Wraps widget with Navigator for route-based popup tests
Widget wrapWithNavigator(
  Widget child, {
  Brightness brightness = Brightness.light,
}) {
  return Styling(
    brightness: brightness,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: const MediaQueryData(size: Size(800, 600)),
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
  group('AlertPopup', () {
    group('rendering', () {
      testWidgets('renders with title only', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            AlertPopup(
              icon: null,
              title: 'Something happened',
              description: null,
              action: null,
            ),
          ),
        );

        expect(find.text('Something happened'), findsOneWidget);
      });

      testWidgets('renders with title and description', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            AlertPopup(
              icon: null,
              title: 'Payment successful',
              description: 'Your payment of \$49.99 has been processed.',
              action: null,
            ),
          ),
        );

        expect(find.text('Payment successful'), findsOneWidget);
        expect(
          find.text('Your payment of \$49.99 has been processed.'),
          findsOneWidget,
        );
      });

      testWidgets('renders with icon', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            AlertPopup(
              icon: const SizedBox(
                key: Key('test-icon'),
                width: 24,
                height: 24,
              ),
              title: 'With icon',
              description: null,
              action: null,
            ),
          ),
        );

        expect(find.byKey(const Key('test-icon')), findsOneWidget);
      });

      testWidgets('renders with action widget', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            AlertPopup(
              icon: null,
              title: 'Test',
              description: null,
              action: const SizedBox(key: Key('action-widget')),
            ),
          ),
        );

        expect(find.byKey(const Key('action-widget')), findsOneWidget);
      });

      testWidgets('does not render description when null', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            AlertPopup(
              icon: null,
              title: 'Title only',
              description: null,
              action: null,
            ),
          ),
        );

        final texts = tester.widgetList<Text>(find.byType(Text)).toList();
        expect(texts.length, 1);
        expect((texts[0].data), 'Title only');
      });

      testWidgets('does not render description when empty', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            AlertPopup(
              icon: null,
              title: 'Title only',
              description: '',
              action: null,
            ),
          ),
        );

        final texts = tester.widgetList<Text>(find.byType(Text)).toList();
        expect(texts.length, 1);
      });

      testWidgets('does not render action when null', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            AlertPopup(
              icon: null,
              title: 'No action',
              description: null,
              action: null,
            ),
          ),
        );

        expect(find.byType(Button), findsNothing);
      });

      testWidgets('icon is constrained to 48x48', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            AlertPopup(
              icon: const SizedBox(width: 100, height: 100),
              title: 'Test',
              description: null,
              action: null,
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(
          find
              .ancestor(
                of: find.byType(FittedBox),
                matching: find.byType(SizedBox),
              )
              .first,
        );

        expect(sizedBox.width, 48);
        expect(sizedBox.height, 48);
      });
    });

    group('AlertPopup.show', () {
      testWidgets('shows popup as route', (tester) async {
        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    AlertPopup.show(
                      context: context,
                      title: 'Test popup',
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        );

        expect(find.text('Test popup'), findsNothing);

        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        expect(find.text('Test popup'), findsOneWidget);
      });

      testWidgets('action button can pop the popup', (tester) async {
        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    AlertPopup.show(
                      context: context,
                      title: 'Dismissable',
                      action: Builder(
                        builder: (popupContext) {
                          return GestureDetector(
                            onTap: () => Navigator.of(popupContext).pop(),
                            child: const Text('Close'),
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

        expect(find.text('Dismissable'), findsOneWidget);

        await tester.tap(find.text('Close'));
        await tester.pumpAndSettle();

        expect(find.text('Dismissable'), findsNothing);
      });

      testWidgets('barrier tap closes popup', (tester) async {
        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    AlertPopup.show(
                      context: context,
                      title: 'Barrier test',
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

      testWidgets('shows with all parameters', (tester) async {
        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    AlertPopup.show(
                      context: context,
                      icon: const SizedBox(key: Key('show-icon')),
                      title: 'Full alert',
                      description: 'With everything',
                      action: const SizedBox(key: Key('show-action')),
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

        expect(find.text('Full alert'), findsOneWidget);
        expect(find.text('With everything'), findsOneWidget);
        expect(find.byKey(const Key('show-icon')), findsOneWidget);
        expect(find.byKey(const Key('show-action')), findsOneWidget);
      });
    });

    group('accessibility', () {
      testWidgets('has semantics label', (tester) async {
        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    AlertPopup.show(
                      context: context,
                      title: 'Important notice',
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
          find.bySemanticsLabel('Alert popup: Important notice'),
          findsOneWidget,
        );
      });
    });

    group('responsive padding', () {
      testWidgets('uses mobile padding on small screens', (tester) async {
        await tester.pumpWidget(
          wrapWithStylingAndSize(
            AlertPopup(
              icon: null,
              title: 'Test',
              description: null,
              action: null,
            ),
            size: const Size(400, 800),
          ),
        );

        final container =
            tester.widget<Container>(find.byType(Container).first);
        final padding = container.padding as EdgeInsets;

        expect(padding.left, 24);
        expect(padding.right, 24);
        expect(padding.top, 32);
        expect(padding.bottom, 24);
      });

      testWidgets('uses desktop padding on large screens', (tester) async {
        await tester.pumpWidget(
          wrapWithStylingAndSize(
            AlertPopup(
              icon: null,
              title: 'Test',
              description: null,
              action: null,
            ),
            size: const Size(800, 600),
          ),
        );

        final container =
            tester.widget<Container>(find.byType(Container).first);
        final padding = container.padding as EdgeInsets;

        expect(padding.left, 48);
        expect(padding.right, 48);
        expect(padding.top, 64);
        expect(padding.bottom, 48);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            AlertPopup(
              icon: null,
              title: 'Light mode',
              description: null,
              action: null,
            ),
            brightness: Brightness.light,
          ),
        );

        expect(find.text('Light mode'), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            AlertPopup(
              icon: null,
              title: 'Dark mode',
              description: null,
              action: null,
            ),
            brightness: Brightness.dark,
          ),
        );

        expect(find.text('Dark mode'), findsOneWidget);
      });
    });
  });
}
