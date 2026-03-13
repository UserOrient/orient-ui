import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:example/widgets/tappable_icon.dart';

class TappableIconPage extends StatelessWidget {
  const TappableIconPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        TappableIcon(
          icon: const Icon(TablerIcons.heart),
          onPressed: () {},
          tooltip: 'Like',
        ),
        TappableIcon(
          icon: const Icon(TablerIcons.share),
          onPressed: () {},
          tooltip: 'Share',
        ),
        TappableIcon(
          icon: const Icon(TablerIcons.bookmark),
          onPressed: () {},
          tooltip: 'Bookmark',
        ),
        TappableIcon(
          icon: const Icon(TablerIcons.dots_vertical),
          onPressed: () {},
          tooltip: 'More',
        ),
        TappableIcon(
          icon: const Icon(TablerIcons.trash),
          onPressed: () {},
          tooltip: 'Delete',
        ),
        // Disabled
        const TappableIcon(
          icon: Icon(TablerIcons.lock),
          onPressed: null,
          tooltip: 'Locked',
        ),
      ],
    );
  }
}
