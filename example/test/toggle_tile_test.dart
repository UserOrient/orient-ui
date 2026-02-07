import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/toggle.dart';
import 'package:example/widgets/toggle_tile.dart';

import 'test_helper.dart';

void main() {
  group('ToggleTile', () {
    group('rendering', () {
      testWidgets('renders title', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Notifications',
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.text('Notifications'), findsOneWidget);
      });

      testWidgets('renders subtitle', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Notifications',
            subtitle: 'Receive push notifications',
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.text('Receive push notifications'), findsOneWidget);
      });

      testWidgets('renders without subtitle', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Notifications',
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.text('Notifications'), findsOneWidget);
        expect(find.text('Receive push notifications'), findsNothing);
      });

      testWidgets('renders Toggle widget', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Notifications',
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.byType(Toggle), findsOneWidget);
      });

      testWidgets('renders simple variant', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.byType(ToggleTile), findsOneWidget);
      });

      testWidgets('renders bordered variant', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            variant: ToggleTileVariant.bordered,
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.byType(ToggleTile), findsOneWidget);
      });

      testWidgets('renders filled variant', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            variant: ToggleTileVariant.filled,
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.byType(ToggleTile), findsOneWidget);
      });

      testWidgets('renders with leading widget', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            leading: const Text('L'),
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.text('L'), findsOneWidget);
      });

      testWidgets('renders without leading widget', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
        ));

        // No leading, no 12px gap SizedBox before text
        expect(find.text('Test'), findsOneWidget);
      });
    });

    group('variants', () {
      testWidgets('simple has no border or fill', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
        ));

        final container = tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.border, isNull);
        expect(decoration.color, isNull);
      });

      testWidgets('bordered has border', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            variant: ToggleTileVariant.bordered,
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
        ));

        final container = tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.border, isNotNull);
      });

      testWidgets('filled has surfaceContainer color', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            variant: ToggleTileVariant.filled,
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
        ));

        final container = tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, const Color(0xFFFAFAFA));
      });

      testWidgets('filled dark mode uses dark surfaceContainer', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            variant: ToggleTileVariant.filled,
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
          brightness: Brightness.dark,
        ));

        final container = tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, const Color(0xFF121212));
      });
    });

    group('interaction', () {
      testWidgets('tap toggles value', (tester) async {
        bool? received;

        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Test',
            value: false,
            onChanged: (v) => received = v,
          ),
        ));

        await tester.tap(find.byType(ToggleTile));
        await tester.pump();

        expect(received, isTrue);
      });

      testWidgets('tap on text area toggles', (tester) async {
        bool? received;

        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Test',
            subtitle: 'A subtitle',
            value: false,
            onChanged: (v) => received = v,
          ),
        ));

        await tester.tap(find.text('Test'));
        await tester.pump();

        expect(received, isTrue);
      });

      testWidgets('tap on toggle area toggles', (tester) async {
        bool? received;

        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Test',
            value: false,
            onChanged: (v) => received = v,
          ),
        ));

        await tester.tap(find.byType(Toggle));
        await tester.pump();

        expect(received, isTrue);
      });

      testWidgets('callback receives correct value when toggling off', (tester) async {
        bool? received;

        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Test',
            value: true,
            onChanged: (v) => received = v,
          ),
        ));

        await tester.tap(find.byType(ToggleTile));
        await tester.pump();

        expect(received, isFalse);
      });

      testWidgets('hover shows click cursor', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
        ));

        final mouseRegion = tester.widget<MouseRegion>(
          find.byType(MouseRegion).first,
        );
        expect(mouseRegion.cursor, SystemMouseCursors.click);
      });
    });

    group('subtitle', () {
      testWidgets('supports max 2 lines with ellipsis', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Test',
            subtitle: 'This is a very long subtitle that should wrap to '
                'multiple lines and eventually get truncated with an '
                'ellipsis when it exceeds the maximum of two lines',
            value: false,
            onChanged: (v) {},
          ),
        ));

        final subtitleWidget = tester.widget<Text>(find.text(
          'This is a very long subtitle that should wrap to '
          'multiple lines and eventually get truncated with an '
          'ellipsis when it exceeds the maximum of two lines',
        ));
        expect(subtitleWidget.maxLines, 2);
        expect(subtitleWidget.overflow, TextOverflow.ellipsis);
      });

      testWidgets('renders single line subtitle', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Test',
            subtitle: 'Short',
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.text('Short'), findsOneWidget);
      });
    });

    group('accessibility', () {
      testWidgets('has toggled semantics when on', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Test',
            value: true,
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(ToggleTile));
        expect(semantics.hasFlag(SemanticsFlag.isToggled), isTrue);
      });

      testWidgets('does not have toggled semantics when off', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(ToggleTile));
        expect(semantics.hasFlag(SemanticsFlag.isToggled), isFalse);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Test',
            value: true,
            onChanged: (v) {},
          ),
          brightness: Brightness.light,
        ));

        expect(find.byType(ToggleTile), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            title: 'Test',
            value: true,
            onChanged: (v) {},
          ),
          brightness: Brightness.dark,
        ));

        expect(find.byType(ToggleTile), findsOneWidget);
      });

      testWidgets('filled uses surfaceContainer color', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          ToggleTile(
            variant: ToggleTileVariant.filled,
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
        ));

        final container = tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, isNotNull);
      });
    });
  });
}
