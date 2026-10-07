# Flutter Date Formatter

[![pub package](https://img.shields.io/pub/v/flutter_date_formatter.svg)](https://pub.dartlang.org/packages/flutter_date_formatter)

A Dart and Flutter package for formatting dates and times in 55+ locales: patterns with ordinals, relative times ("5 minutes ago"), calendar times ("Yesterday at 3:00 PM"), humanized durations ("2 hours 5 minutes"), parsing, and many `DateTime` helpers.

📚 **Docs & live playground:** https://thanhhaidev.github.io/flutter_date_formatter/ — every example runs the real package in your browser.

## Installation 💻

Install via `dart pub add` (or `flutter pub add` in Flutter projects):

```sh
dart pub add flutter_date_formatter
```

## Usage 📖

Import the package:

```dart
import 'package:flutter_date_formatter/flutter_date_formatter.dart';
```

## Prerequisites

The package loads the bundled `intl` date data on first use, so no setup is required. If you also use `intl`'s `DateFormat` directly, call `initializeDateFormatting()` from `package:intl/date_symbol_data_local.dart` as usual:

```dart
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();
  // Your app initialization code here
}
```

### Configuration

Set a default locale, the first day of the week, or a clock used as "now" (handy in tests):

```dart
DateFormatterConfig.configure(
  locale: 'vi',
  startOfWeek: StartOfWeek.monday,
  clock: () => DateTime(2025, 3, 10, 12),
);

DateTime(2025, 3, 10).isToday; // true, using the configured clock
DateFormatterConfig.reset(); // back to the defaults
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

### Calendar Times

Format a date relative to today, like chat apps and feeds do:

```dart
final now = DateTime(2025, 3, 10, 12); // Monday
DateTime(2025, 3, 10, 15).formatCalendar(clock: now); // Today at 3:00 PM
DateTime(2025, 3, 9, 15).formatCalendar(clock: now); // Yesterday at 3:00 PM
DateTime(2025, 3, 13, 15).formatCalendar(clock: now); // Thursday at 3:00 PM
DateTime(2025, 3, 5, 15).formatCalendar(clock: now); // Last Wednesday at 3:00 PM
DateTime(2025, 2, 1).formatCalendar(clock: now); // 2/1/2025
DateTime(2025, 3, 10, 15).formatCalendar(clock: now, locale: 'vi'); // Hôm nay lúc 15:00
```

Weekdays are worded relative to the current week, using the locale's first day of the week: a day earlier this week is just "Wednesday at 3:00 PM", while one in the previous week is "Last Wednesday at 3:00 PM" (`本周三` / `上周三` in Chinese, `В среду` / `В прошлую среду` in Russian).

`timePattern` and `datePattern` customize the time and the fallback date format.

### Humanized Durations

```dart
const duration = Duration(days: 1, hours: 2, minutes: 5);
duration.humanize(); // 1 day 2 hours
duration.humanize(maxUnits: 3); // 1 day 2 hours 5 minutes
duration.humanize(short: true, maxUnits: 3); // 1d 2h 5m
duration.humanize(largestUnit: Unit.hour); // 26 hours 5 minutes
duration.humanize(locale: 'vi'); // 1 ngày 2 giờ
```

### Parsing

`parse` and `tryParse` read strings written in the same pattern syntax as `format`, including `do` ordinals and `[literal]` text:

```dart
final formatter = FlutterDateFormatter('do MMMM yyyy', 'en');
formatter.parse('21st March 2025'); // DateTime(2025, 3, 21)
formatter.tryParse('not a date'); // null
FlutterDateFormatter('yyyy-MM-dd', 'en').parse('2025-02-30', strict: true); // throws FormatException
```

### Ranges and Comparison

```dart
DateTime(2025, 3, 1).rangeTo(DateTime(2025, 3, 3)); // Mar 1, Mar 2, Mar 3
DateTime(2025, 1, 31).rangeTo(DateTime(2025, 4, 30), unit: Unit.month); // Jan 31, Feb 28, Mar 31, Apr 30
TimeSpan(start, end).iterate(unit: Unit.week); // every week of the span

date.clamp(min, max);
[a, b, c].earliest;
[a, b, c].latest;
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

DateTime pastDate = date.subtract(Duration(days: 5));
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
daysInMonth → int
weekOfYear → int  // ISO-8601 week number
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
clone() → DateTime
indexOfClosestDay(Iterable<DateTime> dates) → int
closestDayTo(Iterable<DateTime> dates) → DateTime?
isWithin(DateTime start, DateTime end) → bool
isWithinTimeSpan(TimeSpan timeSpan) → bool
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
subtractDate({int microseconds, int milliseconds, int seconds, int minutes, int hours, int days, int weeks, int months, int years}) → DateTime
addDate({int microseconds, int milliseconds, int seconds, int minutes, int hours, int days, int weeks, int months, int years}) → DateTime
addYears(int amount) → DateTime
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
diffInDays(DateTime other, {bool asFloat = false}) → num
diffInHours(DateTime other, {bool asFloat = false}) → num
diffInMinutes(DateTime other, {bool asFloat = false}) → num
diffInSeconds(DateTime other, {bool asFloat = false}) → num
diffInMilliseconds(DateTime other, {bool asFloat = false}) → num
isSame(DateTime other, {Unit unit = Unit.microsecond}) → bool
isBeforeDate(DateTime other, {Unit unit = Unit.microsecond}) → bool
isAfterDate(DateTime other, {Unit unit = Unit.microsecond}) → bool
isSameOrBefore(DateTime other, {Unit unit = Unit.microsecond}) → bool
isSameOrAfter(DateTime other, {Unit unit = Unit.microsecond}) → bool
isSameDay(DateTime other) → bool
isSameWeek(DateTime other) → bool
isSameMonth(DateTime other) → bool
isSameYear(DateTime other) → bool
isSameHour(DateTime other) → bool
isSameMinute(DateTime other) → bool
isSameSecond(DateTime other) → bool
isBetween(DateTime startDateTime, DateTime endDateTime, {Unit unit = Unit.microsecond}) → bool
format({String? pattern, String? locale}) → String
formatRelative({String? locale, DateTime? clock, bool short = false, bool withPrefixAndSuffix = true}) → String
formatFrom({required DateTime clock, String? locale, bool short = false, bool withPrefixAndSuffix = true}) → String
formatFromNow({String? locale, bool short = false, bool withPrefixAndSuffix = true}) → String
formatTo({required DateTime clock, String? locale, bool short = false, bool withPrefixAndSuffix = true}) → String
formatToNow({String? locale, bool short = false, bool withPrefixAndSuffix = true}) → String
formatOrdinalNumber({String? locale}) → String
formatCalendar({String? locale, DateTime? clock, String? timePattern, String? datePattern}) → String
rangeTo(DateTime end, {Unit unit = Unit.day, int step = 1}) → Iterable<DateTime>
clamp(DateTime min, DateTime max) → DateTime
```

> Day and week arithmetic (`addDays`, `subWeeks`, `startOfWeek`, `diffInDays`, ...)
> uses calendar days, so the wall-clock time is kept across daylight saving
> time transitions.

### Register Custom Locales (Add or Override)

A custom locale can also override `calendarDateTime()`, `durationUnits()` and `shortDurationUnits()`; when it doesn't, calendar times and durations use English.

You can add or override custom locales in the supported locales list. Locale codes are matched case-insensitively and accept BCP-47 tags (`pt-BR`, `zh-cn`); an unknown region falls back to its language, then to English.

```dart
void main() async {
  await initializeDateFormatting();
  // Adding custom locale
  SupportedLocalesUtils.registerLocale('vi_custom', ViLocaleCustom());

  // Overriding locale
  SupportedLocalesUtils.registerLocale('vi', ViLocaleCustom());
}

class ViLocaleCustom extends DateFormatterLocale {
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

  // Optional: calendar and duration strings (English is used otherwise)
  @override
  CalendarDateTime calendarDateTime() => ViCalendarDateTime();

  @override
  DurationUnits durationUnits() => ViDurationUnits();
}

// To change only a few strings, extend a built-in locale instead:
class ViOrdinalsCustom extends ViLocale {
  @override
  String ordinalNumber(int n) => 'ngày thứ $n';
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
- `el` - Greek (`gr` is kept as an alias)
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
- `ms` / `ms_MY` - Malay
- `my` - Burmese
- `nb` - Norwegian Bokmål
- `nl` - Dutch
- `pl` - Polish
- `ps` - Pashto
- `pt` - Portuguese
- `ro` - Romanian
- `ru` - Russian
- `sk` - Slovak
- `sr` - Serbian
- `sv` - Swedish
- `ta` - Tamil
- `th` - Thai
- `tl_PH` - Filipino
- `tr` - Turkish
- `uk` - Ukrainian
- `ur` - Urdu
- `vi` - Vietnamese
- `zh` / `zh_CN` - Chinese (Simplified)
- `zh_TW` / `zh_HK` - Chinese (Traditional)

#### Only Supported Relative Locales

- `dv` - Divehi
- `ku` - Kurdish
- `nn` - Norwegian Nynorsk
- `rw` - Kinyarwanda
- `tk` - Turkmen

## Contributing 🤝

Contributions are welcome! Please open an issue or submit a pull request.

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
