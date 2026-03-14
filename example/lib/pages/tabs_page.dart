import 'package:flutter/widgets.dart';
import 'package:example/widgets/tabs.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Tabs(
      index: _selected,
      onChanged: (i) => setState(() => _selected = i),
      items: const [
        'Approved',
        'Pending',
        'Archived',
        'Drafts',
        'Starred',
        'Scheduled',
        'Spam',
        'Trash',
      ],
    );
  }
}
