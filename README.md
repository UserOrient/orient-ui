<p align="center">
  <h1 align="center">Orient UI</h1>
  <p align="center">Design system for Flutter without Material or Cupertino! 😍</p>
</p>

<p align="center">
  <a href="https://widgets.userorient.com">Live Demo</a> •
  <a href="https://app.userorient.com">See in Production</a> •
  <a href="https://github.com/userorient/orient-ui">Github</a> •
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

- 🌍 **Cross-platform**. Works on iOS, Android, Web, macOS, Windows, and Linux.
- 🎨 **No Material or Cupertino**. Neutral design system with total freedom to customize.
- 📦 **You own the code**. Generated files are yours to modify however you want.
- 🔓 **No lock-in**. No dependency on a package, just plain Dart files in your project.

## 💡 Why Orient UI?

[UserOrient](https://userorient.com) is a feedback SDK for Flutter apps. 

Its web dashboard and mobile app is built with this design system.

Now it's yours to build web and desktop apps with Flutter easier (and also mobile apps).

Want to say thanks? Use <a href="https://userorient.com">UserOrient</a> SDK in your Flutter apps, it's cool!

> [!NOTE]
> Early development. API may change. Building in public on [X/Twitter](https://x.com/kamranebkirovyz). Your feedback and contributions are welcomed!

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
```

Components follow system brightness by default. No wrapping needed.

To control dark mode manually, wrap your app with `Style`:

```dart
Style(
  brightness: Brightness.dark,
  child: MaterialApp(
    home: MyHomePage(),
  ),
)
```

## 📦 Available Commands

```bash
orient_ui init          # Initialize style system
orient_ui add           # List available components
orient_ui add <widget>  # Add a specific widget
```

## 🎨 Components

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
- [x] Toggle
- [x] ToggleTile
- [x] Tile
- [x] CardBox

### In Progress
- [ ] TextField

### Coming Soon
- [ ] Tabs
- [ ] InlineTabs
- [ ] Radio
- [ ] RadioTile
- [ ] Menu

Check them out at [interactive web demo](https://widgets.userorient.com).

## ✅ Quality

![Tests](https://github.com/userorient/orient-ui/actions/workflows/test.yml/badge.svg?branch=main)

All widgets are tested for rendering, interaction, accessibility, and theming.

## ✨ Customizing Colors

Open `style.dart` and edit the constants at the top. That's it. You own the file.

```dart
// Light Theme - Base
const Color _lightBackground = Color(0xFFFFFFFF);
const Color _lightBorder = Color(0xFFE4E4E7);
const Color _lightForeground = Color(0xFF2A2A2A);
// ... change these to match your brand
```

## 📄 License

[MIT](https://raw.githubusercontent.com/userorient/orient-ui/main/LICENSE)

---

Built by the team at [UserOrient](https://app.userorient.com)
