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
String ordinal = FlutterDateFormatter.ordinal(number, locale: 'en');
print(ordinal); // Output: 1st
```

### DateTime Extensions

The package now includes several new extension methods for the `DateTime` class:

```dart
DateTime date = DateTime.now();
print(date.isToday); // Output: true

String pattern = 'do MMMM yyyy';
String formattedDate = date.format(pattern: pattern, locale: 'en');
print(formattedDate); // Output: 13th February 2025

DateTime pastDate = now.subtract(Duration(days: 5));
String formattedRelativeDate = pastDate.formatRelative(
  locale: 'en',
);
print(formattedRelativeDate); // Output: 5 days ago
```

#### Properties

```dart
isFuture → bool
isPast → bool
isToday → bool
isYesterday → bool
isTomorrow → bool
isLocal → bool
isWeekend → bool
isLeapYear → bool
dayOfWeek → int
dayOfYear → int
weekOfYear → int
quarterOfYear → int
startOfDay → DateTime
startOfWeek → DateTime
startOfMonth → DateTime
startOfYear → DateTime
startOfQuarter → DateTime
endOfDay → DateTime
endOfWeek → DateTime
endOfMonth → DateTime
endOfYear → DateTime
endOfQuarter → DateTime
```

#### Methods

```dart
endOf(Unit unit) → DateTime
startOf(Unit unit) → DateTime
subYears(int amount) → DateTime
subMonths(int amount) → DateTime
subWeeks(int amount) → DateTime
subDays(int amount) → DateTime
subHours(int amount) → DateTime
subMinutes(int amount) → DateTime
subSeconds(int amount) → DateTime
subMilliseconds(int amount) → DateTime
subMicroseconds(int amount) → DateTime
addMonths(int amount) → DateTime
addWeeks(int amount) → DateTime
addDays(int amount) → DateTime
addHours(int amount) → DateTime
addMinutes(int amount) → DateTime
addSeconds(int amount) → DateTime
addMilliseconds(int amount) → DateTime
addMicroseconds(int amount) → DateTime
diff(DateTime other, {Unit unit = Unit.microsecond, bool asFloat = false}) → num
diffInYears(DateTime other, {bool asFloat = false}) → num
diffInMonths(DateTime other, {bool asFloat = false}) → num
diffInWeeks(DateTime other, {bool asFloat = false}) → num
diffInHours(DateTime other, {bool asFloat = false}) → num
diffInMinutes(DateTime other, {bool asFloat = false}) → num
diffInSeconds(DateTime other, {bool asFloat = false}) → num
diffInMilliseconds(DateTime other, {bool asFloat = false}) → num
isSame(DateTime other, {Unit unit = Unit.microsecond}) → bool
isSameOrBefore(DateTime other, {Unit unit = Unit.microsecond}) → bool
isSameOrAfter(DateTime other, {Unit unit = Unit.microsecond}) → bool
isSameDay(DateTime other) → bool
isSameWeek(DateTime other) → bool
isSameMonth(DateTime other) → bool
isSameYear(DateTime other) → bool
isSameMinute(DateTime other) → bool
isBetween(DateTime startDateTime, DateTime endDateTime, {Unit unit = Unit.microsecond}) → bool
format({String? pattern, String? locale}) → String
formatRelative({String? locale, DateTime? clock, bool allowFromNow = false, bool short = false, bool withPrefixAndSuffix = true}) → String
formatFrom({required DateTime clock, String? locale, bool short = false, bool withPrefixAndSuffix = true}) → String
formatFromNow({String? locale, bool short = false, bool withPrefixAndSuffix = true}) → String
formatTo({required DateTime clock, String? locale, bool short = false, bool withPrefixAndSuffix = true}) → String
formatToNow({String? locale, bool short = false, bool withPrefixAndSuffix = true}) → String
formatOrdinalNumber({String? locale}) → String
```

### Register Custom Locales (Add or Override)

You can add or override custom locales in the supported locales list:

```dart
void main() async {
  await initializeDateFormatting();
  // Adding custom locale
  SupportedLocalesUtils.registerLocale('vi_custom', ViLocaleCustom());

  // Overriding locale
  SupportedLocalesUtils.registerLocale('vi', ViLocaleCustom());
}

class ViLocaleCustom extends Locale {
  @override
  String code() => 'vi_custom';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => 'ngày thứ $n';

  // Custom relative time
  @override
  RelativeDateTime relativeDateTime() => ViCustomRelativeTime();

  // Custom short relative time
  @override
  RelativeDateTime shortRelativeDateTime() => ViCustomShortRelativeTime();
}
```

### Supported Locales

The package supports multiple locales. Here is a list of all supported locales:

#### Formatting & Relative Locales Supported

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
- `en` - English
- `es` - Spanish
- `et` - Estonian
- `fa` - Persian
- `fi` - Finnish
- `fr` - French
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
- `lv` - Latvian
- `mn` - Mongolian
- `ms_my` - Malay
- `my` - Burmese
- `nb` - Norwegian Bokmål
- `nl` - Dutch
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

#### Only Supported Relative Locales

- `dv` - Divehi
- `gr` - Greek
- `ku` - Kurdish
- `nn` - Norwegian Nynorsk
- `rw` - Kinyarwanda
- `tk` - Turkish

## Contributing 🤝

Contributions are welcome! Please open an issue or submit a pull request.

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
