import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/card_box.dart';

import 'test_helper.dart';

void main() {
  group('CardBox', () {
    group('rendering', () {
      testWidgets('renders child', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const CardBox(
            child: Text('Hello'),
          ),
        ));

        expect(find.text('Hello'), findsOneWidget);
      });

      testWidgets('renders bordered variant', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const CardBox(
            child: Text('Bordered'),
          ),
        ));

        final container =
            tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.border, isNotNull);
        expect(decoration.color, isNull);
      });

      testWidgets('renders filled variant', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const CardBox(
            variant: CardBoxVariant.filled,
            child: Text('Filled'),
          ),
        ));

        final container =
            tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, isNotNull);
        expect(decoration.border, isNull);
      });

      testWidgets('uses default padding', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const CardBox(
            child: Text('Default'),
          ),
        ));

        final container =
            tester.widget<Container>(find.byType(Container).first);
        expect(container.padding, const EdgeInsets.all(16));
      });

      testWidgets('uses custom padding', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const CardBox(
            padding: EdgeInsets.all(32),
            child: Text('Custom'),
          ),
        ));

        final container =
            tester.widget<Container>(find.byType(Container).first);
        expect(container.padding, const EdgeInsets.all(32));
      });
    });

    group('interaction', () {
      testWidgets('tap triggers onTap', (tester) async {
        bool tapped = false;

        await tester.pumpWidget(wrapWithStyling(
          CardBox(
            onTap: () => tapped = true,
            child: const Text('Tap me'),
          ),
        ));

        await tester.tap(find.byType(CardBox));
        await tester.pump();

        expect(tapped, isTrue);
      });

      testWidgets('shows click cursor when tappable', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          CardBox(
            onTap: () {},
            child: const Text('Clickable'),
          ),
        ));

        final mouseRegion = tester.widget<MouseRegion>(
          find.byType(MouseRegion).first,
        );
        expect(mouseRegion.cursor, SystemMouseCursors.click);
      });

      testWidgets('no MouseRegion when not tappable', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const CardBox(
            child: Text('Static'),
          ),
        ));

        expect(find.byType(MouseRegion), findsNothing);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const CardBox(
            child: Text('Light'),
          ),
          brightness: Brightness.light,
        ));

        expect(find.byType(CardBox), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const CardBox(
            child: Text('Dark'),
          ),
          brightness: Brightness.dark,
        ));

        expect(find.byType(CardBox), findsOneWidget);
      });
    });
  });
}
