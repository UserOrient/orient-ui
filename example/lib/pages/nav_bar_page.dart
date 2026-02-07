import 'package:example/styling.dart';
import 'package:flutter/widgets.dart';

class NavBarPage extends StatelessWidget {
  const NavBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final styling = Styling.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'This playground uses NavBar for its own navigation. '
          'Resize your browser window to see it adapt — '
          'a side rail on desktop, a bottom bar on mobile.',
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: styling.colors.secondaryText,
          ),
        ),
      ],
    );
  }
}
