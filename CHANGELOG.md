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
