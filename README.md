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

This creates `lib/styling.dart` in your project. **You own this file**: move it wherever you want (e.g., `lib/core/styling.dart`).

### 3. Wrap Your App

Wrap your `MaterialApp` with the `Styling` widget:

```dart
import 'package:your_app/styling.dart'; // adjust path if you moved it

void main() {
  runApp(
    Styling(
      brightness: Brightness.light, // or Brightness.dark
      child: MaterialApp(
        home: MyHomePage(),
      ),
    ),
  );
}
```

### 4. Add Components

```bash
orient_ui add button
```

This creates `lib/button.dart`. Move it wherever you want (e.g., `lib/widgets/button.dart`).

**Important:** Update the import inside the component file to match where you placed `styling.dart`:

```dart
// In button.dart, update this line:
import 'package:your_app/styling.dart'; // adjust to your path
```

### 5. Use Components

```dart
import 'package:your_app/button.dart'; // your path

Button(
  label: 'Click me',
  onPressed: () {},
)
```

## 📦 Available Commands

```bash
orient_ui init          # Initialize styling system
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

### In Progress
- [ ] TextField

### Coming Soon
- [ ] ListTile
- [ ] Tabs
- [ ] InlineTabs
- [ ] Switch
- [ ] SwitchTile
- [ ] Radio
- [ ] RadioTile
- [ ] Menu

## ✅ Quality

![Tests](https://github.com/userorient/orient-ui/actions/workflows/test.yml/badge.svg?branch=main)

All widgets are tested for rendering, interaction, accessibility, and theming.

## ✨ Customizing Colors

The `styling.dart` file contains `AppColors` with light and dark theme defaults. Edit them to match your brand:

```dart
static const light = AppColors(
  primary: Color(0xFF18181B),       // your primary color
  primaryForeground: Color(0xFFFAFAFA),
  // ... customize all colors
);
```

## 📄 License

[MIT](https://raw.githubusercontent.com/userorient/orient-ui/main/LICENSE)

---

Built by the team at [UserOrient](https://app.userorient.com)
