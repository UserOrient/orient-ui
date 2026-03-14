import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/tabs.dart';

import 'test_helper.dart';

void main() {
  group('Tabs', () {
    group('rendering', () {
      testWidgets('renders all tab labels', (tester) async {
        await tester.pumpWidget(
          wrapWithStyle(
            Tabs(
              index: 0,
              onChanged: (i) {},
              items: const ['Approved', 'Pending', 'Archived'],
            ),
          ),
        );

        expect(find.text('Approved'), findsOneWidget);
        expect(find.text('Pending'), findsOneWidget);
        expect(find.text('Archived'), findsOneWidget);
      });

      testWidgets('renders without error with single item', (tester) async {
        await tester.pumpWidget(
          wrapWithStyle(
            Tabs(
              index: 0,
              onChanged: (i) {},
              items: const ['Only'],
            ),
          ),
        );

        expect(find.byType(Tabs), findsOneWidget);
      });
    });

    group('interaction', () {
      testWidgets('calls onChanged when tapping a tab', (tester) async {
        int? received;

        await tester.pumpWidget(
          wrapWithStyle(
            Tabs(
              index: 0,
              onChanged: (i) => received = i,
              items: const ['Approved', 'Pending', 'Archived'],
            ),
          ),
        );

        await tester.tap(find.text('Pending'));
        await tester.pump();

        expect(received, 1);
      });

      testWidgets('calls onChanged with correct index for last tab', (tester) async {
        int? received;

        await tester.pumpWidget(
          wrapWithStyle(
            Tabs(
              index: 0,
              onChanged: (i) => received = i,
              items: const ['Approved', 'Pending', 'Archived'],
            ),
          ),
        );

        await tester.tap(find.text('Archived'));
        await tester.pump();

        expect(received, 2);
      });

      testWidgets('calls onChanged with 0 when tapping first tab', (tester) async {
        int? received;

        await tester.pumpWidget(
          wrapWithStyle(
            Tabs(
              index: 2,
              onChanged: (i) => received = i,
              items: const ['Approved', 'Pending', 'Archived'],
            ),
          ),
        );

        await tester.tap(find.text('Approved'));
        await tester.pump();

        expect(received, 0);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(
          wrapWithStyle(
            Tabs(
              index: 0,
              onChanged: (i) {},
              items: const ['Approved', 'Pending', 'Archived'],
            ),
            brightness: Brightness.light,
          ),
        );

        expect(find.byType(Tabs), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(
          wrapWithStyle(
            Tabs(
              index: 0,
              onChanged: (i) {},
              items: const ['Approved', 'Pending', 'Archived'],
            ),
            brightness: Brightness.dark,
          ),
        );

        expect(find.byType(Tabs), findsOneWidget);
      });
    });
  });
}
