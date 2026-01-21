import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/button.dart';
import 'package:example/widgets/spinner.dart';

import 'test_helper.dart';

void main() {
  group('Button', () {
    group('rendering', () {
      testWidgets('renders with label', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Button(label: 'Click me', onPressed: () {}),
        ));

        expect(find.text('Click me'), findsOneWidget);
      });

      testWidgets('renders all variants without error', (tester) async {
        for (final variant in ButtonVariant.values) {
          await tester.pumpWidget(wrapWithStyling(
            Button(
              label: 'Test',
              variant: variant,
              onPressed: () {},
            ),
          ));

          expect(find.text('Test'), findsOneWidget);
        }
      });

      testWidgets('renders small variant', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Button.small(label: 'Small', onPressed: () {}),
        ));

        expect(find.text('Small'), findsOneWidget);
      });

      testWidgets('renders with icon', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Button(
            label: 'With Icon',
            icon: const SizedBox(width: 20, height: 20),
            onPressed: () {},
          ),
        ));

        expect(find.text('With Icon'), findsOneWidget);
      });
    });

    group('loading state', () {
      testWidgets('shows spinner when loading', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Button(label: 'Loading', loading: true, onPressed: () {}),
        ));

        expect(find.byType(Spinner), findsOneWidget);
      });

      testWidgets('does not call onPressed when loading', (tester) async {
        var called = false;

        await tester.pumpWidget(wrapWithStyling(
          Button(
            label: 'Loading',
            loading: true,
            onPressed: () => called = true,
          ),
        ));

        await tester.tap(find.byType(Button));
        await tester.pump();

        expect(called, isFalse);
      });
    });

    group('disabled state', () {
      testWidgets('does not call onPressed when disabled', (tester) async {
        var called = false;

        await tester.pumpWidget(wrapWithStyling(
          Button(
            label: 'Disabled',
            onPressed: null,
          ),
        ));

        await tester.tap(find.byType(Button));
        await tester.pump();

        expect(called, isFalse);
      });

      testWidgets('has reduced opacity when disabled', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Button(label: 'Disabled', onPressed: null),
        ));

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 0.5);
      });

      testWidgets('has full opacity when enabled', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Button(label: 'Enabled', onPressed: () {}),
        ));

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 1.0);
      });
    });

    group('interaction', () {
      testWidgets('calls onPressed when tapped', (tester) async {
        var called = false;

        await tester.pumpWidget(wrapWithStyling(
          Button(
            label: 'Tap me',
            onPressed: () => called = true,
          ),
        ));

        await tester.tap(find.byType(Button));
        await tester.pump();

        expect(called, isTrue);
      });
    });

    group('accessibility', () {
      testWidgets('has correct semantics', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Button(label: 'Accessible', onPressed: () {}),
        ));

        final semantics = tester.getSemantics(find.byType(Button));
        expect(semantics.label, 'Accessible');
        expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue);
        expect(semantics.hasFlag(SemanticsFlag.isEnabled), isTrue);
      });

      testWidgets('semantics shows disabled when onPressed is null', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Button(label: 'Disabled', onPressed: null),
        ));

        final semantics = tester.getSemantics(find.byType(Button));
        expect(semantics.hasFlag(SemanticsFlag.isEnabled), isFalse);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Button(label: 'Light', onPressed: () {}),
          brightness: Brightness.light,
        ));

        expect(find.text('Light'), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Button(label: 'Dark', onPressed: () {}),
          brightness: Brightness.dark,
        ));

        expect(find.text('Dark'), findsOneWidget);
      });
    });
  });
}
