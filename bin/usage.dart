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
};
