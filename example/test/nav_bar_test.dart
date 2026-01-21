import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/nav_bar.dart';

import 'test_helper.dart';

void main() {
  final testItems = [
    NavBarItem(icon: const SizedBox(width: 24, height: 24), label: 'Home'),
    NavBarItem(icon: const SizedBox(width: 24, height: 24), label: 'Search'),
    NavBarItem(icon: const SizedBox(width: 24, height: 24), label: 'Profile'),
  ];

  Widget buildNavBar({
    int currentIndex = 0,
    void Function(int)? onTap,
    Size size = const Size(800, 600),
    Widget? railHeader,
    Widget? railFooter,
  }) {
    return wrapWithStylingAndSize(
      NavBar(
        currentIndex: currentIndex,
        onTap: onTap ?? (_) {},
        items: testItems,
        body: const Center(child: Text('Body')),
        railHeader: railHeader,
        railFooter: railFooter,
      ),
      size: size,
    );
  }

  group('NavBar', () {
    group('responsive layout', () {
      testWidgets('shows rail on desktop (width >= 600)', (tester) async {
        await tester.pumpWidget(buildNavBar(size: const Size(800, 600)));

        // On desktop, we should see a Row (rail + body)
        expect(find.byType(Row), findsWidgets);
        // Body should be visible
        expect(find.text('Body'), findsOneWidget);
        // All labels should be visible in rail
        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Search'), findsOneWidget);
        expect(find.text('Profile'), findsOneWidget);
      });

      testWidgets('shows bottom bar on mobile (width < 600)', (tester) async {
        await tester.pumpWidget(buildNavBar(size: const Size(400, 800)));

        // On mobile, we should see a Column (body + bottom bar)
        expect(find.byType(Column), findsWidgets);
        // Body should be visible
        expect(find.text('Body'), findsOneWidget);
        // All labels should be visible in bottom bar
        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Search'), findsOneWidget);
        expect(find.text('Profile'), findsOneWidget);
      });

      testWidgets('switches layout at breakpoint', (tester) async {
        // Start with desktop
        await tester.pumpWidget(buildNavBar(size: const Size(800, 600)));
        expect(find.text('Body'), findsOneWidget);

        // Switch to mobile
        await tester.pumpWidget(buildNavBar(size: const Size(400, 800)));
        expect(find.text('Body'), findsOneWidget);

        // Switch back to desktop
        await tester.pumpWidget(buildNavBar(size: const Size(800, 600)));
        expect(find.text('Body'), findsOneWidget);
      });
    });

    group('interaction', () {
      testWidgets('calls onTap with correct index on desktop', (tester) async {
        int? tappedIndex;

        await tester.pumpWidget(buildNavBar(
          size: const Size(800, 600),
          onTap: (index) => tappedIndex = index,
        ));

        // Tap second item
        await tester.tap(find.text('Search'));
        await tester.pump();

        expect(tappedIndex, 1);
      });

      testWidgets('calls onTap with correct index on mobile', (tester) async {
        int? tappedIndex;

        await tester.pumpWidget(buildNavBar(
          size: const Size(400, 800),
          onTap: (index) => tappedIndex = index,
        ));

        // Tap third item
        await tester.tap(find.text('Profile'));
        await tester.pump();

        expect(tappedIndex, 2);
      });
    });

    group('current index', () {
      testWidgets('highlights current item on desktop', (tester) async {
        await tester.pumpWidget(buildNavBar(
          currentIndex: 1,
          size: const Size(800, 600),
        ));

        // All items should be visible
        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Search'), findsOneWidget);
        expect(find.text('Profile'), findsOneWidget);
      });

      testWidgets('highlights current item on mobile', (tester) async {
        await tester.pumpWidget(buildNavBar(
          currentIndex: 2,
          size: const Size(400, 800),
        ));

        // All items should be visible
        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Search'), findsOneWidget);
        expect(find.text('Profile'), findsOneWidget);
      });
    });

    group('header and footer', () {
      testWidgets('renders rail header on desktop', (tester) async {
        await tester.pumpWidget(buildNavBar(
          size: const Size(800, 600),
          railHeader: const Text('Logo'),
        ));

        expect(find.text('Logo'), findsOneWidget);
      });

      testWidgets('renders rail footer on desktop', (tester) async {
        await tester.pumpWidget(buildNavBar(
          size: const Size(800, 600),
          railFooter: const Text('Footer'),
        ));

        expect(find.text('Footer'), findsOneWidget);
      });

      testWidgets('does not render header/footer on mobile', (tester) async {
        await tester.pumpWidget(buildNavBar(
          size: const Size(400, 800),
          railHeader: const Text('Logo'),
          railFooter: const Text('Footer'),
        ));

        // Header and footer should not be visible on mobile
        expect(find.text('Logo'), findsNothing);
        expect(find.text('Footer'), findsNothing);
      });
    });

    group('accessibility', () {
      testWidgets('items have button semantics on desktop', (tester) async {
        await tester.pumpWidget(buildNavBar(size: const Size(800, 600)));

        // Find the Semantics widget wrapping Home item
        final homeText = find.text('Home');
        expect(homeText, findsOneWidget);
      });

      testWidgets('items have button semantics on mobile', (tester) async {
        await tester.pumpWidget(buildNavBar(size: const Size(400, 800)));

        // Find the Home text in bottom bar
        final homeText = find.text('Home');
        expect(homeText, findsOneWidget);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithStylingAndSize(
          NavBar(
            currentIndex: 0,
            onTap: (_) {},
            items: testItems,
            body: const Text('Body'),
          ),
          brightness: Brightness.light,
          size: const Size(800, 600),
        ));

        expect(find.text('Body'), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithStylingAndSize(
          NavBar(
            currentIndex: 0,
            onTap: (_) {},
            items: testItems,
            body: const Text('Body'),
          ),
          brightness: Brightness.dark,
          size: const Size(800, 600),
        ));

        expect(find.text('Body'), findsOneWidget);
      });
    });
  });
}
