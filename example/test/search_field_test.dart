import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/search_field.dart';

import 'test_helper.dart';

void main() {
  group('SearchField', () {
    group('rendering', () {
      testWidgets('renders without error', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const SearchField(),
        ));

        expect(find.byType(SearchField), findsOneWidget);
      });

      testWidgets('renders placeholder when empty', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const SearchField(placeholder: 'Search...'),
        ));

        expect(find.text('Search...'), findsOneWidget);
      });

      testWidgets('hides placeholder when text entered', (tester) async {
        final controller = TextEditingController(text: 'hello');

        await tester.pumpWidget(wrapWithStyling(
          SearchField(
            controller: controller,
            placeholder: 'Search...',
          ),
        ));

        expect(find.text('Search...'), findsNothing);
        expect(find.text('hello'), findsOneWidget);
      });

      testWidgets('renders search icon', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const SearchField(),
        ));

        // Search icon is rendered via CustomPaint
        expect(find.byType(CustomPaint), findsWidgets);
      });

      testWidgets('renders clear button when text entered', (tester) async {
        final controller = TextEditingController(text: 'hello');

        await tester.pumpWidget(wrapWithStyling(
          SearchField(controller: controller),
        ));

        // Should have 2 CustomPaint: search icon + clear button
        expect(find.byType(CustomPaint), findsNWidgets(2));
      });

      testWidgets('does not render clear button when empty', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const SearchField(),
        ));

        // Should have only 1 CustomPaint: search icon
        expect(find.byType(CustomPaint), findsOneWidget);
      });

      testWidgets('has correct height', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const SearchField(),
        ));

        final container = tester.widget<Container>(find.byType(Container).first);
        expect(container.constraints?.maxHeight, 40);
      });
    });

    group('interaction', () {
      testWidgets('calls onChanged when text changes', (tester) async {
        String? changedValue;

        await tester.pumpWidget(wrapWithStyling(
          SearchField(
            onChanged: (value) => changedValue = value,
          ),
        ));

        await tester.enterText(find.byType(EditableText), 'test');
        await tester.pump();

        expect(changedValue, 'test');
      });

      testWidgets('calls onSubmitted when submitted', (tester) async {
        String? submittedValue;

        await tester.pumpWidget(wrapWithStyling(
          SearchField(
            onSubmitted: (value) => submittedValue = value,
          ),
        ));

        await tester.enterText(find.byType(EditableText), 'search query');
        await tester.testTextInput.receiveAction(TextInputAction.search);
        await tester.pump();

        expect(submittedValue, 'search query');
      });

      testWidgets('clears text when clear button tapped', (tester) async {
        final controller = TextEditingController(text: 'hello');
        String? changedValue;

        await tester.pumpWidget(wrapWithStyling(
          SearchField(
            controller: controller,
            onChanged: (value) => changedValue = value,
          ),
        ));

        // Find and tap the clear button (second CustomPaint wrapped in GestureDetector)
        final clearButton = find.byType(GestureDetector).last;
        await tester.tap(clearButton);
        await tester.pump();

        expect(controller.text, '');
        expect(changedValue, '');
      });

      testWidgets('focuses when tapped', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const SearchField(),
        ));

        await tester.tap(find.byType(SearchField));
        await tester.pump();

        final editableText = tester.widget<EditableText>(find.byType(EditableText));
        expect(editableText.focusNode.hasFocus, isTrue);
      });

      testWidgets('autofocus works', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const SearchField(autofocus: true),
        ));

        await tester.pump();
        await tester.pump();

        final editableText = tester.widget<EditableText>(find.byType(EditableText));
        expect(editableText.focusNode.hasFocus, isTrue);
      });
    });

    group('controller', () {
      testWidgets('uses provided controller', (tester) async {
        final controller = TextEditingController(text: 'initial');

        await tester.pumpWidget(wrapWithStyling(
          SearchField(controller: controller),
        ));

        expect(find.text('initial'), findsOneWidget);
      });

      testWidgets('updates when controller changes externally', (tester) async {
        final controller = TextEditingController();

        await tester.pumpWidget(wrapWithStyling(
          SearchField(controller: controller),
        ));

        controller.text = 'external update';
        await tester.pump();

        expect(find.text('external update'), findsOneWidget);
      });

      testWidgets('creates internal controller when not provided', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const SearchField(),
        ));

        await tester.enterText(find.byType(EditableText), 'typed');
        await tester.pump();

        expect(find.text('typed'), findsOneWidget);
      });
    });

    group('accessibility', () {
      testWidgets('has textField semantics', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const SearchField(placeholder: 'Search...'),
        ));

        final semantics = tester.getSemantics(find.byType(Semantics).first);
        expect(semantics.hasFlag(SemanticsFlag.isTextField), isTrue);
      });

      testWidgets('clear button has button semantics', (tester) async {
        final controller = TextEditingController(text: 'hello');

        await tester.pumpWidget(wrapWithStyling(
          SearchField(controller: controller),
        ));

        // Find the clear button semantics
        final clearButtonSemantics = tester.getSemantics(
          find.bySemanticsLabel('Clear search'),
        );
        expect(clearButtonSemantics.hasFlag(SemanticsFlag.isButton), isTrue);
      });

      testWidgets('has hint from placeholder', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const SearchField(placeholder: 'Search packages...'),
        ));

        final semantics = tester.getSemantics(find.byType(Semantics).first);
        expect(semantics.hint, 'Search packages...');
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const SearchField(placeholder: 'Light mode'),
          brightness: Brightness.light,
        ));

        expect(find.text('Light mode'), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(wrapWithStyling(
          const SearchField(placeholder: 'Dark mode'),
          brightness: Brightness.dark,
        ));

        expect(find.text('Dark mode'), findsOneWidget);
      });
    });
  });
}
