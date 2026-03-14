import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/tag.dart';

import 'test_helper.dart';

void main() {
  group('Tag', () {
    group('rendering', () {
      testWidgets('renders with label', (WidgetTester tester) async {
        await tester.pumpWidget(
          wrapWithStyle(
            Tag(label: 'Implemented', color: const Color(0xFF22C55E)),
          ),
        );

        expect(find.text('Implemented'), findsOneWidget);
      });

      testWidgets('renders with correct color', (WidgetTester tester) async {
        const Color color = Color(0xFF3B82F6);

        await tester.pumpWidget(
          wrapWithStyle(
            Tag(label: 'Info', color: color),
          ),
        );

        final Container container = tester.widget<Container>(
          find.byType(Container),
        );
        final BoxDecoration decoration = container.decoration as BoxDecoration;
        expect(decoration.color, color.withValues(alpha: 0.15));
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (WidgetTester tester) async {
        await tester.pumpWidget(
          wrapWithStyle(
            Tag(label: 'Light', color: const Color(0xFF22C55E)),
            brightness: Brightness.light,
          ),
        );

        expect(find.text('Light'), findsOneWidget);
      });

      testWidgets('renders in dark mode', (WidgetTester tester) async {
        await tester.pumpWidget(
          wrapWithStyle(
            Tag(label: 'Dark', color: const Color(0xFF22C55E)),
            brightness: Brightness.dark,
          ),
        );

        expect(find.text('Dark'), findsOneWidget);
      });
    });
  });
}
