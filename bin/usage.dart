class Usage {
  final List<String> code;
  final List<String> hints;

  const Usage({
    this.code = const [],
    this.hints = const [],
  });
}

const Map<String, Usage> usageMap = {
  'button': Usage(
    code: [
      '''Button(
  onPressed: () {},
  label: 'Click me',
  icon: Icon(Icons.add), // optional
  variant: ButtonVariant.primary, // .primary, .secondary, .ghost, .destructive, .outline, .link
  loading: false, // optional
)''',
      'Button.small(...) // same, just smaller',
    ],
    hints: [
      'Omit onPressed to disable',
      'Variants: primary, secondary, ghost, destructive, outline, link',
    ],
  ),
  'toggle': Usage(
    code: [
      '''Toggle(
  value: isOn,
  onChanged: (value) {
    setState(() => isOn = value);
  },
)''',
      'Toggle.small(...) // same, just smaller',
    ],
    hints: [
      'Omit onChanged to disable',
    ],
  ),
  'info_banner': Usage(
    code: [
      '''InfoBanner(
  title: 'Update available',
  description: 'A new version is ready.', // optional
  variant: InfoBannerVariant.info, // .info, .warning, .error, .success, .neutral
  icon: Icon(Icons.info), // optional
)''',
    ],
  ),
  'card_box': Usage(
    code: [
      '''CardBox(
  child: Text('Content'),
  padding: EdgeInsets.all(16), // optional
  variant: CardBoxVariant.bordered, // .bordered, .filled
  onTap: () {}, // optional
)''',
    ],
    hints: [
      'Omit onTap for a static card',
    ],
  ),
  'single_choice': Usage(
    code: [
      '''SingleChoice<String>(
  value: 'apple',
  groupValue: chosen,
  onChanged: (v) => setState(() => chosen = v),
)
SingleChoice<String>(
  value: 'banana',
  groupValue: chosen,
  onChanged: (v) => setState(() => chosen = v),
)''',
    ],
    hints: [
      'Omit onChanged to disable',
    ],
  ),
  'multi_choice': Usage(
    code: [
      '''MultiChoice(
  value: isChecked,
  onChanged: (value) => setState(() => isChecked = value),
)''',
    ],
    hints: [
      'Omit onChanged to disable',
    ],
  ),
  'tile': Usage(
    code: [
      '''Tile(
  title: 'John Doe',
  subtitle: 'john@example.com', // optional
  leading: Icon(Icons.person), // optional
  trailing: Icon(Icons.chevron_right), // optional
  variant: TileVariant.simple, // .simple, .bordered, .filled
  onTap: () {}, // optional
)''',
    ],
  ),
  'toggle_tile': Usage(
    code: [
      '''ToggleTile(
  title: 'Notifications',
  subtitle: 'Receive push notifications', // optional
  leading: Icon(Icons.bell), // optional
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value), // optional
  variant: TileVariant.simple, // .simple, .bordered, .filled
)''',
    ],
    hints: [
      'Omit onChanged to disable',
    ],
  ),
  'single_choice_tile': Usage(
    code: [
      '''SingleChoiceTile<String>(
  title: 'Apple',
  value: 'apple',
  groupValue: chosen,
  onChanged: (v) => setState(() => chosen = v),
  subtitle: 'A fruit', // optional
  leading: Icon(Icons.apple), // optional
  variant: TileVariant.simple, // .simple, .bordered, .filled
)
SingleChoiceTile<String>(
  title: 'Banana',
  value: 'banana',
  groupValue: chosen,
  onChanged: (v) => setState(() => chosen = v),
)''',
    ],
    hints: [
      'Omit onChanged to disable',
    ],
  ),
  'multi_choice_tile': Usage(
    code: [
      '''MultiChoiceTile(
  title: 'Email notifications',
  subtitle: 'Receive weekly digest', // optional
  leading: Icon(Icons.email), // optional
  value: isChecked,
  onChanged: (value) => setState(() => isChecked = value), // optional
  variant: TileVariant.simple, // .simple, .bordered, .filled
)''',
    ],
    hints: [
      'Omit onChanged to disable',
    ],
  ),
  'search_field': Usage(
    code: [
      '''SearchField(
  onChanged: (query) {}, // optional
  onSubmitted: (query) {}, // optional
  placeholder: 'Search...', // optional
  controller: myController, // optional
  autofocus: false, // optional
)''',
    ],
  ),
  'picker': Usage(
    code: [
      '''Picker<String>(
  items: ['Apple', 'Banana', 'Cherry'],
  value: chosen, // optional
  onChanged: (value) => setState(() => chosen = value), // optional
  label: 'Fruit', // optional
  itemLabel: (item) => item.toUpperCase(), // optional
)''',
    ],
    hints: [
      'Use itemLabel to display custom text (e.g. itemLabel: (user) => user.name)',
    ],
  ),
  'toast': Usage(
    code: [
      '''Toast.show(
  context: context,
  message: 'Changes saved',
  type: ToastType.success, // .success, .error, .info, .warning
  position: ToastPosition.top, // .top, .bottom
)''',
      'Toast.dismissAll() // dismiss all active toasts',
    ],
  ),
  'spinner': Usage(
    code: [
      '''Spinner(color: style.colors.foreground)''',
    ],
  ),
  'alert_popup': Usage(
    code: [
      '''AlertPopup.show(
  context: context,
  title: 'Something went wrong',
  description: 'Please try again later.', // optional
  icon: Icon(Icons.warning), // optional
  action: Button(label: 'OK', onPressed: () {}), // optional
)''',
    ],
  ),
  'confirmation_popup': Usage(
    code: [
      '''ConfirmationPopup.show(
  context: context,
  title: 'Delete item?',
  description: 'This action cannot be undone.', // optional
  confirmLabel: 'Delete',
  cancelLabel: 'Cancel',
  onConfirm: () {},
  onCancel: () {}, // optional
  icon: Icon(Icons.delete), // optional
  destructive: false, // optional
)''',
    ],
    hints: [
      'Set destructive: true for red confirm button',
    ],
  ),
  'popup': Usage(
    code: [
      '''Popup.show(
  context: context,
  title: 'My Popup', // optional
  child: Text('Any content here'),
)''',
    ],
  ),
  'popover_menu': Usage(
    code: [
      '''// Imperative
PopoverMenu.show(
  context: context,
  items: [
    PopoverMenuItem(label: 'Edit', icon: Icon(Icons.edit), onTap: () {}),
    PopoverMenuItem(label: 'Delete', onTap: () {}),
  ],
)''',
      '''// Declarative — wraps a trigger
PopoverMenu(
  items: [...],
  child: TappableIcon(
    icon: Icon(Icons.more_vert),
    onPressed: () {},
  ),
)''',
    ],
  ),
  'copy_button': Usage(
    code: [
      '''CopyButton(
  value: 'Text to copy',
  onCopied: () {}, // optional
)''',
    ],
  ),
  'nav_bar': Usage(
    code: [
      '''NavBar(
  currentIndex: _index,
  onTap: (i) => setState(() => _index = i),
  items: [
    NavBarItem(icon: Icon(Icons.home), label: 'Home'),
    NavBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ],
  body: pages[_index],
  railHeader: Text('My App'), // optional
  railFooter: Text('v1.0'), // optional
  railWidth: 240, // optional, default 240
)''',
    ],
    hints: [
      'Side rail on desktop, bottom bar on mobile — automatic',
    ],
  ),
  'empty_state': Usage(
    code: [
      '''EmptyState(
  title: 'No items yet',
  description: 'Create your first item to get started.', // optional
  icon: Icon(Icons.inbox), // optional
  action: Button(label: 'Create', onPressed: () {}), // optional
)''',
    ],
  ),
  'tappable_icon': Usage(
    code: [
      '''TappableIcon(
  icon: Icon(Icons.more_vert),
  onPressed: () {},
  size: 40, // optional, default 40
  tooltip: 'More options', // optional
)''',
    ],
    hints: [
      'Omit onPressed to disable',
    ],
  ),
  'tag': Usage(
    code: [
      '''Tag(
  label: 'Implemented',
  color: style.colors.success,
)''',
    ],
  ),
  'tabs': Usage(
    code: [
      '''Tabs(
  index: _selected,
  onChanged: (i) => setState(() => _selected = i),
  items: ['Approved', 'Pending', 'Archived'],
)''',
    ],
  ),
  'segment_bar': Usage(
    code: [
      '''SegmentBar(
  index: _selected,
  onChanged: (i) => setState(() => _selected = i),
  items: [
    SegmentItem(icon: Icon(Icons.home), label: 'Home'),
    SegmentItem(icon: Icon(Icons.settings), label: 'Settings'),
    SegmentItem(label: 'About'), // icon optional
  ],
  layout: SegmentBarLayout.scroll, // .scroll, .wrap
)''',
    ],
  ),
};
