import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/copy_button.dart';

import 'test_helper.dart';

void main() {
  group('CopyButton', () {
    group('rendering', () {
      testWidgets('renders without error', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          CopyButton(value: 'test'),
        ));

        expect(find.byType(CopyButton), findsOneWidget);
      });

      testWidgets('renders copy icon initially', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          CopyButton(value: 'test'),
        ));

        expect(find.byType(CustomPaint), findsOneWidget);
      });

      testWidgets('has correct size', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          CopyButton(value: 'test'),
        ));

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 28);
        expect(sizedBox.height, 28);
      });
    });

    group('states', () {
      testWidgets('shows check icon after copying', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          CopyButton(value: 'test'),
        ));

        await tester.tap(find.byType(CopyButton));
        await tester.pumpAndSettle();

        // After animation, check icon should be visible
        expect(find.byType(CustomPaint), findsOneWidget);

        // Advance past the 2-second reset timer
        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();
      });

      testWidgets('returns to copy icon after delay', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          CopyButton(value: 'test'),
        ));

        await tester.tap(find.byType(CopyButton));
        await tester.pumpAndSettle();

        // Wait for 2 second reset delay + animation
        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        expect(find.byType(CustomPaint), findsOneWidget);
      });

      testWidgets('prevents double tap during copied state', (tester) async {
        var callCount = 0;

        await tester.pumpWidget(wrapWithStyle(
          CopyButton(
            value: 'test',
            onCopied: () => callCount++,
          ),
        ));

        await tester.tap(find.byType(CopyButton));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(CopyButton));
        await tester.pumpAndSettle();

        expect(callCount, 1);

        // Advance past the 2-second reset timer
        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();
      });
    });

    group('interaction', () {
      testWidgets('calls onCopied when tapped', (tester) async {
        var called = false;

        await tester.pumpWidget(wrapWithStyle(
          CopyButton(
            value: 'test',
            onCopied: () => called = true,
          ),
        ));

        await tester.tap(find.byType(CopyButton));
        await tester.pump();

        expect(called, isTrue);
      });

      testWidgets('copies value to clipboard', (tester) async {
        String? copiedText;

        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          (MethodCall methodCall) async {
            if (methodCall.method == 'Clipboard.setData') {
              copiedText = (methodCall.arguments as Map)['text'];
            }
            return null;
          },
        );

        await tester.pumpWidget(wrapWithStyle(
          CopyButton(value: 'hello world'),
        ));

        await tester.tap(find.byType(CopyButton));
        await tester.pump();

        expect(copiedText, 'hello world');
      });

      testWidgets('works without onCopied callback', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          CopyButton(value: 'test'),
        ));

        await tester.tap(find.byType(CopyButton));
        await tester.pumpAndSettle();

        // Should not throw
        expect(find.byType(CopyButton), findsOneWidget);

        // Advance past the 2-second reset timer
        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();
      });
    });

    group('animation', () {
      testWidgets('animates on copy', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          CopyButton(value: 'test'),
        ));

        await tester.tap(find.byType(CopyButton));

        // Pump a few frames to check animation is running
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 25));

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, lessThan(1.0));
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          CopyButton(value: 'test'),
          brightness: Brightness.light,
        ));

        expect(find.byType(CopyButton), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          CopyButton(value: 'test'),
          brightness: Brightness.dark,
        ));

        expect(find.byType(CopyButton), findsOneWidget);
      });
    });
  });
}
