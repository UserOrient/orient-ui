import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/tappable_icon.dart';

import 'test_helper.dart';

void main() {
  group('TappableIcon', () {
    group('rendering', () {
      testWidgets('renders with icon', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          TappableIcon(
            icon: const Icon(IconData(0xe3af)),
            onPressed: () {},
          ),
        ));

        expect(find.byType(TappableIcon), findsOneWidget);
      });

      testWidgets('has default size of 40', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          TappableIcon(
            icon: const Icon(IconData(0xe3af)),
            onPressed: () {},
          ),
        ));

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.constraints?.maxWidth, 40.0);
        expect(container.constraints?.maxHeight, 40.0);
      });

      testWidgets('respects custom size', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          TappableIcon(
            icon: const Icon(IconData(0xe3af)),
            onPressed: () {},
            size: 56,
          ),
        ));

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.constraints?.maxWidth, 56.0);
        expect(container.constraints?.maxHeight, 56.0);
      });
    });

    group('disabled state', () {
      testWidgets('does not call onPressed when disabled', (tester) async {
        var called = false;

        await tester.pumpWidget(wrapWithStyle(
          const TappableIcon(
            icon: Icon(IconData(0xe3af)),
            onPressed: null,
          ),
        ));

        await tester.tap(find.byType(TappableIcon));
        await tester.pump();

        expect(called, isFalse);
      });

      testWidgets('has reduced opacity when disabled', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          const TappableIcon(
            icon: Icon(IconData(0xe3af)),
            onPressed: null,
          ),
        ));

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 0.5);
      });

      testWidgets('has full opacity when enabled', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          TappableIcon(
            icon: const Icon(IconData(0xe3af)),
            onPressed: () {},
          ),
        ));

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 1.0);
      });
    });

    group('interaction', () {
      testWidgets('calls onPressed when tapped', (tester) async {
        var called = false;

        await tester.pumpWidget(wrapWithStyle(
          TappableIcon(
            icon: const Icon(IconData(0xe3af)),
            onPressed: () => called = true,
          ),
        ));

        await tester.tap(find.byType(TappableIcon));
        await tester.pump();

        expect(called, isTrue);
      });
    });

    group('accessibility', () {
      testWidgets('has correct semantics', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          TappableIcon(
            icon: const Icon(IconData(0xe3af)),
            onPressed: () {},
            tooltip: 'Like',
          ),
        ));

        final semantics = tester.getSemantics(find.byType(TappableIcon));
        expect(semantics.label, 'Like');
        expect(semantics.flagsCollection.isButton, isTrue);
        expect(semantics.flagsCollection.isEnabled, Tristate.isTrue);
      });

      testWidgets('semantics shows disabled when onPressed is null', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          const TappableIcon(
            icon: Icon(IconData(0xe3af)),
            onPressed: null,
            tooltip: 'Locked',
          ),
        ));

        final semantics = tester.getSemantics(find.byType(TappableIcon));
        expect(semantics.flagsCollection.isEnabled, Tristate.isFalse);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          TappableIcon(
            icon: const Icon(IconData(0xe3af)),
            onPressed: () {},
          ),
          brightness: Brightness.light,
        ));

        expect(find.byType(TappableIcon), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          TappableIcon(
            icon: const Icon(IconData(0xe3af)),
            onPressed: () {},
          ),
          brightness: Brightness.dark,
        ));

        expect(find.byType(TappableIcon), findsOneWidget);
      });
    });
  });
}
