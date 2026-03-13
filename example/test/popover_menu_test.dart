import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/popover_menu.dart';

import 'test_helper.dart';

const List<PopoverMenuItem> _testItems = [
  PopoverMenuItem(label: 'Copy'),
  PopoverMenuItem(label: 'Paste'),
  PopoverMenuItem(label: 'Delete'),
];

/// Wraps widget with Overlay for popover tests.
/// Aligns child to top-center with enough vertical space for the menu.
Widget _wrapWithOverlay(
  Widget child, {
  Brightness brightness = Brightness.light,
  Size size = const Size(800, 900),
}) {
  return Style(
    brightness: brightness,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: MediaQueryData(size: size),
        child: Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (_) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: child,
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}

void main() {
  group('PopoverMenu', () {
    group('widget version', () {
      testWidgets('renders trigger child', (tester) async {
        await tester.pumpWidget(
          _wrapWithOverlay(
            PopoverMenu(
              items: _testItems,
              child: const Text('Open'),
            ),
          ),
        );

        expect(find.text('Open'), findsOneWidget);
      });

      testWidgets('opens menu on tap', (tester) async {
        await tester.pumpWidget(
          _wrapWithOverlay(
            PopoverMenu(
              items: _testItems,
              child: const Text('Open'),
            ),
          ),
        );

        expect(find.text('Copy'), findsNothing);

        await tester.tap(find.text('Open'));
        await tester.pump();

        expect(find.text('Copy'), findsOneWidget);
        expect(find.text('Paste'), findsOneWidget);
        expect(find.text('Delete'), findsOneWidget);
      });

      testWidgets('closes on item tap', (tester) async {
        await tester.pumpWidget(
          _wrapWithOverlay(
            PopoverMenu(
              items: _testItems,
              child: const Text('Open'),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pump();

        await tester.tap(find.text('Copy'));
        await tester.pump();

        expect(find.text('Copy'), findsNothing);
      });

      testWidgets('calls item onTap callback', (tester) async {
        var called = false;

        await tester.pumpWidget(
          _wrapWithOverlay(
            PopoverMenu(
              items: [
                PopoverMenuItem(
                  label: 'Action',
                  onTap: () {
                    called = true;
                  },
                ),
              ],
              child: const Text('Open'),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pump();

        await tester.tap(find.text('Action'));
        await tester.pump();

        expect(called, isTrue);
      });

      testWidgets('closes on outside tap', (tester) async {
        await tester.pumpWidget(
          _wrapWithOverlay(
            Center(
              child: PopoverMenu(
                items: _testItems,
                child: const Text('Open'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pump();

        expect(find.text('Copy'), findsOneWidget);

        // Tap outside the menu
        await tester.tapAt(const Offset(10, 10));
        await tester.pump();

        expect(find.text('Copy'), findsNothing);
      });

      testWidgets('toggles on repeated trigger taps', (tester) async {
        await tester.pumpWidget(
          _wrapWithOverlay(
            PopoverMenu(
              items: _testItems,
              child: const Text('Open'),
            ),
          ),
        );

        // First tap opens
        await tester.tap(find.text('Open'));
        await tester.pump();
        expect(find.text('Copy'), findsOneWidget);

        // Second tap closes
        await tester.tap(find.text('Open'));
        await tester.pump();
        expect(find.text('Copy'), findsNothing);
      });
    });

    group('PopoverMenu.show', () {
      testWidgets('opens menu imperatively', (tester) async {
        await tester.pumpWidget(
          _wrapWithOverlay(
            Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    PopoverMenu.show(context: context, items: _testItems);
                  },
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Text('Trigger'),
                  ),
                );
              },
            ),
          ),
        );

        expect(find.text('Copy'), findsNothing);

        await tester.tap(find.text('Trigger'));
        await tester.pump();

        expect(find.text('Copy'), findsOneWidget);
        expect(find.text('Paste'), findsOneWidget);
        expect(find.text('Delete'), findsOneWidget);
      });

      testWidgets('closes on item tap', (tester) async {
        await tester.pumpWidget(
          _wrapWithOverlay(
            Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    PopoverMenu.show(context: context, items: _testItems);
                  },
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Text('Trigger'),
                  ),
                );
              },
            ),
          ),
        );

        await tester.tap(find.text('Trigger'));
        await tester.pump();

        await tester.tap(find.text('Paste'));
        await tester.pump();

        expect(find.text('Paste'), findsNothing);
      });

      testWidgets('calls item onTap callback', (tester) async {
        var called = false;

        await tester.pumpWidget(
          _wrapWithOverlay(
            Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    PopoverMenu.show(
                      context: context,
                      items: [
                        PopoverMenuItem(
                          label: 'Action',
                          onTap: () {
                            called = true;
                          },
                        ),
                      ],
                    );
                  },
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Text('Trigger'),
                  ),
                );
              },
            ),
          ),
        );

        await tester.tap(find.text('Trigger'));
        await tester.pump();

        await tester.tap(find.text('Action'));
        await tester.pump();

        expect(called, isTrue);
      });

      testWidgets('closes on outside tap', (tester) async {
        await tester.pumpWidget(
          _wrapWithOverlay(
            Center(
              child: Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      PopoverMenu.show(context: context, items: _testItems);
                    },
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Text('Trigger'),
                    ),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Trigger'));
        await tester.pump();

        expect(find.text('Copy'), findsOneWidget);

        await tester.tapAt(const Offset(10, 10));
        await tester.pump();

        expect(find.text('Copy'), findsNothing);
      });
    });

    group('menu items', () {
      testWidgets('renders items with icons', (tester) async {
        await tester.pumpWidget(
          _wrapWithOverlay(
            PopoverMenu(
              items: const [
                PopoverMenuItem(
                  icon: SizedBox(width: 24, height: 24),
                  label: 'With icon',
                ),
              ],
              child: const Text('Open'),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pump();

        expect(find.text('With icon'), findsOneWidget);
      });

      testWidgets('renders items without icons', (tester) async {
        await tester.pumpWidget(
          _wrapWithOverlay(
            PopoverMenu(
              items: const [
                PopoverMenuItem(label: 'No icon'),
              ],
              child: const Text('Open'),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pump();

        expect(find.text('No icon'), findsOneWidget);
      });

      testWidgets('renders all items', (tester) async {
        final List<PopoverMenuItem> items = List.generate(
          6,
          (int i) {
            return PopoverMenuItem(label: 'Item $i');
          },
        );

        await tester.pumpWidget(
          _wrapWithOverlay(
            PopoverMenu(
              items: items,
              child: const Text('Open'),
            ),
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pump();

        for (int i = 0; i < 6; i++) {
          expect(find.text('Item $i'), findsOneWidget);
        }
      });
    });

    group('theming', () {
      testWidgets('renders in light mode', (tester) async {
        await tester.pumpWidget(
          _wrapWithOverlay(
            PopoverMenu(
              items: _testItems,
              child: const Text('Open'),
            ),
            brightness: Brightness.light,
          ),
        );

        expect(find.text('Open'), findsOneWidget);
      });

      testWidgets('renders in dark mode', (tester) async {
        await tester.pumpWidget(
          _wrapWithOverlay(
            PopoverMenu(
              items: _testItems,
              child: const Text('Open'),
            ),
            brightness: Brightness.dark,
          ),
        );

        expect(find.text('Open'), findsOneWidget);
      });

      testWidgets('menu renders in dark mode', (tester) async {
        await tester.pumpWidget(
          _wrapWithOverlay(
            PopoverMenu(
              items: _testItems,
              child: const Text('Open'),
            ),
            brightness: Brightness.dark,
          ),
        );

        await tester.tap(find.text('Open'));
        await tester.pump();

        expect(find.text('Copy'), findsOneWidget);
      });
    });
  });
}
