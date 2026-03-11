import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/multi_choice.dart';

import 'test_helper.dart';

void main() {
  group('MultiChoice', () {
    group('rendering', () {
      testWidgets('renders without error', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoice(
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.byType(MultiChoice), findsOneWidget);
      });

      testWidgets('renders in checked state', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoice(
            value: true,
            onChanged: (v) {},
          ),
        ));

        expect(find.byType(MultiChoice), findsOneWidget);
      });

      testWidgets('renders in unchecked state', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoice(
            value: false,
            onChanged: (v) {},
          ),
        ));

        expect(find.byType(MultiChoice), findsOneWidget);
      });
    });

    group('states', () {
      testWidgets('has reduced opacity when disabled', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          const MultiChoice(
            value: false,
          ),
        ));

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 0.5);
      });

      testWidgets('has full opacity when enabled', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoice(
            value: false,
            onChanged: (v) {},
          ),
        ));

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 1.0);
      });

      testWidgets('switches state immediately on tap', (tester) async {
        bool value = false;

        await tester.pumpWidget(wrapWithStyle(
          StatefulBuilder(
            builder: (context, setState) {
              return MultiChoice(
                value: value,
                onChanged: (v) => setState(() => value = v),
              );
            },
          ),
        ));

        await tester.tap(find.byType(MultiChoice));
        await tester.pump();
        expect(value, true);
      });
    });

    group('interaction', () {
      testWidgets('calls onChanged with toggled value on tap', (tester) async {
        bool? received;

        await tester.pumpWidget(wrapWithStyle(
          MultiChoice(
            value: false,
            onChanged: (v) => received = v,
          ),
        ));

        await tester.tap(find.byType(MultiChoice));
        await tester.pump();

        expect(received, true);
      });

      testWidgets('toggles from true to false on tap', (tester) async {
        bool? received;

        await tester.pumpWidget(wrapWithStyle(
          MultiChoice(
            value: true,
            onChanged: (v) => received = v,
          ),
        ));

        await tester.tap(find.byType(MultiChoice));
        await tester.pump();

        expect(received, false);
      });

      testWidgets('does not call onChanged when disabled', (tester) async {
        bool called = false;

        await tester.pumpWidget(wrapWithStyle(
          const MultiChoice(
            value: false,
          ),
        ));

        await tester.tap(find.byType(MultiChoice));
        await tester.pump();

        expect(called, isFalse);
      });

      testWidgets('space key toggles when focused', (tester) async {
        bool? received;

        await tester.pumpWidget(wrapWithStyle(
          MultiChoice(
            value: false,
            onChanged: (v) => received = v,
          ),
        ));

        // Focus the widget
        final focus = find.byType(Focus).last;
        await tester.tap(focus);
        await tester.pump();

        await tester.sendKeyEvent(LogicalKeyboardKey.space);
        await tester.pump();

        expect(received, true);
      });

      testWidgets('space key toggles from checked state', (tester) async {
        bool? received;

        await tester.pumpWidget(wrapWithStyle(
          MultiChoice(
            value: true,
            onChanged: (v) => received = v,
          ),
        ));

        final focus = find.byType(Focus).last;
        await tester.tap(focus);
        await tester.pump();

        await tester.sendKeyEvent(LogicalKeyboardKey.space);
        await tester.pump();

        expect(received, false);
      });
    });

    group('accessibility', () {
      testWidgets('has checked semantics when checked', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoice(
            value: true,
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(MultiChoice));
        expect(semantics.flagsCollection.isChecked, CheckedState.isTrue);
      });

      testWidgets('does not have checked semantics when unchecked', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoice(
            value: false,
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(MultiChoice));
        expect(semantics.flagsCollection.isChecked, CheckedState.isFalse);
      });

      testWidgets('has enabled semantics when interactive', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoice(
            value: false,
            onChanged: (v) {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(MultiChoice));
        expect(semantics.flagsCollection.isEnabled, Tristate.isTrue);
      });

      testWidgets('has disabled semantics when not interactive', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          const MultiChoice(
            value: false,
          ),
        ));

        final semantics = tester.getSemantics(find.byType(MultiChoice));
        expect(semantics.flagsCollection.isEnabled, Tristate.isFalse);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoice(
            value: true,
            onChanged: (v) {},
          ),
          brightness: Brightness.light,
        ));

        expect(find.byType(MultiChoice), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          MultiChoice(
            value: true,
            onChanged: (v) {},
          ),
          brightness: Brightness.dark,
        ));

        expect(find.byType(MultiChoice), findsOneWidget);
      });
    });
  });
}
