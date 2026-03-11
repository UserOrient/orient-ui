import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/single_choice.dart';

import 'test_helper.dart';

void main() {
  group('SingleChoice', () {
    group('rendering', () {
      testWidgets('renders without error', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoice<String>(
            value: 'a',
            groupValue: 'b',
            onChanged: (v) {},
          ),
        ));

        expect(find.byType(SingleChoice<String>), findsOneWidget);
      });

      testWidgets('renders in selected state', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoice<String>(
            value: 'a',
            groupValue: 'a',
            onChanged: (v) {},
          ),
        ));

        expect(find.byType(SingleChoice<String>), findsOneWidget);
      });
    });

    group('states', () {
      testWidgets('has reduced opacity when disabled', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          const SingleChoice<String>(
            value: 'a',
            groupValue: 'b',
          ),
        ));

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 0.5);
      });

      testWidgets('has full opacity when enabled', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoice<String>(
            value: 'a',
            groupValue: 'b',
            onChanged: (v) {},
          ),
        ));

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 1.0);
      });

      testWidgets('switches state immediately on tap', (tester) async {
        String groupValue = 'b';

        await tester.pumpWidget(wrapWithStyle(
          StatefulBuilder(
            builder: (context, setState) {
              return SingleChoice<String>(
                value: 'a',
                groupValue: groupValue,
                onChanged: (v) => setState(() => groupValue = v),
              );
            },
          ),
        ));

        await tester.tap(find.byType(SingleChoice<String>));
        await tester.pump();
        expect(groupValue, 'a');
      });
    });

    group('interaction', () {
      testWidgets('calls onChanged with value on tap', (tester) async {
        String? received;

        await tester.pumpWidget(wrapWithStyle(
          SingleChoice<String>(
            value: 'apple',
            groupValue: 'banana',
            onChanged: (v) => received = v,
          ),
        ));

        await tester.tap(find.byType(SingleChoice<String>));
        await tester.pump();

        expect(received, 'apple');
      });

      testWidgets('does not call onChanged when already selected', (tester) async {
        bool called = false;

        await tester.pumpWidget(wrapWithStyle(
          SingleChoice<String>(
            value: 'a',
            groupValue: 'a',
            onChanged: (v) => called = true,
          ),
        ));

        await tester.tap(find.byType(SingleChoice<String>));
        await tester.pump();

        expect(called, isFalse);
      });

      testWidgets('does not call onChanged when disabled', (tester) async {
        bool called = false;

        await tester.pumpWidget(wrapWithStyle(
          const SingleChoice<String>(
            value: 'a',
            groupValue: 'b',
          ),
        ));

        await tester.tap(find.byType(SingleChoice<String>));
        await tester.pump();

        expect(called, isFalse);
      });

      testWidgets('space key selects when focused', (tester) async {
        String? received;

        await tester.pumpWidget(wrapWithStyle(
          SingleChoice<String>(
            value: 'a',
            groupValue: 'b',
            onChanged: (v) => received = v,
          ),
        ));

        // Focus the widget
        final focus = find.byType(Focus).last;
        await tester.tap(focus);
        await tester.pump();

        await tester.sendKeyEvent(LogicalKeyboardKey.space);
        await tester.pump();

        expect(received, 'a');
      });

      testWidgets('space key does nothing when already selected', (tester) async {
        bool called = false;

        await tester.pumpWidget(wrapWithStyle(
          SingleChoice<String>(
            value: 'a',
            groupValue: 'a',
            onChanged: (v) => called = true,
          ),
        ));

        final focus = find.byType(Focus).last;
        await tester.tap(focus);
        await tester.pump();

        await tester.sendKeyEvent(LogicalKeyboardKey.space);
        await tester.pump();

        expect(called, isFalse);
      });
    });

    group('accessibility', () {
      testWidgets('has checked semantics when selected', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoice<String>(
            value: 'a',
            groupValue: 'a',
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(SingleChoice<String>));
        expect(semantics.flagsCollection.isChecked, CheckedState.isTrue);
      });

      testWidgets('does not have checked semantics when unselected', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoice<String>(
            value: 'a',
            groupValue: 'b',
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(SingleChoice<String>));
        expect(semantics.flagsCollection.isChecked, CheckedState.isFalse);
      });

      testWidgets('has enabled semantics when interactive', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoice<String>(
            value: 'a',
            groupValue: 'b',
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(SingleChoice<String>));
        expect(semantics.flagsCollection.isEnabled, Tristate.isTrue);
      });

      testWidgets('has disabled semantics when not interactive', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          const SingleChoice<String>(
            value: 'a',
            groupValue: 'b',
          ),
        ));

        final semantics = tester.getSemantics(find.byType(SingleChoice<String>));
        expect(semantics.flagsCollection.isEnabled, Tristate.isFalse);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoice<String>(
            value: 'a',
            groupValue: 'a',
            onChanged: (v) {},
          ),
          brightness: Brightness.light,
        ));

        expect(find.byType(SingleChoice<String>), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SingleChoice<String>(
            value: 'a',
            groupValue: 'a',
            onChanged: (v) {},
          ),
          brightness: Brightness.dark,
        ));

        expect(find.byType(SingleChoice<String>), findsOneWidget);
      });
    });
  });
}
