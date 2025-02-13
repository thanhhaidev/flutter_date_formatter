# Flutter Date Formatter

[![pub package](https://img.shields.io/pub/v/flutter_date_formatter.svg)](https://pub.dartlang.org/packages/flutter_date_formatter)

A Flutter package for formatting dates and times in various locales. This package provides utilities for formatting relative dates, ordinal numbers, and more.

## Installation 💻

Install via `flutter pub add`:

```sh
dart pub add flutter_date_formatter
```

## Usage 📖

Import the package:

```dart
import 'package:flutter_date_formatter/flutter_date_formatter.dart';
```

## Prerequisites

Install the `intl` package:

```sh
dart pub add intl
```

Add `initializeDateFormatting()` to the `main` function and import it from `package:intl/date_symbol_data_local.dart`:

```dart
import 'package:intl/date_symbol_data_local.dart'; // Add this import

void main() async {
  await initializeDateFormatting(); // Initialize date formatting
  // Your app initialization code here
}
```

### Formatting Dates

You can format dates using the `FlutterDateFormatter` class:

```dart
DateTime now = DateTime.now();
String pattern = 'do MMMM yyyy';
String formattedDate = FlutterDateFormatter(pattern, 'en').format(now);
print(formattedDate); // Output: 13th February 2025
```

### Formatting Relative Dates

You can format dates relative to the current time using the `formatRelativeDateTime` function:

```dart
DateTime now = DateTime.now();
DateTime pastDate = now.subtract(Duration(days: 5));
String formattedRelativeDate = FlutterDateFormatter.formatRelativeDateTime(
  pastDate,
  locale: 'en',
);
print(formattedRelativeDate); // Output: 5 days ago
```

### Ordinal Numbers

You can get the ordinal representation of a number using the `ordinal` method in the locale classes:

```dart
int number = 1;
String ordinal = EnLocale().ordinal(number);
print(ordinal); // Output: st
```

### Supported Locales

The package supports multiple locales. Here is a list of all supported locales:

- `am` - Amharic
- `ar` - Arabic
- `az` - Azerbaijani
- `be` - Belarusian
- `bn` - Bengali
- `bs` - Bosnian
- `ca` - Catalan
- `cs` - Czech
- `da` - Danish
- `de` - German
- `dv` - Divehi
- `en` - English
- `es` - Spanish
- `et` - Estonian
- `fa` - Persian
- `fi` - Finnish
- `fr` - French
- `gr` - Greek
- `he` - Hebrew
- `hi` - Hindi
- `hr` - Croatian
- `hu` - Hungarian
- `id` - Indonesian
- `it` - Italian
- `ja` - Japanese
- `ka` - Georgian
- `km` - Khmer
- `ko` - Korean
- `ku` - Kurdish
- `lv` - Latvian
- `mn` - Mongolian
- `ms_my` - Malay
- `my` - Burmese
- `nb` - Norwegian Bokmål
- `nl` - Dutch
- `nn` - Norwegian Nynorsk
- `pl` - Polish
- `ps` - Pashto
- `pt` - Portuguese
- `ro` - Romanian
- `ru` - Russian
- `sv` - Swedish
- `th` - Thai
- `tl_PH` - Filipino
- `tr` - Turkish
- `uk` - Ukrainian
- `vi` - Vietnamese
- `zh` - Chinese

## Contributing 🤝

Contributions are welcome! Please open an issue or submit a pull request.

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
