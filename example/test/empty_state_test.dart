import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/empty_state.dart';

import 'test_helper.dart';

void main() {
  group('EmptyState', () {
    group('rendering', () {
      testWidgets('renders with title only', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          EmptyState(title: 'No items'),
        ));

        expect(find.text('No items'), findsOneWidget);
      });

      testWidgets('renders with icon', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          EmptyState(
            title: 'No items',
            icon: const SizedBox(key: Key('test-icon'), width: 48, height: 48),
          ),
        ));

        expect(find.text('No items'), findsOneWidget);
        expect(find.byKey(const Key('test-icon')), findsOneWidget);
      });

      testWidgets('renders with description', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          EmptyState(
            title: 'No items',
            description: 'Add some items to get started.',
          ),
        ));

        expect(find.text('No items'), findsOneWidget);
        expect(find.text('Add some items to get started.'), findsOneWidget);
      });

      testWidgets('does not render empty description', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          EmptyState(
            title: 'No items',
            description: '',
          ),
        ));

        expect(find.text('No items'), findsOneWidget);
        // Should only find one Text widget (the title)
        expect(find.byType(Text), findsOneWidget);
      });

      testWidgets('renders with action', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          EmptyState(
            title: 'No items',
            action: const SizedBox(key: Key('test-action')),
          ),
        ));

        expect(find.text('No items'), findsOneWidget);
        expect(find.byKey(const Key('test-action')), findsOneWidget);
      });

      testWidgets('renders with all optional props', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          EmptyState(
            title: 'Location Disabled',
            description: 'Please enable GPS.',
            icon: const SizedBox(key: Key('test-icon'), width: 48, height: 48),
            action: const SizedBox(key: Key('test-action')),
          ),
        ));

        expect(find.text('Location Disabled'), findsOneWidget);
        expect(find.text('Please enable GPS.'), findsOneWidget);
        expect(find.byKey(const Key('test-icon')), findsOneWidget);
        expect(find.byKey(const Key('test-action')), findsOneWidget);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          EmptyState(title: 'Light mode'),
          brightness: Brightness.light,
        ));

        expect(find.text('Light mode'), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          EmptyState(title: 'Dark mode'),
          brightness: Brightness.dark,
        ));

        expect(find.text('Dark mode'), findsOneWidget);
      });
    });
  });
}
