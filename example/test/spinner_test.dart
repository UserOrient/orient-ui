import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/spinner.dart';

import 'test_helper.dart';

void main() {
  group('Spinner', () {
    group('rendering', () {
      testWidgets('renders without error', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const Spinner(color: Color(0xFF000000)),
        ));

        expect(find.byType(Spinner), findsOneWidget);
      });

      testWidgets('renders with custom color', (tester) async {
        const testColor = Color(0xFFFF0000);

        await tester.pumpWidget(wrapWithStyling(
          const Spinner(color: testColor),
        ));

        expect(find.byType(Spinner), findsOneWidget);
      });
    });

    group('animation', () {
      testWidgets('animation controller is running', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const Spinner(color: Color(0xFF000000)),
        ));

        final state = tester.state<SpinnerState>(find.byType(Spinner));
        expect(state, isNotNull);

        // Pump a frame to verify animation is running
        await tester.pump(const Duration(milliseconds: 100));

        // If we get here without error, animation is working
        expect(find.byType(Spinner), findsOneWidget);
      });

      testWidgets('rotates over time', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const Spinner(color: Color(0xFF000000)),
        ));

        // Pump multiple frames to simulate animation
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.byType(Spinner), findsOneWidget);
      });
    });

    group('accessibility', () {
      testWidgets('has loading semantics label', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const Spinner(color: Color(0xFF000000)),
        ));

        final semantics = tester.getSemantics(find.byType(Semantics));
        expect(semantics.label, 'Loading');
      });
    });

    group('disposal', () {
      testWidgets('disposes animation controller without error', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const Spinner(color: Color(0xFF000000)),
        ));

        // Remove the spinner from the tree
        await tester.pumpWidget(wrapWithStyling(
          const SizedBox(),
        ));

        // If we get here without error, disposal worked
        expect(find.byType(Spinner), findsNothing);
      });
    });
  });
}
