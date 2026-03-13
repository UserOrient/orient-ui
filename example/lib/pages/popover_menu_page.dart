import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:example/style.dart';
import 'package:example/widgets/popover_menu.dart';

class PopoverMenuPage extends StatelessWidget {
  const PopoverMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return Align(
      alignment: Alignment.centerRight,
      child: PopoverMenu(
      items: [
        PopoverMenuItem(
          icon: const Icon(TablerIcons.copy),
          label: 'Copy API key',
        ),
        PopoverMenuItem(
          icon: const Icon(TablerIcons.switch_horizontal),
          label: 'Switch project',
        ),
        PopoverMenuItem(
          icon: const Icon(TablerIcons.settings),
          label: 'Project settings',
        ),
        PopoverMenuItem(
          icon: const Icon(TablerIcons.brush),
          label: 'Project appearance',
        ),
        PopoverMenuItem(
          icon: const Icon(TablerIcons.users),
          label: 'Members',
        ),
        PopoverMenuItem(
          icon: const Icon(TablerIcons.trash),
          label: 'Delete',
        ),
      ],
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
    );
  }
}
