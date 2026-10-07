import 'dart:math' as math;

import 'package:flutter_date_formatter/src/config/date_formatter_config.dart';
import 'package:flutter_date_formatter/src/enums/enums.dart';
import 'package:flutter_date_formatter/src/extensions/date_time_ext.dart';
import 'package:flutter_date_formatter/src/locale/locales/en_locale.dart';
import 'package:flutter_date_formatter/src/models/models.dart';
import 'package:flutter_date_formatter/src/utils/intl_utils.dart';
import 'package:flutter_date_formatter/src/utils/utils.dart';
import 'package:intl/intl.dart';

/// A class that formats a [DateTime] object to a string, and parses strings
/// in the same pattern.
///
/// Diagnostics for one pattern attempted by
/// [FlutterDateFormatter.parseAnyDetailed].
class ParseAnyAttempt {
  /// Creates a diagnostic entry for [pattern].
  const ParseAnyAttempt({required this.pattern, this.error});

  /// The pattern that was attempted.
  final String pattern;

  /// The parse error, or `null` when this pattern matched.
  final FormatException? error;

  /// Whether this pattern matched the input.
  bool get matched => error == null;
}

/// The result of [FlutterDateFormatter.parseAnyDetailed].
class ParseAnyResult {
  /// Creates a detailed parse result.
  const ParseAnyResult({required this.value, required this.attempts});

  /// The parsed value, or `null` when all patterns failed.
  final DateTime? value;

  /// Diagnostics in the same order as the supplied patterns.
  final List<ParseAnyAttempt> attempts;

  /// Whether any pattern matched the input.
  bool get matched => value != null;
}

/// An instance can be reused to format and parse any number of dates.
class FlutterDateFormatter {
  /// Creates a new instance of [FlutterDateFormatter].
  ///
  /// [pattern] uses the `intl` [DateFormat] syntax, plus `do` for the day of
  /// the month with its ordinal suffix and `[...]` for literal text.
  /// [locale] defaults to [DateFormatterConfig.locale], then
  /// [Intl.defaultLocale]; see [SupportedLocalesUtils.getLocale] for how it
  /// is resolved.
  FlutterDateFormatter([String? pattern, String? locale])
      : _pattern = pattern,
        _locale = SupportedLocalesUtils.getLocale(locale),
        _intlLocale = IntlUtils.verifiedLocale(locale);

  final String? _pattern;

  /// The package locale used for ordinals.
  final DateFormatterLocale _locale;

  /// The locale passed to `intl`, keeping the requested region (for example
  /// `en_GB` or `pt_BR`) when `intl` has data for it.
  final String? _intlLocale;

  /// Formats the given [datetime] according to the pattern provided.
  ///
  /// Throws a [FormatException] if the pattern is missing or blank.
  String format(DateTime datetime) {
    final pattern = _escapedPattern('datetime `$datetime`');
    final localeOrdinal = _locale.ordinal(datetime.day);
    final newPattern = ReplaceUtils.replaceLocaleOrdinalDatePattern(
      pattern,
      localeOrdinal,
    );
    return _dateFormat(newPattern).format(datetime);
  }

  /// Parses [input] written in this formatter's pattern and locale, the
  /// reverse of [format].
  ///
  /// The `do` token accepts the locale's ordinal suffixes, so
  /// `FlutterDateFormatter('do MMMM yyyy', 'en').parse('21st March 2025')`
  /// returns `DateTime(2025, 3, 21)`.
  ///
  /// With [strict], the input must match the pattern exactly and the values
  /// must be in range (see [DateFormat.parseStrict]). With [utc], the result
  /// is a UTC date.
  ///
  /// Throws a [FormatException] if [input] does not match the pattern, or if
  /// the pattern is missing or blank.
  DateTime parse(String input, {bool strict = false, bool utc = false}) {
    final pattern = _escapedPattern('input `$input`');

    DateTime parseWith(String intlPattern) {
      final dateFormat = _dateFormat(intlPattern);
      return strict
          ? dateFormat.parseStrict(input, utc)
          : dateFormat.parse(input, utc);
    }

    final hasOrdinal =
        ReplaceUtils.replaceLocaleOrdinalDatePattern(pattern, '') != pattern;
    if (!hasOrdinal) {
      try {
        return parseWith(pattern);
      } on FormatException catch (error) {
        throw _parseError(input, error.message);
      }
    }

    // Try each ordinal suffix of the locale, and keep the result whose day
    // actually takes that suffix.
    final suffixes = {for (var day = 1; day <= 31; day++) _locale.ordinal(day)};
    String? reason;
    for (final suffix in suffixes) {
      try {
        final result = parseWith(
          ReplaceUtils.replaceLocaleOrdinalDatePattern(pattern, suffix),
        );
        if (_locale.ordinal(result.day) == suffix) return result;
        reason = 'day ${result.day} does not take the suffix "$suffix"';
      } on FormatException catch (error) {
        reason ??= error.message;
      }
    }
    throw _parseError(input, reason);
  }

  /// A [FormatException] naming the input, the pattern, the locale and an
  /// example of a matching string.
  FormatException _parseError(String input, String? reason) {
    final locale = _intlLocale ?? _locale.code();
    final example = format(DateTime(2025, 3, 21, 14, 30, 45));
    final why = _shortReason(reason);
    return FormatException(
      'Could not parse "$input" with pattern "$_pattern" in locale "$locale"'
      '${why == null ? '' : ': $why'}. '
      'A matching string looks like "$example".',
      input,
    );
  }

  /// Turns an `intl` parse error into a short reason, e.g. "invalid day 30".
  static String? _shortReason(String? reason) {
    if (reason == null) return null;
    final invalid = RegExp(r'invalid (\w+) value: (\S+)').firstMatch(reason);
    if (invalid != null) return 'invalid ${invalid[1]} ${invalid[2]}';
    if (reason.startsWith('Trying to read')) {
      return 'the text does not match the pattern';
    }
    return reason.replaceAll(RegExp(r'[.\s]+$'), '');
  }

  /// Like [parse], but returns `null` instead of throwing when [input] does
  /// not match the pattern.
  DateTime? tryParse(String input, {bool strict = false, bool utc = false}) {
    try {
      return parse(input, strict: strict, utc: utc);
    } on FormatException {
      return null;
    }
  }

  /// Parses [input] with the first matching pattern.
  ///
  /// This is useful when an input may arrive in one of several known
  /// representations, such as `yyyy-MM-dd` or `dd/MM/yyyy`.
  ///
  /// Throws a [FormatException] when none of [patterns] match, and an
  /// [ArgumentError] when [patterns] is empty.
  static DateTime parseAny(
    String input, {
    required List<String> patterns,
    String? locale,
    bool strict = false,
    bool utc = false,
  }) {
    if (patterns.isEmpty) {
      throw ArgumentError.value(patterns, 'patterns', 'Must not be empty');
    }

    FormatException? lastError;
    for (final pattern in patterns) {
      try {
        return FlutterDateFormatter(pattern, locale)
            .parse(input, strict: strict, utc: utc);
      } on FormatException catch (error) {
        lastError = error;
      }
    }
    throw lastError ??
        FormatException('Could not parse "$input" with the provided patterns');
  }

  /// Parses [input] and returns the first matching pattern plus diagnostics
  /// for every pattern attempted.
  static ParseAnyResult parseAnyDetailed(
    String input, {
    required List<String> patterns,
    String? locale,
    bool strict = false,
    bool utc = false,
  }) {
    if (patterns.isEmpty) {
      throw ArgumentError.value(patterns, 'patterns', 'Must not be empty');
    }
    final attempts = <ParseAnyAttempt>[];
    for (final pattern in patterns) {
      try {
        final value = FlutterDateFormatter(pattern, locale)
            .parse(input, strict: strict, utc: utc);
        attempts.add(ParseAnyAttempt(pattern: pattern));
        return ParseAnyResult(value: value, attempts: attempts);
      } on FormatException catch (error) {
        attempts.add(ParseAnyAttempt(pattern: pattern, error: error));
      }
    }
    return ParseAnyResult(value: null, attempts: attempts);
  }

  String _escapedPattern(String subject) {
    final pattern = _pattern ?? '';
    if (pattern.trim().isEmpty) {
      throw FormatException(
        'The provided pattern for $subject cannot be blank',
      );
    }
    return ReplaceUtils.replaceEscapePattern(pattern);
  }

  DateFormat _dateFormat(String intlPattern) {
    IntlUtils.ensureInitialized();
    return DateFormat(intlPattern, _intlLocale ?? _locale.code());
  }

  /// Formats [datetime] relative to [clock] in calendar style:
  ///
  /// - "Today at 3:00 PM", "Yesterday at 3:00 PM", "Tomorrow at 3:00 PM"
  /// - "Last Monday at 3:00 PM" (2 to 6 days ago)
  /// - "Monday at 3:00 PM" (2 to 6 days ahead)
  /// - the date, e.g. "3/4/2025", for anything further away
  ///
  /// [clock] defaults to [DateFormatterConfig.now]. [timePattern] and
  /// [datePattern] replace the locale's default time (`jm`) and date (`yMd`)
  /// formats and accept the same syntax as [format]. Locales without
  /// calendar strings use English.
  static String formatCalendar(
    DateTime datetime, {
    String? locale,
    DateTime? clock,
    String? timePattern,
    String? datePattern,
  }) {
    IntlUtils.ensureInitialized();
    final now = clock ?? DateFormatterConfig.now();
    final date = datetime.isUtc == now.isUtc
        ? datetime
        : (now.isUtc ? datetime.toUtc() : datetime.toLocal());

    final localeData = SupportedLocalesUtils.getRelativeLocale(locale);
    final intlLocale = IntlUtils.resolveLocale(locale, localeData);
    final dayDiff = date.startOfDay
        .diff(now.startOfDay, unit: Unit.day, asFloat: true)
        .round();

    if (dayDiff.abs() > 6) {
      return datePattern == null
          ? DateFormat.yMd(intlLocale).format(date)
          : FlutterDateFormatter(datePattern, locale).format(date);
    }

    final time = timePattern == null
        ? DateFormat.jm(intlLocale).format(date)
        : FlutterDateFormatter(timePattern, locale).format(date);
    final localeCalendar = localeData.calendarDateTime();
    final calendar = localeCalendar ?? EnCalendarDateTime();
    // The English fallback needs English weekday names.
    final weekday = DateFormat.EEEE(localeCalendar == null ? 'en' : intlLocale)
        .format(date);

    final isSameWeek = _startOfCalendarWeek(date, intlLocale) ==
        _startOfCalendarWeek(now, intlLocale);

    return switch (dayDiff) {
      0 => calendar.sameDay(time),
      1 => calendar.nextDay(time),
      -1 => calendar.lastDay(time),
      > 1 => calendar.nextWeek(date, weekday, time, isSameWeek: isSameWeek),
      _ => calendar.lastWeek(date, weekday, time, isSameWeek: isSameWeek),
    };
  }

  /// Formats a date range using a locale-aware date pattern.
  ///
  /// The default pattern is `yMMMd`, which produces output such as
  /// `Mar 1–5, 2025` in English and the corresponding localized dates in
  /// other locales. Pass [pattern] to use the same package pattern syntax as
  /// [format], including `do` ordinals and `[literal]` text.
  ///
  /// If [start] and [end] are the same instant, only one date is returned.
  /// [start] must not be after [end].
  static String formatDateTimeRange(
    DateTime start,
    DateTime end, {
    String? locale,
    String? pattern,
    String separator = ' – ',
  }) {
    IntlUtils.ensureInitialized();
    if (start.isAfter(end)) {
      throw ArgumentError.value(
        end,
        'end',
        'The end of a date range must not be before its start',
      );
    }

    final formatter =
        pattern == null ? null : FlutterDateFormatter(pattern, locale);
    String formatDate(DateTime date) =>
        formatter?.format(date) ??
        DateFormat.yMMMd(
          IntlUtils.resolveLocale(
            locale,
            SupportedLocalesUtils.getRelativeLocale(locale),
          ),
        ).format(date);

    final formattedStart = formatDate(start);
    if (start == end) return formattedStart;
    if (pattern == null &&
        start.year == end.year &&
        start.month == end.month &&
        start.day == end.day) {
      return formattedStart;
    }
    if (pattern == null && start.year == end.year && start.month == end.month) {
      final formattedEnd = formatDate(end);
      final dayStart = DateFormat.d(
        IntlUtils.resolveLocale(
          locale,
          SupportedLocalesUtils.getRelativeLocale(locale),
        ),
      ).format(start);
      final dayEnd = DateFormat.d(
        IntlUtils.resolveLocale(
          locale,
          SupportedLocalesUtils.getRelativeLocale(locale),
        ),
      ).format(end);
      final prefixLength = _commonPrefixLength(formattedStart, formattedEnd);
      final suffixLength = _commonSuffixLength(
        formattedStart,
        formattedEnd,
        prefixLength,
      );
      final prefix = formattedStart.substring(0, prefixLength);
      final suffix = suffixLength == 0
          ? ''
          : formattedStart.substring(formattedStart.length - suffixLength);
      if (formattedStart == '$prefix$dayStart$suffix' &&
          formattedEnd == '$prefix$dayEnd$suffix') {
        return '$prefix$dayStart${separator.trim()}$dayEnd$suffix';
      }
    }
    return '$formattedStart$separator${formatDate(end)}';
  }

  static int _commonPrefixLength(String first, String second) {
    var length = 0;
    final maxLength = math.min(first.length, second.length);
    while (length < maxLength && first[length] == second[length]) {
      length++;
    }
    return length;
  }

  static int _commonSuffixLength(
    String first,
    String second,
    int prefixLength,
  ) {
    var length = 0;
    final maxLength = math.min(first.length, second.length) - prefixLength;
    while (length < maxLength &&
        first[first.length - length - 1] ==
            second[second.length - length - 1]) {
      length++;
    }
    return length;
  }

  /// Returns the first day of the calendar week containing [date], using the
  /// first day of the week of [intlLocale].
  static DateTime _startOfCalendarWeek(DateTime date, String intlLocale) {
    final firstWeekday =
        switch (DateTimeUtils.getStartOfWeek(locale: intlLocale)) {
      StartOfWeek.monday => DateTime.monday,
      StartOfWeek.saturday => DateTime.saturday,
      StartOfWeek.sunday => DateTime.sunday,
    };
    final daysIntoWeek = (date.weekday - firstWeekday) % DateTime.daysPerWeek;
    return date.startOfDay.subDays(daysIntoWeek);
  }

  /// Formats [duration] as text such as "2 hours 5 minutes", or "2h 5m"
  /// when [short] is `true`.
  ///
  /// - [maxUnits] is the most units shown; the rest is truncated.
  /// - [largestUnit] and [smallestUnit] limit the units used, from
  ///   [Unit.week] down to [Unit.second] (defaults: days to seconds).
  /// - [delimiter] replaces the locale's text between units.
  ///
  /// Units with a zero count are skipped, the sign of [duration] is ignored,
  /// and a duration shorter than [smallestUnit] gives a zero count of it
  /// ("0 seconds"). Locales without duration strings use English.
  ///
  /// Throws an [ArgumentError] for unsupported units, a [largestUnit]
  /// smaller than [smallestUnit], or a [maxUnits] below 1.
  static String formatDuration(
    Duration duration, {
    String? locale,
    bool short = false,
    int maxUnits = 2,
    Unit largestUnit = Unit.day,
    Unit smallestUnit = Unit.second,
    String? delimiter,
  }) {
    const microsecondsPerUnit = {
      Unit.week: Duration.microsecondsPerDay * DateTime.daysPerWeek,
      Unit.day: Duration.microsecondsPerDay,
      Unit.hour: Duration.microsecondsPerHour,
      Unit.minute: Duration.microsecondsPerMinute,
      Unit.second: Duration.microsecondsPerSecond,
    };
    for (final unit in [largestUnit, smallestUnit]) {
      if (!microsecondsPerUnit.containsKey(unit)) {
        throw ArgumentError.value(
          unit,
          'unit',
          'Must be week, day, hour, minute or second',
        );
      }
    }
    if (largestUnit.index < smallestUnit.index) {
      throw ArgumentError(
        'largestUnit ($largestUnit) is smaller than smallestUnit '
        '($smallestUnit)',
      );
    }
    if (maxUnits < 1) {
      throw ArgumentError.value(maxUnits, 'maxUnits', 'Must be at least 1');
    }

    final localeData = SupportedLocalesUtils.getRelativeLocale(locale);
    final units = (short
            ? localeData.shortDurationUnits()
            : localeData.durationUnits()) ??
        (short ? EnShortDurationUnits() : EnDurationUnits());

    String unitText(Unit unit, int count) => switch (unit) {
          Unit.week => units.weeks(count),
          Unit.day => units.days(count),
          Unit.hour => units.hours(count),
          Unit.minute => units.minutes(count),
          _ => units.seconds(count),
        };

    var remaining = duration.inMicroseconds.abs();
    final parts = <String>[];
    for (final MapEntry(key: unit, value: unitMicroseconds)
        in microsecondsPerUnit.entries) {
      if (unit.index > largestUnit.index || unit.index < smallestUnit.index) {
        continue;
      }
      final count = remaining ~/ unitMicroseconds;
      remaining -= count * unitMicroseconds;
      if (count > 0) {
        parts.add(unitText(unit, count));
        if (parts.length == maxUnits) break;
      }
    }
    if (parts.isEmpty) {
      parts.add(unitText(smallestUnit, 0));
    }
    return parts.join(delimiter ?? units.delimiter());
  }

  /// Formats provided [datetime] to a fuzzy time like 'a moment ago'
  ///
  /// - If [clock] is passed this will be the point of reference for calculating
  ///   the elapsed time. Defaults to [DateFormatterConfig.now]
  /// - If [short] is passed, format will use the short version of the relative
  ///  time, ie. "5m" for 5 minutes
  /// - If [withPrefixAndSuffix] is passed, format will include the prefix and
  ///  suffix, ie. "5 minutes ago" or "5 minutes from now"
  static String formatRelativeDateTime(
    DateTime datetime, {
    String? locale,
    DateTime? clock,
    bool short = false,
    bool withPrefixAndSuffix = true,
  }) {
    return RelativeDateTimeUtils.format(
      datetime,
      clock ?? DateFormatterConfig.now(),
      SupportedLocalesUtils.getRelativeLocale(locale),
      short: short,
      withPrefixAndSuffix: withPrefixAndSuffix,
    );
  }

  /// Returns the ordinal number for the given [n] in the specified [locale].
  static String ordinal(int n, {String? locale}) {
    return SupportedLocalesUtils.getRelativeLocale(locale).ordinalNumber(n);
  }
}
