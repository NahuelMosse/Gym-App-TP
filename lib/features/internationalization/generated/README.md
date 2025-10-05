# Auto-generated localization files

These files are produced by `flutter gen-l10n` from the ARB files located in:

```
lib/features/internationalization/translations/
```

Do NOT edit the files in this folder manually. They will be overwritten the next time `flutter gen-l10n` runs.

## Files in this directory:

- `translations.dart` - Main abstract class (import this in your code)
- `translations_en.dart` - English implementation (auto-generated)
- `translations_es.dart` - Spanish implementation (auto-generated)

## How to update translations:

1. Edit or add ARB files in `lib/features/internationalization/translations/` (for example `en.arb`, `es.arb`).
2. Run:

```bash
flutter gen-l10n
```

## Usage in code:

```dart
import 'package:gym_app/features/internationalization/generated/translations.dart';

// In your widget:
final translations = Translations.of(context);
Text(translations.welcomeToGymApp);

// In MaterialApp:
MaterialApp(
  localizationsDelegates: Translations.localizationsDelegates,
  supportedLocales: Translations.supportedLocales,
  // ...
);
```

## Note:

This directory is expected to be committed if you want reproducible builds; alternatively run `flutter gen-l10n` in CI before building.

