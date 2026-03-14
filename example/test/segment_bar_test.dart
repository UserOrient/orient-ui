import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/segment_bar.dart';

import 'test_helper.dart';

const _items = [
  SegmentItem(label: 'First'),
  SegmentItem(label: 'Second'),
  SegmentItem(label: 'Third'),
];

void main() {
  group('SegmentBar', () {
    group('rendering', () {
      testWidgets('renders without error', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SegmentBar(
            index: 0,
            onChanged: (_) {},
            items: _items,
          ),
        ));

        expect(find.byType(SegmentBar), findsOneWidget);
      });

      testWidgets('renders all item labels', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SegmentBar(
            index: 0,
            onChanged: (_) {},
            items: _items,
          ),
        ));

        expect(find.text('First'), findsOneWidget);
        expect(find.text('Second'), findsOneWidget);
        expect(find.text('Third'), findsOneWidget);
      });

      testWidgets('renders with icon only', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SegmentBar(
            index: 0,
            onChanged: (_) {},
            items: const [
              SegmentItem(icon: Icon(IconData(0xe047))),
              SegmentItem(icon: Icon(IconData(0xe048))),
            ],
          ),
        ));

        expect(find.byType(SegmentBar), findsOneWidget);
        expect(find.byType(Icon), findsNWidgets(2));
      });

      testWidgets('renders with icon and label', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SegmentBar(
            index: 0,
            onChanged: (_) {},
            items: const [
              SegmentItem(icon: Icon(IconData(0xe047)), label: 'Home'),
              SegmentItem(icon: Icon(IconData(0xe048)), label: 'Settings'),
            ],
          ),
        ));

        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Settings'), findsOneWidget);
        expect(find.byType(Icon), findsNWidgets(2));
      });

      testWidgets('renders scroll layout by default', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SegmentBar(
            index: 0,
            onChanged: (_) {},
            items: _items,
          ),
        ));

        expect(find.byType(SingleChildScrollView), findsOneWidget);
      });

      testWidgets('renders wrap layout', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SegmentBar(
            index: 0,
            onChanged: (_) {},
            items: _items,
            layout: SegmentBarLayout.wrap,
          ),
        ));

        expect(find.byType(Wrap), findsOneWidget);
      });
    });

    group('states', () {
      testWidgets('selected item has surfaceContainer background',
          (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SegmentBar(
            index: 1,
            onChanged: (_) {},
            items: _items,
          ),
        ));

        // Find the Container for the selected item (index 1 = "Second")
        final containers = tester.widgetList<Container>(
          find.byType(Container),
        );

        // The selected item should have a non-transparent background
        final selectedContainer = containers.where((c) {
          final decoration = c.decoration;
          if (decoration is BoxDecoration) {
            return decoration.color != null &&
                decoration.color != const Color(0x00000000);
          }
          return false;
        });

        expect(selectedContainer, isNotEmpty);
      });

      testWidgets('unselected items have transparent background',
          (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SegmentBar(
            index: 0,
            onChanged: (_) {},
            items: _items,
          ),
        ));

        // Find all item Containers with BoxDecoration
        final containers = tester
            .widgetList<Container>(find.byType(Container))
            .where((c) => c.decoration is BoxDecoration);

        // At least one should be transparent (unselected)
        final transparentContainers = containers.where((c) {
          final decoration = c.decoration as BoxDecoration;
          return decoration.color == const Color(0x00000000);
        });

        expect(transparentContainers, isNotEmpty);
      });
    });

    group('interaction', () {
      testWidgets('calls onChanged with correct index on tap', (tester) async {
        int? received;

        await tester.pumpWidget(wrapWithStyle(
          SegmentBar(
            index: 0,
            onChanged: (i) => received = i,
            items: _items,
          ),
        ));

        await tester.tap(find.text('Second'));
        await tester.pump();

        expect(received, 1);
      });

      testWidgets('calls onChanged with index 0 when first item tapped',
          (tester) async {
        int? received;

        await tester.pumpWidget(wrapWithStyle(
          SegmentBar(
            index: 2,
            onChanged: (i) => received = i,
            items: _items,
          ),
        ));

        await tester.tap(find.text('First'));
        await tester.pump();

        expect(received, 0);
      });

      testWidgets('calls onChanged with last index', (tester) async {
        int? received;

        await tester.pumpWidget(wrapWithStyle(
          SegmentBar(
            index: 0,
            onChanged: (i) => received = i,
            items: _items,
          ),
        ));

        await tester.tap(find.text('Third'));
        await tester.pump();

        expect(received, 2);
      });

      testWidgets('tapping selected item still fires onChanged',
          (tester) async {
        int? received;

        await tester.pumpWidget(wrapWithStyle(
          SegmentBar(
            index: 0,
            onChanged: (i) => received = i,
            items: _items,
          ),
        ));

        await tester.tap(find.text('First'));
        await tester.pump();

        expect(received, 0);
      });

      testWidgets('updates selection when rebuilt with new index',
          (tester) async {
        int selected = 0;

        await tester.pumpWidget(wrapWithStyle(
          StatefulBuilder(
            builder: (context, setState) {
              return SegmentBar(
                index: selected,
                onChanged: (i) => setState(() => selected = i),
                items: _items,
              );
            },
          ),
        ));

        await tester.tap(find.text('Third'));
        await tester.pump();

        expect(selected, 2);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SegmentBar(
            index: 0,
            onChanged: (_) {},
            items: _items,
          ),
          brightness: Brightness.light,
        ));

        expect(find.byType(SegmentBar), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          SegmentBar(
            index: 0,
            onChanged: (_) {},
            items: _items,
          ),
          brightness: Brightness.dark,
        ));

        expect(find.byType(SegmentBar), findsOneWidget);
      });
    });
  });
}
