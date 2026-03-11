import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/multi_choice.dart';
import 'package:example/widgets/multi_choice_tile.dart';
import 'package:example/widgets/tile.dart';

import 'test_helper.dart';

void main() {
  group('MultiChoiceTile', () {
    group('rendering', () {
      testWidgets('renders title', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Email',
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.text('Email'), findsOneWidget);
      });

      testWidgets('renders subtitle', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Email',
            subtitle: 'Receive via email',
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.text('Receive via email'), findsOneWidget);
      });

      testWidgets('renders without subtitle', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Email',
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.text('Email'), findsOneWidget);
        expect(find.text('Receive via email'), findsNothing);
      });

      testWidgets('renders MultiChoice widget', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Email',
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.byType(MultiChoice), findsOneWidget);
      });

      testWidgets('composes Tile internally', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.byType(Tile), findsOneWidget);
      });

      testWidgets('renders with leading widget', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            leading: const Text('L'),
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.text('L'), findsOneWidget);
      });
    });

    group('variants', () {
      testWidgets('simple has no border or fill', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
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
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            variant: TileVariant.bordered,
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
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            variant: TileVariant.filled,
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
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            variant: TileVariant.filled,
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

        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Test',
            value: false,
            onChanged: (v) => received = v,
          ),
        ));

        await tester.tap(find.byType(MultiChoiceTile));
        await tester.pump();

        expect(received, true);
      });

      testWidgets('tap toggles from checked to unchecked', (tester) async {
        bool? received;

        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Test',
            value: true,
            onChanged: (v) => received = v,
          ),
        ));

        await tester.tap(find.text('Test'));
        await tester.pump();

        expect(received, false);
      });

      testWidgets('tap on choice area toggles', (tester) async {
        bool? received;

        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Test',
            value: false,
            onChanged: (v) => received = v,
          ),
        ));

        await tester.tap(find.byType(MultiChoice));
        await tester.pump();

        expect(received, true);
      });

      testWidgets('disabled tile does not fire onChanged', (tester) async {
        bool called = false;

        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Test',
            value: false,
            onChanged: null,
          ),
        ));

        await tester.tap(find.byType(MultiChoiceTile));
        await tester.pump();

        expect(called, isFalse);
      });

      testWidgets('hover shows click cursor when enabled', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
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

      testWidgets('hover shows basic cursor when disabled', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Test',
            value: false,
            onChanged: null,
          ),
        ));

        final mouseRegion = tester.widget<MouseRegion>(
          find.byType(MouseRegion).first,
        );
        expect(mouseRegion.cursor, SystemMouseCursors.basic);
      });
    });

    group('subtitle', () {
      testWidgets('supports max 2 lines with ellipsis', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
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
    });

    group('accessibility', () {
      testWidgets('has checked semantics when checked', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Test',
            value: true,
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(MultiChoiceTile));
        expect(semantics.flagsCollection.isChecked, CheckedState.isTrue);
      });

      testWidgets('does not have checked semantics when unchecked', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(MultiChoiceTile));
        expect(semantics.flagsCollection.isChecked, CheckedState.isFalse);
      });

      testWidgets('has title as semantics label', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Email',
            value: false,
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(MultiChoiceTile));
        expect(semantics.label, 'Email');
      });

      testWidgets('has enabled semantics when interactive', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Test',
            value: false,
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(MultiChoiceTile));
        expect(semantics.flagsCollection.isEnabled, Tristate.isTrue);
      });

      testWidgets('has disabled semantics when non-interactive', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Test',
            value: false,
            onChanged: null,
          ),
        ));

        final semantics = tester.getSemantics(find.byType(MultiChoiceTile));
        expect(semantics.flagsCollection.isEnabled, Tristate.isFalse);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Test',
            value: true,
            onChanged: (v) {},
          ),
          brightness: Brightness.light,
        ));

        expect(find.byType(MultiChoiceTile), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoiceTile(
            title: 'Test',
            value: true,
            onChanged: (v) {},
          ),
          brightness: Brightness.dark,
        ));

        expect(find.byType(MultiChoiceTile), findsOneWidget);
      });
    });
  });
}
