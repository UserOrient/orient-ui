import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/single_choice.dart';
import 'package:example/widgets/single_choice_tile.dart';
import 'package:example/widgets/tile.dart';

import 'test_helper.dart';

void main() {
  group('SingleChoiceTile', () {
    group('rendering', () {
      testWidgets('renders title', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Email',
            value: 'email',
            groupValue: 'sms',
            onChanged: (v) {},
          ),
        ));

        expect(find.text('Email'), findsOneWidget);
      });

      testWidgets('renders subtitle', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Email',
            subtitle: 'Receive via email',
            value: 'email',
            groupValue: 'sms',
            onChanged: (v) {},
          ),
        ));

        expect(find.text('Receive via email'), findsOneWidget);
      });

      testWidgets('renders without subtitle', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Email',
            value: 'email',
            groupValue: 'sms',
            onChanged: (v) {},
          ),
        ));

        expect(find.text('Email'), findsOneWidget);
        expect(find.text('Receive via email'), findsNothing);
      });

      testWidgets('renders SingleChoice widget', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Email',
            value: 'email',
            groupValue: 'sms',
            onChanged: (v) {},
          ),
        ));

        expect(find.byType(SingleChoice<String>), findsOneWidget);
      });

      testWidgets('composes Tile internally', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Test',
            value: 'a',
            groupValue: 'b',
            onChanged: (v) {},
          ),
        ));

        expect(find.byType(Tile), findsOneWidget);
      });

      testWidgets('renders with leading widget', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            leading: const Text('L'),
            title: 'Test',
            value: 'a',
            groupValue: 'b',
            onChanged: (v) {},
          ),
        ));

        expect(find.text('L'), findsOneWidget);
      });
    });

    group('variants', () {
      testWidgets('simple has no border or fill', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Test',
            value: 'a',
            groupValue: 'b',
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
          SingleChoiceTile<String>(
            variant: TileVariant.bordered,
            title: 'Test',
            value: 'a',
            groupValue: 'b',
            onChanged: (v) {},
          ),
        ));

        final container = tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.border, isNotNull);
      });

      testWidgets('filled has surfaceContainer color', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            variant: TileVariant.filled,
            title: 'Test',
            value: 'a',
            groupValue: 'b',
            onChanged: (v) {},
          ),
        ));

        final container = tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, const Color(0xFFFAFAFA));
      });

      testWidgets('filled dark mode uses dark surfaceContainer', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            variant: TileVariant.filled,
            title: 'Test',
            value: 'a',
            groupValue: 'b',
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
      testWidgets('tap selects unselected choice', (tester) async {
        String? received;

        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Test',
            value: 'a',
            groupValue: 'b',
            onChanged: (v) => received = v,
          ),
        ));

        await tester.tap(find.byType(SingleChoiceTile<String>));
        await tester.pump();

        expect(received, 'a');
      });

      testWidgets('tap on text area selects', (tester) async {
        String? received;

        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Test',
            subtitle: 'A subtitle',
            value: 'a',
            groupValue: 'b',
            onChanged: (v) => received = v,
          ),
        ));

        await tester.tap(find.text('Test'));
        await tester.pump();

        expect(received, 'a');
      });

      testWidgets('tap on choice area selects', (tester) async {
        String? received;

        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Test',
            value: 'a',
            groupValue: 'b',
            onChanged: (v) => received = v,
          ),
        ));

        await tester.tap(find.byType(SingleChoice<String>));
        await tester.pump();

        expect(received, 'a');
      });

      testWidgets('tap does nothing when already selected', (tester) async {
        bool called = false;

        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Test',
            value: 'a',
            groupValue: 'a',
            onChanged: (v) => called = true,
          ),
        ));

        // Tap the SingleChoice widget directly (tile onTap is null when selected)
        await tester.tap(find.byType(SingleChoice<String>));
        await tester.pump();

        expect(called, isFalse);
      });

      testWidgets('disabled tile does not fire onChanged', (tester) async {
        bool called = false;

        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Test',
            value: 'a',
            groupValue: 'b',
            onChanged: null,
          ),
        ));

        await tester.tap(find.byType(SingleChoiceTile<String>));
        await tester.pump();

        expect(called, isFalse);
      });

      testWidgets('hover shows click cursor when enabled and unselected', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Test',
            value: 'a',
            groupValue: 'b',
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
          SingleChoiceTile<String>(
            title: 'Test',
            value: 'a',
            groupValue: 'b',
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
          SingleChoiceTile<String>(
            title: 'Test',
            subtitle: 'This is a very long subtitle that should wrap to '
                'multiple lines and eventually get truncated with an '
                'ellipsis when it exceeds the maximum of two lines',
            value: 'a',
            groupValue: 'b',
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
      testWidgets('has checked semantics when selected', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Test',
            value: 'a',
            groupValue: 'a',
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(SingleChoiceTile<String>));
        expect(semantics.hasFlag(SemanticsFlag.isChecked), isTrue);
      });

      testWidgets('does not have checked semantics when unselected', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Test',
            value: 'a',
            groupValue: 'b',
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(SingleChoiceTile<String>));
        expect(semantics.hasFlag(SemanticsFlag.isChecked), isFalse);
      });

      testWidgets('has title as semantics label', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Email',
            value: 'email',
            groupValue: 'sms',
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(SingleChoiceTile<String>));
        expect(semantics.label, 'Email');
      });

      testWidgets('has enabled semantics when interactive', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Test',
            value: 'a',
            groupValue: 'b',
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(SingleChoiceTile<String>));
        expect(semantics.hasFlag(SemanticsFlag.hasEnabledState), isTrue);
        expect(semantics.hasFlag(SemanticsFlag.isEnabled), isTrue);
      });

      testWidgets('has disabled semantics when non-interactive', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Test',
            value: 'a',
            groupValue: 'b',
            onChanged: null,
          ),
        ));

        final semantics = tester.getSemantics(find.byType(SingleChoiceTile<String>));
        expect(semantics.hasFlag(SemanticsFlag.hasEnabledState), isTrue);
        expect(semantics.hasFlag(SemanticsFlag.isEnabled), isFalse);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Test',
            value: 'a',
            groupValue: 'a',
            onChanged: (v) {},
          ),
          brightness: Brightness.light,
        ));

        expect(find.byType(SingleChoiceTile<String>), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoiceTile<String>(
            title: 'Test',
            value: 'a',
            groupValue: 'a',
            onChanged: (v) {},
          ),
          brightness: Brightness.dark,
        ));

        expect(find.byType(SingleChoiceTile<String>), findsOneWidget);
      });
    });
  });
}
