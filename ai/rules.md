# Orient UI

This project uses Orient UI — a design system for Flutter. It replaces Material and Cupertino with neutral, customizable components.

## Rules

- **Never use Material or Cupertino widgets for theming or UI components.** Use Orient UI equivalents instead.
- Never hardcode colors, font sizes, radii, or durations. Always use Style tokens.
- To add a component: `orient_ui add <name>`. It prints usage examples — follow them. Don't write Orient UI components from scratch.
- These are plain Dart files in `lib/`, not a package. Edit them directly to customize.
- New custom widgets you create should also use `Style.of(context)` and Orient UI tokens to stay consistent.

## Style System

`lib/style.dart` is the theming foundation. Wrap your app with `Style` widget.

```dart
// Access theme anywhere
final style = Style.of(context);

// Colors
style.colors.background
style.colors.foreground
style.colors.accent
style.colors.border
style.colors.success / .error / .info / .warning
style.colors.button.primary / .secondary / .destructive
style.colors.navigation.railBackground / .bottomBarBackground

// Typography
context.typography.display / .heading / .title / .subtitle / .body / .bodySmall / .caption
style.typography.body.withColor(style.colors.foreground)
textStyle.bold / .w500 / .muted(context)

// Static tokens
Style.radii.small / .medium / .large
Style.durations.fast / .normal / .slow
Style.breakpoints.desktop
```

You can add custom color fields, typography scales, or tokens directly to `lib/style.dart`.

## Components

Use `orient_ui add <name>` to add. Each is a standalone file in `lib/`.

| Instead of | Use | Add command |
|---|---|---|
| ElevatedButton, TextButton, OutlinedButton | `Button` | `orient_ui add button` |
| Switch, CupertinoSwitch | `Toggle` | `orient_ui add toggle` |
| ListTile | `Tile` | `orient_ui add tile` |
| SwitchListTile | `ToggleTile` | `orient_ui add toggle_tile` |
| Radio | `SingleChoice` | `orient_ui add single_choice` |
| RadioListTile | `SingleChoiceTile` | `orient_ui add single_choice_tile` |
| Checkbox | `MultiChoice` | `orient_ui add multi_choice` |
| CheckboxListTile | `MultiChoiceTile` | `orient_ui add multi_choice_tile` |
| AlertDialog, showDialog | `Popup.show()` | `orient_ui add popup` |
| showDialog (confirm) | `ConfirmationPopup.show()` | `orient_ui add confirmation_popup` |
| showDialog (alert) | `AlertPopup.show()` | `orient_ui add alert_popup` |
| SnackBar, ScaffoldMessenger | `Toast.show()` | `orient_ui add toast` |
| CircularProgressIndicator | `Spinner` | `orient_ui add spinner` |
| BottomNavigationBar, NavigationRail | `NavBar` | `orient_ui add nav_bar` |
| TabBar | `Tabs` | `orient_ui add tabs` |
| SegmentedButton | `SegmentBar` | `orient_ui add segment_bar` |
| PopupMenuButton | `PopoverMenu` | `orient_ui add popover_menu` |
| DropdownButton | `Picker` | `orient_ui add picker` |
| TextField (search) | `SearchField` | `orient_ui add search_field` |
| IconButton | `TappableIcon` | `orient_ui add tappable_icon` |
| Chip, Badge | `Tag` | `orient_ui add tag` |
| Card | `CardBox` | `orient_ui add card_box` |
| Banner, MaterialBanner | `InfoBanner` | `orient_ui add info_banner` |
| — | `CopyButton` | `orient_ui add copy_button` |
| — | `EmptyState` | `orient_ui add empty_state` |
