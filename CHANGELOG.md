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
