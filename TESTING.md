# Testing Methodology

## Overview

Tests live in `example/test/` because templates don't have imports. The example app has working widgets with proper imports.

## Run Tests

```bash
cd example && flutter test
```

## File Structure

```
example/test/
  test_helper.dart      # Shared utilities
  {widget}_test.dart    # One file per widget
```

## Test Structure

Every widget test follows this structure:

```dart
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/widgets/{widget}.dart';

import 'test_helper.dart';

void main() {
  group('{Widget}', () {
    group('rendering', () {
      // Widget renders without error
      // All variants render
      // Optional props render (icon, header, etc.)
    });

    group('states', () {
      // Loading state
      // Disabled state
      // Active/selected state
      // Hover state (if applicable)
    });

    group('interaction', () {
      // onTap/onPressed callbacks fire
      // Callbacks receive correct values
      // Disabled prevents interaction
    });

    group('accessibility', () {
      // Semantics widget present
      // Correct labels
      // Enabled/disabled flags
    });

    group('theming', () {
      // Renders in light mode
      // Renders in dark mode
    });
  });
}
```

## Test Helper

Use `test_helper.dart` utilities:

```dart
// Basic wrapper with Styling
wrapWithStyling(widget, brightness: Brightness.light)

// With custom screen size (for responsive tests)
wrapWithStylingAndSize(widget, size: Size(800, 600), brightness: Brightness.light)
```

## Naming Conventions

- File: `{widget}_test.dart` (e.g., `button_test.dart`)
- Groups: lowercase, category name (e.g., `'rendering'`, `'states'`)
- Tests: descriptive, starts with verb (e.g., `'renders with label'`, `'calls onPressed when tapped'`)

## What to Test

### Rendering
- Widget renders without throwing
- All variants/types render
- Optional props (icon, header, footer) render when provided

### States
- Loading: shows spinner, blocks interaction
- Disabled: reduced opacity, blocks interaction
- Active/Selected: correct styling applied
- Hover: only if critical to functionality

### Interaction
- Callbacks fire on tap/press
- Correct values passed to callbacks
- Disabled state prevents callbacks

### Accessibility
- Semantics widget wraps interactive elements
- Labels are set correctly
- Enabled/disabled flags reflect state

### Theming
- Light mode renders without error
- Dark mode renders without error
- Colors change between modes (visual check optional)

## Example Test

```dart
testWidgets('calls onPressed when tapped', (tester) async {
  var called = false;

  await tester.pumpWidget(wrapWithStyling(
    Button(
      label: 'Tap me',
      onPressed: () => called = true,
    ),
  ));

  await tester.tap(find.byType(Button));
  await tester.pump();

  expect(called, isTrue);
});
```

## CI

Tests run automatically via GitHub Actions on:
- Push to `main`
- Pull requests to `main`

Config: `.github/workflows/test.yml`
