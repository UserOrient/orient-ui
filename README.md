<p align="center">
  <h1 align="center">Orient UI</h1>
  <p align="center">The missing pieces for Flutter Web & Desktop. Finally!</p>
  <p align="center">Beautiful widgets with zero dependencies.</p>
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
  <img src="https://ui.userorient.com/_next/image?url=%2Fassets%2Fui%2Fhero.png&w=1920&q=75" alt="Orient UI Components" />
</p>

## Features

- 🧩 **Works alongside Material.** Add one widget today. No rewrite needed.
- 📦 **You own the code.** Every widget is a file in your project. Edit it however you want.
- 🖥️ **Built for web & desktop.** Hover states, keyboard navigation, responsive out of the box.
- 🔓 **Zero dependencies.** Nothing in your pubspec. No lock-in.
- 🎨 **14 widgets and growing.** Buttons, toggles, popups, navigation, toasts, and more.

## 🎬 Getting Started

### 1. Install the CLI

```bash
dart pub global activate orient_ui
```

### 2. Initialize

Navigate to your Flutter project and run:

```bash
orient_ui init
```

This creates `lib/style.dart` in your project. **You own this file**: move it wherever you want (e.g., `lib/core/style.dart`).

### 3. Add Components

```bash
orient_ui add button
```

This creates `lib/button.dart`. Move it wherever you want (e.g., `lib/widgets/button.dart`).

**Important:** Update the import inside the component file to match where you placed `style.dart`:

```dart
// In button.dart, update this line:
import 'package:your_app/style.dart'; // adjust to your path
```

### 4. Use

```dart
Button(
  label: 'Click me',
  onPressed: () {},
)

// Access your theme anywhere
final ColorTokens colors = context.style.colors;
```

Widgets follow system brightness by default. No wrapping needed.

### Dark Mode

To control dark mode manually, wrap your app with `Style`:

```dart
Style(
  brightness: Brightness.dark,
  child: MaterialApp(
    home: MyHomePage(),
  ),
)
```

## 🛣️ Roadmap

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

### Coming Soon
- [ ] TextField
- [ ] Dropdown
- [ ] Tabs
- [ ] InlineTabs
- [ ] Checkbox
- [ ] Label
- [ ] Tip
- [ ] PopoverMenu
- [ ] PickerPopup
- [ ] VerticalTile
- [ ] SocialButton
- [ ] AdaptivePageTransition

Check them out at [interactive web demo](https://widgets.userorient.com).

## ✅ Quality

![Tests](https://github.com/userorient/orient-ui/actions/workflows/test.yml/badge.svg?branch=main)

All widgets are tested.

## ✨ Customizing Colors

Open `style.dart` and edit the values at the top. That's it. You own the file.

```dart
// Light Theme
final ColorTokens _colorsLight = ColorTokens(
  background: Color(0xFFFFFFFF),
  border: Color(0xFFE4E4E7),
  foreground: Color(0xFF2A2A2A),
  // ... change these to match your brand
);
```

## 📄 License

[MIT](https://raw.githubusercontent.com/userorient/orient-ui/main/LICENSE)

---

Built by the team at [UserOrient](https://app.userorient.com)
