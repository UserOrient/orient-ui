import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/confirmation_popup.dart';
import 'package:example/widgets/button.dart';

import 'test_helper.dart';

/// Wraps widget with Navigator for overlay tests
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
  group('ConfirmationPopup', () {
    group('rendering', () {
      testWidgets('renders with title only', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            ConfirmationPopup(
              icon: null,
              title: 'Are you sure?',
              description: null,
              confirmLabel: 'Yes',
              cancelLabel: 'No',
              onConfirm: () {},
              onCancel: null,
              destructive: false,
            ),
          ),
        );

        expect(find.text('Are you sure?'), findsOneWidget);
        expect(find.text('Yes'), findsOneWidget);
        expect(find.text('No'), findsOneWidget);
      });

      testWidgets('renders with title and description', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            ConfirmationPopup(
              icon: null,
              title: 'Delete item?',
              description: 'This action cannot be undone.',
              confirmLabel: 'Delete',
              cancelLabel: 'Cancel',
              onConfirm: () {},
              onCancel: null,
              destructive: false,
            ),
          ),
        );

        expect(find.text('Delete item?'), findsOneWidget);
        expect(find.text('This action cannot be undone.'), findsOneWidget);
      });

      testWidgets('renders with icon', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            ConfirmationPopup(
              icon: const SizedBox(
                key: Key('test-icon'),
                width: 24,
                height: 24,
              ),
              title: 'With icon',
              description: null,
              confirmLabel: 'OK',
              cancelLabel: 'Cancel',
              onConfirm: () {},
              onCancel: null,
              destructive: false,
            ),
          ),
        );

        expect(find.byKey(const Key('test-icon')), findsOneWidget);
      });

      testWidgets('renders with custom button labels', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            ConfirmationPopup(
              icon: null,
              title: 'Logout?',
              description: null,
              confirmLabel: 'Yes, logout',
              cancelLabel: 'Stay here',
              onConfirm: () {},
              onCancel: null,
              destructive: false,
            ),
          ),
        );

        expect(find.text('Yes, logout'), findsOneWidget);
        expect(find.text('Stay here'), findsOneWidget);
      });

      testWidgets('icon is constrained to 48x48', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            ConfirmationPopup(
              icon: const SizedBox(width: 100, height: 100),
              title: 'Test',
              description: null,
              confirmLabel: 'OK',
              cancelLabel: 'Cancel',
              onConfirm: () {},
              onCancel: null,
              destructive: false,
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

    group('states', () {
      testWidgets('destructive mode shows destructive button', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            ConfirmationPopup(
              icon: null,
              title: 'Delete?',
              description: null,
              confirmLabel: 'Delete',
              cancelLabel: 'Cancel',
              onConfirm: () {},
              onCancel: null,
              destructive: true,
            ),
          ),
        );

        // Find the confirm button (second button in row)
        final buttons = tester.widgetList<Button>(find.byType(Button)).toList();
        expect(buttons.length, 2);

        // First button is cancel (secondary), second is confirm
        expect(buttons[0].variant, ButtonVariant.secondary);
        expect(buttons[1].variant, ButtonVariant.destructive);
      });

      testWidgets('non-destructive mode shows primary button', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            ConfirmationPopup(
              icon: null,
              title: 'Confirm?',
              description: null,
              confirmLabel: 'Confirm',
              cancelLabel: 'Cancel',
              onConfirm: () {},
              onCancel: null,
              destructive: false,
            ),
          ),
        );

        final buttons = tester.widgetList<Button>(find.byType(Button)).toList();
        expect(buttons[1].variant, ButtonVariant.primary);
      });
    });

    group('interaction', () {
      testWidgets('onConfirm fires when confirm button tapped', (tester) async {
        var confirmCalled = false;

        await tester.pumpWidget(
          wrapWithStyling(
            ConfirmationPopup(
              icon: null,
              title: 'Confirm?',
              description: null,
              confirmLabel: 'Yes',
              cancelLabel: 'No',
              onConfirm: () => confirmCalled = true,
              onCancel: null,
              destructive: false,
            ),
          ),
        );

        await tester.tap(find.text('Yes'));
        await tester.pump();

        expect(confirmCalled, isTrue);
      });

      testWidgets('onCancel fires when cancel button tapped', (tester) async {
        var cancelCalled = false;

        await tester.pumpWidget(
          wrapWithStyling(
            ConfirmationPopup(
              icon: null,
              title: 'Confirm?',
              description: null,
              confirmLabel: 'Yes',
              cancelLabel: 'No',
              onConfirm: () {},
              onCancel: () => cancelCalled = true,
              destructive: false,
            ),
          ),
        );

        await tester.tap(find.text('No'));
        await tester.pump();

        expect(cancelCalled, isTrue);
      });
    });

    group('ConfirmationPopup.show', () {
      testWidgets('inserts overlay entry', (tester) async {
        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    ConfirmationPopup.show(
                      context: context,
                      title: 'Test popup',
                      confirmLabel: 'OK',
                      cancelLabel: 'Cancel',
                      onConfirm: () {},
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        );

        // Popup not visible initially
        expect(find.text('Test popup'), findsNothing);

        // Tap to show popup
        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        // Popup is now visible
        expect(find.text('Test popup'), findsOneWidget);
      });

      testWidgets('confirm button calls onConfirm and closes', (tester) async {
        var confirmCalled = false;

        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    ConfirmationPopup.show(
                      context: context,
                      title: 'Confirm action?',
                      confirmLabel: 'Yes',
                      cancelLabel: 'No',
                      onConfirm: () => confirmCalled = true,
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

        await tester.tap(find.text('Yes'));
        await tester.pumpAndSettle();

        expect(confirmCalled, isTrue);
        expect(find.text('Confirm action?'), findsNothing);
      });

      testWidgets('cancel button calls onCancel and closes', (tester) async {
        var cancelCalled = false;

        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    ConfirmationPopup.show(
                      context: context,
                      title: 'Confirm action?',
                      confirmLabel: 'Yes',
                      cancelLabel: 'No',
                      onConfirm: () {},
                      onCancel: () => cancelCalled = true,
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

        await tester.tap(find.text('No'));
        await tester.pumpAndSettle();

        expect(cancelCalled, isTrue);
        expect(find.text('Confirm action?'), findsNothing);
      });

      testWidgets('barrier tap closes popup', (tester) async {
        await tester.pumpWidget(
          wrapWithNavigator(
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    ConfirmationPopup.show(
                      context: context,
                      title: 'Test',
                      confirmLabel: 'OK',
                      cancelLabel: 'Cancel',
                      onConfirm: () {},
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

        expect(find.text('Test'), findsOneWidget);

        // Tap on barrier (top-left corner, outside dialog)
        await tester.tapAt(const Offset(10, 10));
        await tester.pumpAndSettle();

        expect(find.text('Test'), findsNothing);
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
                    ConfirmationPopup.show(
                      context: context,
                      title: 'Delete item?',
                      confirmLabel: 'Delete',
                      cancelLabel: 'Cancel',
                      onConfirm: () {},
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
          find.bySemanticsLabel('Confirmation dialog: Delete item?'),
          findsOneWidget,
        );
      });
    });

    group('responsive padding', () {
      testWidgets('uses mobile padding on small screens', (tester) async {
        await tester.pumpWidget(
          wrapWithStylingAndSize(
            ConfirmationPopup(
              icon: null,
              title: 'Test',
              description: null,
              confirmLabel: 'OK',
              cancelLabel: 'Cancel',
              onConfirm: () {},
              onCancel: null,
              destructive: false,
            ),
            size: const Size(400, 800),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container).first);
        final padding = container.padding as EdgeInsets;

        expect(padding.left, 24);
        expect(padding.right, 24);
        expect(padding.top, 32);
        expect(padding.bottom, 24);
      });

      testWidgets('uses desktop padding on large screens', (tester) async {
        await tester.pumpWidget(
          wrapWithStylingAndSize(
            ConfirmationPopup(
              icon: null,
              title: 'Test',
              description: null,
              confirmLabel: 'OK',
              cancelLabel: 'Cancel',
              onConfirm: () {},
              onCancel: null,
              destructive: false,
            ),
            size: const Size(800, 600),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container).first);
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
            ConfirmationPopup(
              icon: null,
              title: 'Light mode',
              description: null,
              confirmLabel: 'OK',
              cancelLabel: 'Cancel',
              onConfirm: () {},
              onCancel: null,
              destructive: false,
            ),
            brightness: Brightness.light,
          ),
        );

        expect(find.text('Light mode'), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(
          wrapWithStyling(
            ConfirmationPopup(
              icon: null,
              title: 'Dark mode',
              description: null,
              confirmLabel: 'OK',
              cancelLabel: 'Cancel',
              onConfirm: () {},
              onCancel: null,
              destructive: false,
            ),
            brightness: Brightness.dark,
          ),
        );

        expect(find.text('Dark mode'), findsOneWidget);
      });
    });
  });
}
