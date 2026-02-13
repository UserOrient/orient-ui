import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/toast.dart';

import 'test_helper.dart';

/// Wraps widget with Navigator for overlay support
Widget wrapWithNavigator(Widget child, {Brightness brightness = Brightness.light}) {
  return Styling(
    brightness: brightness,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: const MediaQueryData(),
        child: Navigator(
          onGenerateRoute: (_) => PageRouteBuilder(
            pageBuilder: (_, __, ___) => child,
          ),
        ),
      ),
    ),
  );
}

void main() {
  group('Toast', () {
    group('rendering', () {
      testWidgets('shows toast with message', (tester) async {
        await tester.pumpWidget(wrapWithNavigator(
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Toast.show(context: context, message: 'Test message'),
              child: const Text('Trigger'),
            ),
          ),
        ));

        await tester.tap(find.text('Trigger'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.text('Test message'), findsOneWidget);

        // Dismiss and wait for cleanup
        Toast.dismissAll();
        await tester.pumpAndSettle();
      });

      testWidgets('renders all toast types', (tester) async {
        await tester.pumpWidget(wrapWithNavigator(
          Builder(
            builder: (context) => Column(
              children: [
                GestureDetector(
                  key: const Key('success'),
                  onTap: () => Toast.show(context: context, message: 'S', type: ToastType.success),
                  child: const Text('Success'),
                ),
                GestureDetector(
                  key: const Key('error'),
                  onTap: () => Toast.show(context: context, message: 'E', type: ToastType.error),
                  child: const Text('Error'),
                ),
                GestureDetector(
                  key: const Key('info'),
                  onTap: () => Toast.show(context: context, message: 'I', type: ToastType.info),
                  child: const Text('Info'),
                ),
                GestureDetector(
                  key: const Key('warning'),
                  onTap: () => Toast.show(context: context, message: 'W', type: ToastType.warning),
                  child: const Text('Warning'),
                ),
              ],
            ),
          ),
        ));

        // Test success
        await tester.tap(find.byKey(const Key('success')));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));
        expect(find.text('S'), findsOneWidget);
        Toast.dismissAll();
        await tester.pumpAndSettle();

        // Test error
        await tester.tap(find.byKey(const Key('error')));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));
        expect(find.text('E'), findsOneWidget);
        Toast.dismissAll();
        await tester.pumpAndSettle();

        // Test info
        await tester.tap(find.byKey(const Key('info')));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));
        expect(find.text('I'), findsOneWidget);
        Toast.dismissAll();
        await tester.pumpAndSettle();

        // Test warning
        await tester.tap(find.byKey(const Key('warning')));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));
        expect(find.text('W'), findsOneWidget);
        Toast.dismissAll();
        await tester.pumpAndSettle();
      });

      testWidgets('renders at top position', (tester) async {
        await tester.pumpWidget(wrapWithNavigator(
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Toast.show(
                context: context,
                message: 'Top',
                position: ToastPosition.top,
              ),
              child: const Text('Trigger'),
            ),
          ),
        ));

        await tester.tap(find.text('Trigger'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.text('Top'), findsOneWidget);

        Toast.dismissAll();
        await tester.pumpAndSettle();
      });

      testWidgets('renders at bottom position', (tester) async {
        await tester.pumpWidget(wrapWithNavigator(
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Toast.show(
                context: context,
                message: 'Bottom',
                position: ToastPosition.bottom,
              ),
              child: const Text('Trigger'),
            ),
          ),
        ));

        await tester.tap(find.text('Trigger'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.text('Bottom'), findsOneWidget);

        Toast.dismissAll();
        await tester.pumpAndSettle();
      });

      testWidgets('renders icon', (tester) async {
        await tester.pumpWidget(wrapWithNavigator(
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Toast.show(context: context, message: 'With icon'),
              child: const Text('Trigger'),
            ),
          ),
        ));

        await tester.tap(find.text('Trigger'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));

        // CustomPaint is used for icons
        expect(find.byType(CustomPaint), findsWidgets);

        Toast.dismissAll();
        await tester.pumpAndSettle();
      });
    });

    group('stacking', () {
      testWidgets('shows multiple toasts', (tester) async {
        await tester.pumpWidget(wrapWithNavigator(
          Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Toast.show(context: context, message: 'First');
                Toast.show(context: context, message: 'Second');
                Toast.show(context: context, message: 'Third');
              },
              child: const Text('Trigger'),
            ),
          ),
        ));

        await tester.tap(find.text('Trigger'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.text('First'), findsOneWidget);
        expect(find.text('Second'), findsOneWidget);
        expect(find.text('Third'), findsOneWidget);

        Toast.dismissAll();
        await tester.pumpAndSettle();
      });
    });

    group('dismissal', () {
      testWidgets('dismissAllToasts removes all toasts', (tester) async {
        await tester.pumpWidget(wrapWithNavigator(
          Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Toast.show(context: context, message: 'Toast 1');
                Toast.show(context: context, message: 'Toast 2');
              },
              child: const Text('Show'),
            ),
          ),
        ));

        await tester.tap(find.text('Show'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.text('Toast 1'), findsOneWidget);
        expect(find.text('Toast 2'), findsOneWidget);

        Toast.dismissAll();
        await tester.pump();

        expect(find.text('Toast 1'), findsNothing);
        expect(find.text('Toast 2'), findsNothing);
      });

      testWidgets('swipe dismisses toast', (tester) async {
        await tester.pumpWidget(wrapWithNavigator(
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Toast.show(
                context: context,
                message: 'Swipe me',
                position: ToastPosition.top,
              ),
              child: const Text('Trigger'),
            ),
          ),
        ));

        await tester.tap(find.text('Trigger'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.text('Swipe me'), findsOneWidget);

        await tester.fling(find.text('Swipe me'), const Offset(0, -200), 1000);
        await tester.pumpAndSettle();

        expect(find.text('Swipe me'), findsNothing);
      });
    });

    group('accessibility', () {
      testWidgets('has semantics label with type and message', (tester) async {
        await tester.pumpWidget(wrapWithNavigator(
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Toast.show(
                context: context,
                message: 'Accessible',
                type: ToastType.error,
              ),
              child: const Text('Trigger'),
            ),
          ),
        ));

        await tester.tap(find.text('Trigger'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));

        final semanticsFinder = find.bySemanticsLabel(RegExp(r'error.*Accessible'));
        expect(semanticsFinder, findsOneWidget);

        Toast.dismissAll();
        await tester.pumpAndSettle();
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithNavigator(
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Toast.show(context: context, message: 'Light'),
              child: const Text('Trigger'),
            ),
          ),
          brightness: Brightness.light,
        ));

        await tester.tap(find.text('Trigger'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.text('Light'), findsOneWidget);

        Toast.dismissAll();
        await tester.pumpAndSettle();
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithNavigator(
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Toast.show(context: context, message: 'Dark'),
              child: const Text('Trigger'),
            ),
          ),
          brightness: Brightness.dark,
        ));

        await tester.tap(find.text('Trigger'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));

        expect(find.text('Dark'), findsOneWidget);

        Toast.dismissAll();
        await tester.pumpAndSettle();
      });
    });

    group('animation', () {
      testWidgets('uses fade and slide transitions', (tester) async {
        await tester.pumpWidget(wrapWithNavigator(
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Toast.show(context: context, message: 'Animated'),
              child: const Text('Trigger'),
            ),
          ),
        ));

        await tester.tap(find.text('Trigger'));
        await tester.pump();

        // Check transitions exist
        expect(find.byType(FadeTransition), findsWidgets);
        expect(find.byType(SlideTransition), findsWidgets);

        await tester.pump(const Duration(milliseconds: 350));
        expect(find.text('Animated'), findsOneWidget);

        Toast.dismissAll();
        await tester.pumpAndSettle();
      });
    });
  });
}
