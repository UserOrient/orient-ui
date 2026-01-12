## Orient UI

<p align="center">
  <img src="https://ui.userorient.com/_next/image?url=%2Fassets%2Fui%2Fhero.png&w=1920&q=75" alt="Orient UI Components" />
</p>

A design system for Flutter by [UserOrient](https://userorient.com) without any dependencies! 😍

Cross-platform components that work perfectly on iOS, Android, Web, macOS, Windows, and Linux.

> [!WARNING]
> Early development. API may change.

> [!NOTE]
> Building in public on [X](https://x.com/kamranebkirovyz). Your feedback and contributions are welcomed!

## 🚀 Getting Started

### 1. Install the CLI

```bash
dart pub global activate orient_ui
```

### 2. Initialize Styling

Navigate to your Flutter project and run:

```bash
orient_ui init
```

This creates `lib/styling.dart` in your project. **You own this file** — move it wherever you want (e.g., `lib/core/styling.dart`).

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

### Coming Soon
- [ ] Toast
- [ ] TextField
- [ ] Bottom Navigation Bar
- [ ] Navigation Rail
- [ ] Empty View
- [ ] Dialog
- [ ] ListTile
- [ ] TabBar
- [ ] SwitchListTile
- [ ] RadioListTile
- [ ] Menu
- [ ] Confirmation Dialog

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
