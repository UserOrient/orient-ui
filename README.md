<p align="center">
  <h1 align="center">Orient UI</h1>
  <p align="center">Theming and widgets for Flutter. Works with Material, Cupertino, or on its own.</p>
</p>

<p align="center">
  <a href="https://widgets.userorient.com">Live Demo</a> •
  <a href="https://app.userorient.com">See in Production</a> •
  <a href="https://pub.dev/packages/orient_ui">Pub.dev</a>
</p>

<p align="center">
  <a href="https://twitter.com/kamranbekirovyz">
    <img src="https://img.shields.io/twitter/follow/kamranbekirovyz?style=social">
  </a>
  <a href="https://twitter.com/userorient">
    <img src="https://img.shields.io/twitter/follow/userorient?style=social">
  </a>
</p>

<p align="center">
  <img src="https://ui.userorient.com/_next/image?url=%2Fassets%2Fui%2Fhero.png&w=1920&q=75" alt="Orient UI Widgets" />
</p>

## 🧩 What is Orient UI?

Orient UI gives you two things:

1. **`Style`** is a simple, Material-independent theming system. Colors, typography, radii, durations, breakpoints. All in one file you own. No `ThemeExtension`, no boilerplate.
2. **Widgets** are neutral widgets (buttons, toggles, popovers, navigation, and more) that work on mobile, web, and desktop.

Use both, or just the theming. Your call.

## 🪩 Why Orient UI?

- **Nothing to replace.** Keep your `MaterialApp`, your `Scaffold`, your existing widgets. Orient UI sits alongside them.
- **You own the code.** Every file lives in your project. Change anything you want. No package lock-in.
- **Cross-platform.** Responsive layouts, hover states, keyboard navigation. Mobile, web, and desktop.
- **Zero dependencies.** Nothing added to your pubspec.

## 🏁 Getting Started

### 1. Install the CLI

```bash
dart pub global activate orient_ui
```

### 2. Add theming

```bash
orient_ui init
```

This creates `lib/style.dart` with light/dark colors, typography, radii, durations, and breakpoints. **You own this file.** Move it, rename it, extend it.

Use it anywhere:

```dart
final ColorTokens colors = context.style.colors;
final TextStyle heading = context.typography.heading;
```

That's it. If all you need is theming, you're done.

### 3. Add widgets (optional)

```bash
orient_ui add button
```

This creates `lib/button.dart`. Update the style import to match where you placed `style.dart`:

```dart
import 'package:your_app/style.dart'; // adjust to your path
```

```dart
Button(
  label: 'Click me',
  onPressed: () {},
)
```

### Dark Mode

Widgets follow system brightness by default. To control it manually:

```dart
Style(
  brightness: Brightness.dark,
  child: MaterialApp(
    home: MyHomePage(),
  ),
)
```

## 🧬 Customizing

Open `style.dart` and make it yours. Add color tokens, change typography scales, adjust breakpoints.

```dart
final ColorTokens _colorsLight = ColorTokens(
  background: Color(0xFFFFFFFF),
  foreground: Color(0xFF2A2A2A),
  accent: Color(0xFF18181B),
  // ... change these to match your brand
);
```

## 🗺️ Roadmap

### Available Now
- [x] Button (6 variants)
- [x] Spinner
- [x] NavBar (Navigation Rail + Bottom Bar)
- [x] Toast
- [x] EmptyState
- [x] CopyButton
- [x] Popup
- [x] AlertPopup
- [x] ConfirmationPopup
- [x] SearchField
- [x] CardBox
- [x] Tile
- [x] Toggle
- [x] ToggleTile
- [x] SingleChoice
- [x] SingleChoiceTile
- [x] MultiChoice
- [x] MultiChoiceTile
- [x] Typography
- [x] Picker
- [x] InfoBanner
- [x] PopoverMenu
- [x] TappableIcon
- [x] SegmentBar
- [x] Tag
- [x] Tabs

### Coming Soon
- [ ] TextField
- [ ] VerticalTile
- [ ] AdaptivePageTransition
- [ ] DashedBorder

Try them at the [interactive demo](https://widgets.userorient.com).

## 🧪 Quality

![Tests](https://github.com/userorient/orient-ui/actions/workflows/test.yml/badge.svg?branch=main)

All widgets are tested.

## License

[MIT](https://raw.githubusercontent.com/userorient/orient-ui/main/LICENSE)

---

Built by [UserOrient](https://app.userorient.com)
