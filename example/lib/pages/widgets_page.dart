import 'package:example/pages/alert_popup_page.dart';
import 'package:example/pages/info_banner_page.dart';
import 'package:example/pages/picker_page.dart';
import 'package:example/pages/button_page.dart';
import 'package:example/pages/card_box_page.dart';
import 'package:example/pages/multi_choice_page.dart';
import 'package:example/pages/multi_choice_tile_page.dart';
import 'package:example/pages/single_choice_page.dart';
import 'package:example/pages/single_choice_tile_page.dart';
import 'package:example/pages/confirmation_popup_page.dart';
import 'package:example/pages/copy_button_page.dart';
import 'package:example/pages/empty_state_page.dart';
import 'package:example/pages/nav_bar_page.dart';
import 'package:example/pages/popover_menu_page.dart';
import 'package:example/pages/tappable_icon_page.dart';
import 'package:example/pages/popup_page.dart';
import 'package:example/pages/search_field_page.dart';
import 'package:example/pages/spinner_page.dart';
import 'package:example/pages/toast_page.dart';
import 'package:example/pages/toggle_page.dart';
import 'package:example/pages/tile_page.dart';
import 'package:example/pages/toggle_tile_page.dart';
import 'package:example/style.dart';
import 'package:example/widgets/code_block.dart';
import 'package:example/widgets/copy_button.dart';
import 'package:example/widgets/segment_bar.dart';
import 'package:example/widgets/toast.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class _WidgetDef {
  final String title;
  final String cliName;
  final IconData icon;
  final String description;
  final String code;
  final Widget page;

  const _WidgetDef({
    required this.title,
    required this.cliName,
    required this.icon,
    required this.description,
    required this.code,
    required this.page,
  });
}

const _widgets = [
  _WidgetDef(
    title: 'Button',
    cliName: 'button',
    icon: TablerIcons.click,
    description:
        'A versatile button with multiple variants: primary, secondary, ghost, destructive, outline, and link.',
    code: '''// Primary button
Button(
  onPressed: () {},
  label: 'Click me',
  variant: ButtonVariant.primary,
)

// Small with icon
Button.small(
  onPressed: () {},
  label: 'Small',
  icon: Icon(Icons.add),
)''',
    page: ButtonPage(),
  ),
  _WidgetDef(
    title: 'Toggle',
    cliName: 'toggle',
    icon: TablerIcons.toggle_left,
    description:
        'A switch control for toggling between on and off states. Supports drag interaction.',
    code: '''Toggle(
  value: isOn,
  onChanged: (value) {
    setState(() => isOn = value);
  },
)''',
    page: TogglePage(),
  ),
  _WidgetDef(
    title: 'InfoBanner',
    cliName: 'info_banner',
    icon: TablerIcons.info_circle,
    description:
        'A banner for displaying contextual messages with success, error, warning, and info variants.',
    code: '''InfoBanner(
  type: InfoBannerType.info,
  title: 'Update available',
  description: 'A new version is ready to install.',
)''',
    page: InfoBannerPage(),
  ),
  _WidgetDef(
    title: 'CardBox',
    cliName: 'card_box',
    icon: TablerIcons.square,
    description:
        'A container with optional border and tap interaction for grouping content.',
    code: '''// Static
CardBox(
  child: Text('Card content'),
)

// Clickable
CardBox(
  onTap: () {},
  child: Text('Clickable card'),
)''',
    page: CardBoxPage(),
  ),
  _WidgetDef(
    title: 'SingleChoice',
    cliName: 'single_choice',
    icon: TablerIcons.circle_dot,
    description: 'A radio-style selector for picking one option from a list.',
    code: '''SingleChoice<String>(
  value: selected,
  onChanged: (value) {
    setState(() => selected = value);
  },
  items: [
    SingleChoiceItem(value: 'a', label: 'Option A'),
    SingleChoiceItem(value: 'b', label: 'Option B'),
  ],
)''',
    page: SingleChoicePage(),
  ),
  _WidgetDef(
    title: 'MultiChoice',
    cliName: 'multi_choice',
    icon: TablerIcons.checkbox,
    description:
        'A checkbox-style selector for picking multiple options from a list.',
    code: '''MultiChoice<String>(
  values: selected,
  onChanged: (values) {
    setState(() => selected = values);
  },
  items: [
    MultiChoiceItem(value: 'a', label: 'Option A'),
    MultiChoiceItem(value: 'b', label: 'Option B'),
  ],
)''',
    page: MultiChoicePage(),
  ),
  _WidgetDef(
    title: 'Tile',
    cliName: 'tile',
    icon: TablerIcons.layout_list,
    description:
        'A list item with leading, title, subtitle, and trailing slots.',
    code: '''Tile(
  leading: Icon(Icons.person),
  title: 'John Doe',
  subtitle: 'john@example.com',
  onTap: () {},
)''',
    page: TilePage(),
  ),
  _WidgetDef(
    title: 'ToggleTile',
    cliName: 'toggle_tile',
    icon: TablerIcons.list_check,
    description: 'A tile with an integrated toggle switch.',
    code: '''ToggleTile(
  title: 'Notifications',
  subtitle: 'Receive push notifications',
  value: isEnabled,
  onChanged: (value) {
    setState(() => isEnabled = value);
  },
)''',
    page: ToggleTilePage(),
  ),
  _WidgetDef(
    title: 'SingleChoiceTile',
    cliName: 'single_choice_tile',
    icon: TablerIcons.list,
    description:
        'A tile-based radio selector for picking one option from a list.',
    code: '''SingleChoiceTile<String>(
  value: selected,
  onChanged: (value) {
    setState(() => selected = value);
  },
  items: [
    SingleChoiceTileItem(value: 'a', title: 'Option A'),
    SingleChoiceTileItem(value: 'b', title: 'Option B'),
  ],
)''',
    page: SingleChoiceTilePage(),
  ),
  _WidgetDef(
    title: 'MultiChoiceTile',
    cliName: 'multi_choice_tile',
    icon: TablerIcons.list_details,
    description: 'A tile-based checkbox selector for picking multiple options.',
    code: '''MultiChoiceTile<String>(
  values: selected,
  onChanged: (values) {
    setState(() => selected = values);
  },
  items: [
    MultiChoiceTileItem(value: 'a', title: 'Option A'),
    MultiChoiceTileItem(value: 'b', title: 'Option B'),
  ],
)''',
    page: MultiChoiceTilePage(),
  ),
  _WidgetDef(
    title: 'SearchField',
    cliName: 'search_field',
    icon: TablerIcons.search,
    description: 'A search input field with built-in icon and clear button.',
    code: '''SearchField(
  onChanged: (query) {
    // filter results
  },
  placeholder: 'Search...',
)''',
    page: SearchFieldPage(),
  ),
  _WidgetDef(
    title: 'Picker',
    cliName: 'picker',
    icon: TablerIcons.selector,
    description:
        'A dropdown-style selector for picking a value from a list of options.',
    code: '''Picker<String>(
  value: selected,
  onChanged: (value) {
    setState(() => selected = value);
  },
  items: [
    PickerItem(value: 'a', label: 'Option A'),
    PickerItem(value: 'b', label: 'Option B'),
  ],
)''',
    page: PickerPage(),
  ),
  _WidgetDef(
    title: 'Toast',
    cliName: 'toast',
    icon: TablerIcons.message,
    description:
        'A temporary notification that appears at the top of the screen.',
    code: '''Toast.show(
  context: context,
  message: 'Changes saved',
  type: ToastType.success,
)''',
    page: ToastPage(),
  ),
  _WidgetDef(
    title: 'Spinner',
    cliName: 'spinner',
    icon: TablerIcons.loader_2,
    description: 'An animated loading indicator.',
    code: '''// Default
Spinner()

// Custom size
Spinner(size: 16)''',
    page: SpinnerPage(),
  ),
  _WidgetDef(
    title: 'AlertPopup',
    cliName: 'alert_popup',
    icon: TablerIcons.alert_triangle,
    description:
        'A modal dialog for displaying important messages that require acknowledgement.',
    code: '''AlertPopup.show(
  context: context,
  title: 'Something went wrong',
  description: 'Please try again later.',
)''',
    page: AlertPopupPage(),
  ),
  _WidgetDef(
    title: 'ConfirmationPopup',
    cliName: 'confirmation_popup',
    icon: TablerIcons.circle_check,
    description:
        'A modal dialog for confirming destructive or important actions.',
    code: '''ConfirmationPopup.show(
  context: context,
  title: 'Delete item?',
  description: 'This action cannot be undone.',
  onConfirm: () {
    // delete
  },
)''',
    page: ConfirmationPopupPage(),
  ),
  _WidgetDef(
    title: 'Popup',
    cliName: 'popup',
    icon: TablerIcons.app_window,
    description: 'A base modal dialog for building custom popup content.',
    code: '''Popup.show(
  context: context,
  builder: (context) {
    return Text('Custom content');
  },
)''',
    page: PopupPage(),
  ),
  _WidgetDef(
    title: 'PopoverMenu',
    cliName: 'popover_menu',
    icon: TablerIcons.menu_2,
    description: 'A context menu that appears anchored to a trigger widget.',
    code: '''// Imperative — call from any tap handler
PopoverMenu.show(
  context: context,
  items: [
    PopoverMenuItem(
      label: 'Edit',
      onTap: () {},
    ),
    PopoverMenuItem(
      label: 'Delete',
      onTap: () {},
      isDestructive: true,
    ),
  ],
)

// Declarative — wraps a trigger widget
PopoverMenu(
  items: [
    PopoverMenuItem(
      label: 'Edit',
      onTap: () {},
    ),
  ],
  child: TappableIcon(
    icon: Icon(Icons.more_vert),
    onPressed: () {},
  ),
)''',
    page: PopoverMenuPage(),
  ),
  _WidgetDef(
    title: 'CopyButton',
    cliName: 'copy_button',
    icon: TablerIcons.copy,
    description:
        'A button that copies a value to the clipboard with visual feedback.',
    code: '''CopyButton(
  value: 'Text to copy',
  onCopied: () {
    // show feedback
  },
)''',
    page: CopyButtonPage(),
  ),
  _WidgetDef(
    title: 'NavBar',
    cliName: 'nav_bar',
    icon: TablerIcons.layout_navbar,
    description:
        'Adaptive navigation — side rail on desktop, bottom bar on mobile.',
    code: '''NavBar(
  currentIndex: _index,
  onTap: (i) => setState(() => _index = i),
  items: [
    NavBarItem(icon: Icon(Icons.home), label: 'Home'),
    NavBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ],
  body: pages[_index],
)''',
    page: NavBarPage(),
  ),
  _WidgetDef(
    title: 'EmptyState',
    cliName: 'empty_state',
    icon: TablerIcons.inbox,
    description:
        'A placeholder for empty lists or screens with an icon, title, and description.',
    code: '''EmptyState(
  icon: Icon(Icons.inbox),
  title: 'No items yet',
  description: 'Create your first item to get started.',
)''',
    page: EmptyStatePage(),
  ),
  _WidgetDef(
    title: 'TappableIcon',
    cliName: 'tappable_icon',
    icon: TablerIcons.hand_click,
    description: 'An icon button with hover and tap feedback.',
    code: '''TappableIcon(
  icon: Icon(Icons.more_vert),
  onPressed: () {},
)''',
    page: TappableIconPage(),
  ),
  _WidgetDef(
    title: 'SegmentBar',
    cliName: 'segment_bar',
    icon: TablerIcons.layout_columns,
    description: 'A horizontal group of selectable segments with icon and label. Supports scroll and wrap layouts.',
    code: '''SegmentBar(
  index: _selected,
  onChanged: (i) => setState(() => _selected = i),
  items: [
    SegmentItem(icon: Icon(Icons.home), label: 'Home'),
    SegmentItem(icon: Icon(Icons.settings), label: 'Settings'),
    SegmentItem(label: 'About'),
  ],
)

// Wrap layout
SegmentBar(
  index: _selected,
  onChanged: (i) => setState(() => _selected = i),
  layout: SegmentBarLayout.wrap,
  items: [...],
)''',
    page: _SegmentBarDemoPage(),
  ),
];

class WidgetsPage extends StatefulWidget {
  const WidgetsPage({super.key});

  @override
  State<WidgetsPage> createState() => _WidgetsPageState();
}

class _WidgetsPageState extends State<WidgetsPage> {
  int _selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final comp = _widgets[_selectedSegment];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Widgets', style: context.typography.display),
          const SizedBox(height: 8),
          Text(
            '${_widgets.length} ready-to-use widgets. No Material, no Cupertino. But works with them too.',
            style: context.typography.body.muted(context),
          ),
          const SizedBox(height: 24),
          SegmentBar(
            index: _selectedSegment,
            onChanged: (i) => setState(() => _selectedSegment = i),
            layout: SegmentBarLayout.wrap,
            items: [
              for (final c in _widgets)
                SegmentItem(icon: Icon(c.icon), label: c.title),
            ],
          ),
          const SizedBox(height: 48),
          // Title + CLI command
          Row(
            children: [
              Text(comp.title, style: context.typography.heading),
              const SizedBox(width: 8),
              CopyButton(
                value: 'orient_ui add ${comp.cliName}',
                onCopied: () {
                  Toast.show(
                    context: context,
                    message: 'Copied: orient_ui add ${comp.cliName}',
                    type: ToastType.success,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Description
          Text(
            comp.description,
            style: context.typography.body.muted(context),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= Style.breakpoints.desktop;

              final preview = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Preview', style: context.typography.subtitle),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      border: Border.all(color: style.colors.border),
                      borderRadius: BorderRadius.circular(Style.radii.medium),
                    ),
                    child: comp.page,
                  ),
                ],
              );

              final usage = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Usage', style: context.typography.subtitle),
                  const SizedBox(height: 12),
                  CodeBlock(code: comp.code),
                ],
              );

              if (!isWide) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    preview,
                    const SizedBox(height: 32),
                    usage,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: preview),
                  const SizedBox(width: 32),
                  Expanded(child: usage),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SegmentBarDemoPage extends StatefulWidget {
  const _SegmentBarDemoPage();

  @override
  State<_SegmentBarDemoPage> createState() => _SegmentBarDemoPageState();
}

class _SegmentBarDemoPageState extends State<_SegmentBarDemoPage> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'This playground uses SegmentBar for its own widget navigation above. '
          'Resize your browser window to see the wrap layout adapt.',
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: style.colors.mutedForeground,
          ),
        ),
        const SizedBox(height: 24),
        SegmentBar(
          index: _selected,
          onChanged: (i) => setState(() => _selected = i),
          items: const [
            SegmentItem(icon: Icon(TablerIcons.home), label: 'Home'),
            SegmentItem(icon: Icon(TablerIcons.settings), label: 'Settings'),
            SegmentItem(label: 'About'),
          ],
        ),
      ],
    );
  }
}
