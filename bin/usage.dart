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
  variant: ButtonVariant.primary, // optional
  loading: false, // optional
)''',
      'Button.small(...) // same, just smaller',
    ],
    hints: [
      'Omit onPressed to disable',
      'Variants: primary, secondary, ghost, destructive, outline, link',
    ],
  ),
};
