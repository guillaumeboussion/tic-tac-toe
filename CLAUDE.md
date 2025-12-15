# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter application for a tic-tac-toe game. The project uses a design system architecture pattern with a custom theme system called "AppTheme".

## Development Commands

### Running the App
```bash
flutter run
```

### Code Generation
The project uses `build_runner` for code generation (freezed, auto_route, json_serializable):
```bash
# Run code generation once
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes and regenerate
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Linting
```bash
flutter analyze
```

### Dependency Management
```bash
# Get dependencies
flutter pub get

# Update dependencies
flutter pub upgrade
```

### Platform-Specific Runs
```bash
# Run on iOS
flutter run -d ios

# Run on Android
flutter run -d android
```

## Architecture

### State Management
- **Riverpod** (`flutter_riverpod: ^2.6.1`) is used for state management
- Providers are defined in `lib/core/presentation/providers/`
- Widgets should use `ConsumerWidget` or `ConsumerStatefulWidget` to access providers

### Routing
- **AutoRoute** (`auto_route: ^9.2.0`) is configured for navigation
- Route generation requires running `build_runner` after adding new routes
- The scaffold widget (`AppScaffold`) integrates with AutoRoute for back navigation

### Design System Structure

The codebase includes a comprehensive design system located in `lib/core/design/`:

#### Theme System (`lib/core/design/theme/`)
- **AppTheme**: InheritedWidget-based theme system
- Access theme data via: `AppTheme.of(context)`
- Theme components in `theme/data/`:
  - `colors.dart` - Color palette and gradients (`AppColorsData`)
  - `typography.dart` - Text styles (`AppTypographyData`)
  - `spacing.dart` - Spacing constants (`AppSpacingData`)
  - `radius.dart` - Border radius values (`AppRadiusData`)
  - `shadows.dart` - Box shadow definitions (`AppBoxShadowsData`)
  - `gradients.dart` - Gradient definitions (`AppGradientsData`)

#### Reusable Widgets (`lib/core/design/widgets/`)

**Button System** (`widgets/buttons/app_button.dart`):
- `AppPrimaryButton` - Primary actions with variants (`.light`)
- `AppSecondaryButton` - Secondary actions with variants (`.bold`)
- `AppOutlinedButton` - Outlined style with variants (`.bold`)
- `AppPriceableButton` - Special button with price badge
- `AppPurchaseButton` - Premium gradient button
- All buttons extend `AppBaseButton` abstract class with consistent API

**Base Widgets** (`widgets/base/`):
- `AppScaffold` - Standard page scaffold with integrated navigation
- `AppText` - Typography components with theme integration
- `app_text_form_field.dart` - Form input fields
- Toast/notification components

**Phone Input** (`widgets/phone/`):
- Phone number input widget
- OTP/SMS verification input

### Error Reporting
- `ReportingService` in `lib/core/presentation/providers/reporting_service_provider.dart` handles error capture
- Configured with `runZonedGuarded` in `main.dart` to catch unhandled exceptions
- Placeholder for Sentry or similar service integration

## Critical Notes

### Code Generation Dependencies
The project includes freezed, auto_route_generator, and json_serializable as dev dependencies, but no generated files (`.g.dart`, `.freezed.dart`) exist yet. If you add models with freezed annotations or routes, you must run `build_runner` to generate the required code.

### Design System Theme Access
Always access theme values through `AppTheme.of(context)` rather than `Theme.of(context)` when working with the custom design system:
```dart
final colors = AppTheme.of(context).colors;
final spacing = AppTheme.of(context).spacing;
final typography = AppTheme.of(context).typography;
```

NEVER USE custom int value for spacing (using SizedBox ie)
ALWAYS USE theme colors

### Running commands
ALWAYS USE `fvm` when running flutter or dart commands

### No Test Suite
There is currently no `test/` directory. When adding tests, create the directory structure and use `flutter test` to run them.
