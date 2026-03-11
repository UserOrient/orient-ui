import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/tile.dart';

import 'test_helper.dart';

void main() {
  group('Tile', () {
    group('rendering', () {
      testWidgets('renders title', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Account',
            onTap: () {},
          ),
        ));

        expect(find.text('Account'), findsOneWidget);
      });

      testWidgets('renders subtitle', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Account',
            subtitle: 'Manage your account',
            onTap: () {},
          ),
        ));

        expect(find.text('Manage your account'), findsOneWidget);
      });

      testWidgets('renders without subtitle', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Account',
            onTap: () {},
          ),
        ));

        expect(find.text('Account'), findsOneWidget);
        expect(find.text('Manage your account'), findsNothing);
      });

      testWidgets('renders trailing widget', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Account',
            trailing: const Text('T'),
            onTap: () {},
          ),
        ));

        expect(find.text('T'), findsOneWidget);
      });

      testWidgets('renders without trailing widget', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Account',
            onTap: () {},
          ),
        ));

        expect(find.byType(Tile), findsOneWidget);
      });

      testWidgets('renders simple variant', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Test',
            onTap: () {},
          ),
        ));

        expect(find.byType(Tile), findsOneWidget);
      });

      testWidgets('renders bordered variant', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            variant: TileVariant.bordered,
            title: 'Test',
            onTap: () {},
          ),
        ));

        expect(find.byType(Tile), findsOneWidget);
      });

      testWidgets('renders filled variant', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            variant: TileVariant.filled,
            title: 'Test',
            onTap: () {},
          ),
        ));

        expect(find.byType(Tile), findsOneWidget);
      });

      testWidgets('renders with leading widget', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            leading: const Text('L'),
            title: 'Test',
            onTap: () {},
          ),
        ));

        expect(find.text('L'), findsOneWidget);
      });

      testWidgets('renders without leading widget', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Test',
            onTap: () {},
          ),
        ));

        expect(find.text('Test'), findsOneWidget);
      });
    });

    group('variants', () {
      testWidgets('simple has no border or fill', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Test',
            onTap: () {},
          ),
        ));

        final container = tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.border, isNull);
        expect(decoration.color, isNull);
      });

      testWidgets('bordered has border', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            variant: TileVariant.bordered,
            title: 'Test',
            onTap: () {},
          ),
        ));

        final container = tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.border, isNotNull);
      });

      testWidgets('filled has surfaceContainer color', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            variant: TileVariant.filled,
            title: 'Test',
            onTap: () {},
          ),
        ));

        final container = tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, const Color(0xFFFAFAFA));
      });

      testWidgets('filled dark mode uses dark surfaceContainer', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            variant: TileVariant.filled,
            title: 'Test',
            onTap: () {},
          ),
          brightness: Brightness.dark,
        ));

        final container = tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, const Color(0xFF121212));
      });
    });

    group('interaction', () {
      testWidgets('tap triggers onTap', (tester) async {
        bool tapped = false;

        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Test',
            onTap: () => tapped = true,
          ),
        ));

        await tester.tap(find.byType(Tile));
        await tester.pump();

        expect(tapped, isTrue);
      });

      testWidgets('tap on text area triggers onTap', (tester) async {
        bool tapped = false;

        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Test',
            subtitle: 'A subtitle',
            onTap: () => tapped = true,
          ),
        ));

        await tester.tap(find.text('Test'));
        await tester.pump();

        expect(tapped, isTrue);
      });

      testWidgets('tap on trailing area triggers onTap', (tester) async {
        bool tapped = false;

        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Test',
            trailing: const Text('T'),
            onTap: () => tapped = true,
          ),
        ));

        await tester.tap(find.text('T'));
        await tester.pump();

        expect(tapped, isTrue);
      });

      testWidgets('hover shows click cursor', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Test',
            onTap: () {},
          ),
        ));

        final mouseRegion = tester.widget<MouseRegion>(
          find.byType(MouseRegion).first,
        );
        expect(mouseRegion.cursor, SystemMouseCursors.click);
      });

      testWidgets('disabled shows basic cursor', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          const Tile(
            title: 'Test',
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
          Tile(
            title: 'Test',
            subtitle: 'This is a very long subtitle that should wrap to '
                'multiple lines and eventually get truncated with an '
                'ellipsis when it exceeds the maximum of two lines',
            onTap: () {},
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

      testWidgets('renders single line subtitle', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Test',
            subtitle: 'Short',
            onTap: () {},
          ),
        ));

        expect(find.text('Short'), findsOneWidget);
      });
    });

    group('accessibility', () {
      testWidgets('has button semantics', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Test',
            onTap: () {},
          ),
        ));

        final semantics = tester.getSemantics(find.byType(Tile));
        expect(semantics.flagsCollection.isButton, isTrue);
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Test',
            onTap: () {},
          ),
          brightness: Brightness.light,
        ));

        expect(find.byType(Tile), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            title: 'Test',
            onTap: () {},
          ),
          brightness: Brightness.dark,
        ));

        expect(find.byType(Tile), findsOneWidget);
      });

      testWidgets('filled uses surfaceContainer color', (tester) async {
        await tester.pumpWidget(wrapWithStyle(
          Tile(
            variant: TileVariant.filled,
            title: 'Test',
            onTap: () {},
          ),
        ));

        final container = tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, isNotNull);
      });
    });
  });
}
