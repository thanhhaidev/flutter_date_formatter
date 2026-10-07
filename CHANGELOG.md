## 0.2.0

### **Added**:

- `DateTime.formatRange` and `FlutterDateFormatter.formatDateTimeRange` for
  smart localized date ranges, including compact same-month output such as
  `Mar 1–5, 2025`.
- `FlutterDateFormatter.parseAny` and `parseAnyDetailed` for trying multiple
  input patterns, with per-pattern diagnostics for import and validation flows.
- Date range presets in the documentation Playground for same-day,
  same-month, cross-month and cross-year examples.
- Documentation for local and UTC `DateTime` behavior without bundling a
  timezone database.
- Expanded Playground sharing and copying fallback for browsers without the
  Clipboard API.

### **Changed**:

- Vietnamese short duration units now use compact localized forms such as
  `1n 2g`.

### **Documentation**:

- Added interactive date range and locale examples.
- Documented `parseAny`, `parseAnyDetailed`, Vietnamese compact duration units,
  region-qualified locales and timezone boundaries.

## 0.1.0

### **Fixed**:

- Literal text in `intl` quotes works in patterns: `dd/MM/yyyy 'at' HH:mm` now gives `07/10/2025 at 09:35` instead of `07/10/2025 'AMt' 09:35`. `''` is a literal apostrophe, and `[text]` keeps working (an apostrophe inside brackets stays literal).
- `FlutterDateFormatter` instances can be reused; the second `format()` call no longer throws `LateInitializationError`.
- Formatting works without calling `initializeDateFormatting()` first, keeps the requested region (`en_GB`, `pt_BR`), and throws a `FormatException` for a blank pattern.
- Locale lookup accepts any case and BCP-47 tags (`zh-cn`, `pt-BR`), uses the full `Intl.defaultLocale`, and falls back to the language code.
- `registerLocale` now also affects relative formatting; `isLocaleSupported` works for region-qualified codes.
- Registered `sk`, `ms`, `el` (Greek, `gr` kept as alias), `zh_TW` and `zh_HK`; removed the `mn_MY` typo.
- Week APIs (`dayOfWeek`, `startOfWeek`, `weekOfYear`, ...) no longer throw for locales such as `de_DE`, `vi_VN`, `en-US` or `C`.
- `weekOfYear` now returns the ISO-8601 week number.
- Day and week arithmetic, `startOf/endOf(Unit.week)`, `isYesterday`/`isTomorrow` and `diff` in days/weeks are correct across daylight saving time.
- `startOfQuarter`/`endOfQuarter` no longer overflow into the wrong month; `clone()` keeps microseconds; `indexOfClosestDay` compares at microsecond resolution.
- `TimeSpan`: fixed `intersects`, `merge`, `getDifference` and `symmetricDifference`; added `getDifferences`, `==`, `hashCode` and `toString`.
- Relative time: equal dates are formatted as past, and values just below a threshold no longer show the next bucket's number (e.g. "45 minutes", "12 months").
- Translation, plural and ordinal fixes in about 35 locales, including ar, az, be, bn, bs, cs, de, el, fr, hi, hr, hu, ku, lv, my, pl, ro, ru, sk, sr, sv, th, ko and zh.

### **Added**:

- `DateFormatterConfig.configure` for a default locale, a start-of-week override and an injectable clock used by every "now"-dependent API (`isToday`, `formatFromNow`, ...).
- Calendar-style formatting: `formatCalendar` ("Today at 3:00 PM", "Yesterday at …", "Last Monday at …") with locale strings for all supported locales, ported from moment.js and checked against CLDR. Weekdays are worded relative to the current week of the locale (e.g. `本周三` / `上周三`).
- Duration humanization: `Duration.humanize` / `FlutterDateFormatter.formatDuration` ("2 hours 5 minutes", "2h 5m") with `maxUnits`, unit limits and locale strings.
- Parsing: `FlutterDateFormatter.parse` and `tryParse`, using the same pattern syntax as `format` (including `do` ordinals), with `strict` and `utc` options.
- Ranges: `DateTime.rangeTo` and `TimeSpan.iterate` (calendar steps, DST-safe); comparison helpers `clamp`, `earliest` and `latest`.
- Optional locale hooks `calendarDateTime()`, `durationUnits()` and `shortDurationUnits()` on `DateFormatterLocale`, falling back to English.
- `DirectionalRelativeDateTime`, an optional interface for locales whose unit texts depend on the direction (past or future). Czech and Slovak use it.
- `TimeSpan.getDifferences`, which returns every remaining part, and `const TimeSpan.fromStart`.
- `pubspec.yaml`: `repository`, `issue_tracker` and `topics`.

### **Changed**:

- Lint rules now follow `very_good_analysis` 7.0.0, and CI fails on infos.
- CI also runs the tests in a time zone with daylight saving time and analyzes with the lowest supported dependencies; publishing runs CI first.

### **Deprecated**:

- `Locale` is renamed to `DateFormatterLocale` to avoid clashing with Flutter's `Locale`. The old name remains as a deprecated typedef.

## 0.0.9

### **Added**:

- **DateTime Extension: Closest Day and TimeSpan Support**:
  - Added `indexOfClosestDay` and `closestDayTo` methods to `DateTime` extension.
  - These methods allow finding the closest day to a given `DateTime` from an iterable of `DateTime` objects.
  - Added the `TimeSpan` class: `fromStart`, `fromEnd` and `fromCenter` constructors, `start`, `end`, `middle` and `totalDuration`, the `with*` copy methods, `contains`, `containsTimeSpan`, `intersects`, `isSame`, `isBefore`/`isAfter` (and `OrSame` variants), `merge`, `getIntersection`, `getDifference` and `symmetricDifference`.
  - Added `isWithin` and `isWithinTimeSpan` to `DateTime`.
- **DateTime Extension: Quarters**:
  - Added `startOfQuarter` and `endOfQuarter`.
- **DateTime Extension: Diff and Clone Methods**:

  - Added `diffInDays`, `diffInSeconds`, and `clone` methods to `DateTime` extension.
  - `diffInDays`: Calculates the difference between two `DateTime` objects in days.
  - `diffInSeconds`: Calculates the difference between two `DateTime` objects in seconds.
  - `clone`: Returns a new `DateTime` object that is a copy of the original.

- **Locale Support**:
  - Added support for adding or overriding custom locales in the application.
  - Users can now define their own locales or extend existing ones to suit custom formatting needs.

## 0.0.8

- Fix ordinal for EN locale

## 0.0.7

- **New Properties**:

  - `isFuture`, `isPast`, `isToday`, `isYesterday`, `isTomorrow`: Check the time relative to the current date.
  - `isLocal`, `isWeekend`, `isLeapYear`: Check specific characteristics of the date (e.g., weekend, leap year).
  - `dayOfWeek`, `dayOfYear`, `weekOfYear`, `quarterOfYear`: Information about the day, week, and month of the year.
  - `startOfDay`, `startOfWeek`, `startOfMonth`, `startOfYear`: Get the start time of a unit of time (day, week, month, year).
  - `endOfDay`, `endOfWeek`, `endOfMonth`, `endOfYear`: Get the end time of a unit of time.

- **New Methods**:

  - `endOf()`, `startOf()`: Get the start or end time of a time unit.
  - `sub*()` and `add*()` (e.g., `subYears()`, `addMonths()`): Add or subtract time from the current date.
  - `diff()`, `isSame()`, `isBetween()`: Compare two dates.
  - `format()`, `formatRelative()`, `formatFromNow()`: Format the date/time into a string, supporting relative time formats.

## 0.0.6

- Get default locale for intl and mapping with supported locale config
- Remove `toLowerCase()` when mapping locale

## 0.0.5

- Remove print log

## 0.0.4

- Add `ordinal` function returns the ordinal number for the given [n] in the specified [locale]

## 0.0.3

- Fix bug `withPrefixAndSuffix` param not working

## 0.0.2

- Add `withPrefixAndSuffix` param for `formatRelativeDateTime` function
- Support short relative date time for ES locale
- Support locale (Georgian - ka, Pashto - ps, Tagalog - tl_PH)

## 0.0.1

- Initial release
