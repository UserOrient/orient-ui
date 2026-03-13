## 0.5.0

* **BREAKING**: `ToastColors` class removed. `success`, `error`, `info`, `warning` are now direct color tokens on `ColorTokens`. 
* Added `InfoBanner`: inline info indicator with info, warning, error, success, neutral variants and optional icon/description.
* Updated `body` typography line height from 18 to 20.
* Redesigned example app pages with interactive controls (toggles, variant tabs) instead of repetitive demos.

## 0.4.2

* Added `Picker` component. Generic dropdown with position-aware menu (opens upward when space is limited).
* Added `borderSubtle` color token for softer container borders (overlays, floating panels).
* Updated package description.

## 0.4.1

* Reshaped README: theming-first narrative, clearer messaging.
* Fixed CLI version.

## 0.4.0

* Added typography tokens: `display`, `heading`, `title`, `subtitle`, `body`, `bodySmall`, `caption`.
* Added `TextStyle` extensions: `.muted()`, `.withColor(color)`, `.withHeight(height)`, `.bold` and weight getters (`.w100`–`.w900`).
* Added `context.style` and `context.typography` extensions.
* Widgets now use typography tokens instead of raw `TextStyle` constructors.
* Fixed deprecated `withOpacity` and `hasFlag` API usages.

## 0.3.1

* Added `SingleChoice` and `SingleChoiceTile` widgets (`Radio` and `RadioListTile` equivalent from Material).
* Added `MultiChoice` and `MultiChoiceTile` widgets (`Checbox` and `CheckboxListTile` equivalent from Material). 
* Fixed `FocusNode` disposal in popup routes to prevent memory leak.

## 0.3.0

* **BREAKING**: `Styling` renamed to `Style`. One word. Clean.
* **BREAKING**: `StyleData` removed. `Style.of(context)` now returns `Style` itself. One class, not two.
* **BREAKING**: `primaryText`/`secondaryText` color tokens renamed to `foreground`/`mutedForeground`.
* `Style` wrapping is now optional. Widgets fall back to platform brightness via `MediaQuery.platformBrightnessOf` when no `Style` widget is in the tree. No crash, no assert.
* `empty_state.dart` no longer imports `material.dart`. All templates are now pure `widgets.dart`.
* SearchField clear button now uses style tokens instead of hardcoded color.

## 0.2.7

* Change API from `showToast()` to `Toast.show()` to make it same with other widgets
* Change in/out animation duration from `DurationTokens.slow` to `DurationTokens.normal`. Now better.

## 0.2.6

* Added new `CardBox` widget. It's what we know from Material as `Card`. Distinctively, it has two modes: bordered and filled (default). Filled looks pretty cool.

## 0.2.5

* Added auto-update mechanism for CLI.

## 0.2.4

* Add new `Tile` widget with 3 variants: simple, bordered and filled.

## 0.2.3

* Add new `ToggleTile` widget with 3 variants: simple, bordered and filled. 
* Add `surfaceContainer` color to the `Styling`, which we used for filled variant of `ToggleTile`.

## 0.2.2

* Added new `Toggle` widget, which comes with haptic feedback, thumb-stretch animation and etc.
* We are going to need an accent color for toggle, radio, checkbox and etc. widgets. So, added `accent` and `accentForeground` color tokens to `Styling`
* Also, I couldn't held myself from making `NavBar`'s both mobile and web/desktop labels to have 1 max lines.

## 0.2.1

* Added new `SearchField` widget with keyboard action support
* Two style presets: universal rounded pill (default) and compact Cupertino-like

## 0.2.0

- **BREAKING**: refactor: `AppColors` renamed to `ColorTokens`                                                                                    
- **BREAKING**: refactor: `Breakpoints` renamed to `BreakpointTokens`                                                                             
- **BREAKING**: refactor: `breakpoints`, `radii`, `durations` now static (no context needed)                                                      
- feat: add `RadiusTokens` (small, medium, large)                                                                                                 
- feat: add `DurationTokens` (fast, normal, slow)                                                                                                 
- refactor: restructure styling.dart (customizable values at top) 
  
## 0.1.6

* Added new `AlertPopup` widget.

## 0.1.5

* Upps! Forgot to add `AlertPopup` to CLI commands. Done.

## 0.1.4

* Added `AlertPopup` widget.
* Converted `ConfirmationPopup` from overlay to roue.

## 0.1.3

* Added press animation to `Button`

## 0.1.2

* Added new widget: `CopyButton`.

## 0.1.1

* Fixed `ConfirmationPopup`'s mobile responsiveness.
* Fixed `Button` text overflow.

## 0.1.0

* Added new widget: `ConfirmationPopup`.
* Updated README.

## 0.0.9

* Renamed `Empty` to `EmptyState`.
* Added tests for `EmptyState`.

## 0.0.8

* Added new widget: `Empty`.
* Refactored `Styling` class.

## 0.0.7

* Added new widget: `Toast`.
* Moved button-related colors to separate `ButtonColors`.

## 0.0.6

* Added new widget: `NavBar`
* Written tests for all current widgets.

## 0.0.5

* Improved README documentation

## 0.0.4

* Added accessibility support, focus and keyboard navigation, disabled visual state to `Button`
* Added semantics to `Spinner` for screen reader support

## 0.0.3

* Improved CLI prints to be more helpful

## 0.0.2

* Initial release of CLI

## 0.0.1

* Button component
* Spinner component  
* Theme system with light/dark mode
