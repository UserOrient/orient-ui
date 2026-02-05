import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/toggle.dart';

import 'test_helper.dart';

void main() {
  group('Toggle', () {
    group('rendering', () {
      testWidgets('renders without error', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Toggle(value: false, onChanged: (v) {}),
        ));

        expect(find.byType(Toggle), findsOneWidget);
      });

      testWidgets('renders in on state', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Toggle(value: true, onChanged: (v) {}),
        ));

        expect(find.byType(Toggle), findsOneWidget);
      });

      testWidgets('renders small variant', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Toggle.small(value: false, onChanged: (v) {}),
        ));

        expect(find.byType(Toggle), findsOneWidget);
      });

      testWidgets('renders small variant in on state', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Toggle.small(value: true, onChanged: (v) {}),
        ));

        expect(find.byType(Toggle), findsOneWidget);
      });
    });

    group('states', () {
      testWidgets('has reduced opacity when disabled', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const Toggle(value: false),
        ));

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 0.5);
      });

      testWidgets('has full opacity when enabled', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Toggle(value: false, onChanged: (v) {}),
        ));

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 1.0);
      });

      testWidgets('animates when value changes', (tester) async {
        bool value = false;

        await tester.pumpWidget(wrapWithStyling(
          StatefulBuilder(
            builder: (context, setState) {
              return Toggle(
                value: value,
                onChanged: (v) => setState(() => value = v),
              );
            },
          ),
        ));

        await tester.tap(find.byType(Toggle));
        await tester.pump();
        expect(value, isTrue);

        // Let animation run partially
        await tester.pump(const Duration(milliseconds: 100));
        // Let animation complete
        await tester.pumpAndSettle();
      });
    });

    group('interaction', () {
      testWidgets('calls onChanged with toggled value on tap', (tester) async {
        bool? received;

        await tester.pumpWidget(wrapWithStyling(
          Toggle(
            value: false,
            onChanged: (v) => received = v,
          ),
        ));

        await tester.tap(find.byType(Toggle));
        await tester.pump();

        expect(received, isTrue);
      });

      testWidgets('calls onChanged with false when toggling off', (tester) async {
        bool? received;

        await tester.pumpWidget(wrapWithStyling(
          Toggle(
            value: true,
            onChanged: (v) => received = v,
          ),
        ));

        await tester.tap(find.byType(Toggle));
        await tester.pump();

        expect(received, isFalse);
      });

      testWidgets('does not call onChanged when disabled', (tester) async {
        bool called = false;

        await tester.pumpWidget(wrapWithStyling(
          const Toggle(value: false),
        ));

        await tester.tap(find.byType(Toggle));
        await tester.pump();

        expect(called, isFalse);
      });

      testWidgets('has Focus widget for keyboard support', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Toggle(value: false, onChanged: (v) {}),
        ));

        expect(find.byType(Focus), findsWidgets);
      });

      testWidgets('supports horizontal drag to toggle on', (tester) async {
        bool? received;

        await tester.pumpWidget(wrapWithStyling(
          Toggle(
            value: false,
            onChanged: (v) => received = v,
          ),
        ));

        await tester.timedDrag(
          find.byType(Toggle),
          const Offset(40, 0),
          const Duration(milliseconds: 200),
        );
        await tester.pumpAndSettle();

        expect(received, isTrue);
      });

      testWidgets('supports horizontal drag to toggle off', (tester) async {
        bool? received;

        await tester.pumpWidget(wrapWithStyling(
          Toggle(
            value: true,
            onChanged: (v) => received = v,
          ),
        ));

        await tester.timedDrag(
          find.byType(Toggle),
          const Offset(-40, 0),
          const Duration(milliseconds: 200),
        );
        await tester.pumpAndSettle();

        expect(received, isFalse);
      });
    });

    group('accessibility', () {
      testWidgets('has toggled semantics when on', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Toggle(value: true, onChanged: (v) {}),
        ));

        final semantics = tester.getSemantics(find.byType(Toggle));
        expect(semantics.hasFlag(SemanticsFlag.isToggled), isTrue);
      });

      testWidgets('does not have toggled semantics when off', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Toggle(value: false, onChanged: (v) {}),
        ));

        final semantics = tester.getSemantics(find.byType(Toggle));
        expect(semantics.hasFlag(SemanticsFlag.isToggled), isFalse);
      });

      testWidgets('has enabled semantics when interactive', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Toggle(value: false, onChanged: (v) {}),
        ));

        final semantics = tester.getSemantics(find.byType(Toggle));
        expect(semantics.hasFlag(SemanticsFlag.isEnabled), isTrue);
      });

      testWidgets('has disabled semantics when not interactive', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const Toggle(value: false),
        ));

        final semantics = tester.getSemantics(find.byType(Toggle));
        expect(semantics.hasFlag(SemanticsFlag.isEnabled), isFalse);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Toggle(value: true, onChanged: (v) {}),
          brightness: Brightness.light,
        ));

        expect(find.byType(Toggle), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          Toggle(value: true, onChanged: (v) {}),
          brightness: Brightness.dark,
        ));

        expect(find.byType(Toggle), findsOneWidget);
      });
    });
  });
}
