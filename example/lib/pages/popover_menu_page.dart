import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:example/style.dart';
import 'package:example/widgets/popover_menu.dart';
import 'package:example/widgets/tappable_icon.dart';

const List<PopoverMenuItem> _demoItems = [
  PopoverMenuItem(icon: Icon(TablerIcons.copy), label: 'Copy API key'),
  PopoverMenuItem(icon: Icon(TablerIcons.switch_horizontal), label: 'Switch project'),
  PopoverMenuItem(icon: Icon(TablerIcons.settings), label: 'Project settings'),
  PopoverMenuItem(icon: Icon(TablerIcons.brush), label: 'Project appearance'),
  PopoverMenuItem(icon: Icon(TablerIcons.users), label: 'Members'),
  PopoverMenuItem(icon: Icon(TablerIcons.trash), label: 'Delete'),
];

class PopoverMenuPage extends StatelessWidget {
  const PopoverMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);

    return Row(
      children: [
        // Widget version
        PopoverMenu(
          items: _demoItems,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(
              TablerIcons.dots_vertical,
              size: 20,
              color: style.colors.foreground,
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Imperative version
        Builder(
          builder: (BuildContext context) {
            return TappableIcon(
              icon: const Icon(TablerIcons.dots),
              onPressed: () {
                PopoverMenu.show(context: context, items: _demoItems);
              },
            );
          },
        ),
      ],
    );
  }
}
