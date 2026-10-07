import 'package:flutter_date_formatter/src/config/date_formatter_config.dart';
import 'package:flutter_date_formatter/src/flutter_date_formatter.dart';

/// Extension methods for formatting [DateTime] objects.
extension DateTimeFormatExtensions on DateTime {
  /// Formats the DateTime according to the specified pattern and locale.
  String format({String? pattern, String? locale}) {
    return pattern == null
        ? toIso8601String()
        : FlutterDateFormatter(pattern, locale).format(this);
  }

  /// Formats the DateTime as a relative time.
  String formatRelative({
    String? locale,
    DateTime? clock,
    bool short = false,
    bool withPrefixAndSuffix = true,
  }) {
    return FlutterDateFormatter.formatRelativeDateTime(
      this,
      locale: locale,
      clock: clock,
      short: short,
      withPrefixAndSuffix: withPrefixAndSuffix,
    );
  }

  /// Formats the DateTime as a relative time from the clock time.
  String formatFrom({
    required DateTime clock,
    String? locale,
    bool short = false,
    bool withPrefixAndSuffix = true,
  }) {
    return formatRelative(
      locale: locale,
      clock: clock,
      short: short,
      withPrefixAndSuffix: withPrefixAndSuffix,
    );
  }

  /// Formats the DateTime as a relative time from the current time.
  String formatFromNow({
    String? locale,
    bool short = false,
    bool withPrefixAndSuffix = true,
  }) {
    return formatRelative(
      clock: DateFormatterConfig.now(),
      locale: locale,
      short: short,
      withPrefixAndSuffix: withPrefixAndSuffix,
    );
  }

  /// Formats the DateTime as a relative time to the clock time.
  String formatTo({
    required DateTime clock,
    String? locale,
    bool short = false,
    bool withPrefixAndSuffix = true,
  }) {
    return clock.formatRelative(
      locale: locale,
      clock: this,
      short: short,
      withPrefixAndSuffix: withPrefixAndSuffix,
    );
  }

  /// Formats the DateTime as a relative time to the current time.
  String formatToNow({
    String? locale,
    bool short = false,
    bool withPrefixAndSuffix = true,
  }) {
    return DateFormatterConfig.now().formatRelative(
      locale: locale,
      clock: this,
      short: short,
      withPrefixAndSuffix: withPrefixAndSuffix,
    );
  }

  /// Formats the DateTime as an ordinal number.
  String formatOrdinalNumber({String? locale}) {
    return FlutterDateFormatter.ordinal(day, locale: locale);
  }

  /// Formats the DateTime in calendar style, such as "Today at 3:00 PM" or
  /// "Last Monday at 3:00 PM".
  ///
  /// See [FlutterDateFormatter.formatCalendar].
  String formatCalendar({
    String? locale,
    DateTime? clock,
    String? timePattern,
    String? datePattern,
  }) {
    return FlutterDateFormatter.formatCalendar(
      this,
      locale: locale,
      clock: clock,
      timePattern: timePattern,
      datePattern: datePattern,
    );
  }

  /// Formats this date and [end] as a localized date range.
  ///
  /// See [FlutterDateFormatter.formatDateTimeRange].
  String formatRange(
    DateTime end, {
    String? locale,
    String? pattern,
    String separator = ' – ',
  }) {
    return FlutterDateFormatter.formatDateTimeRange(
      this,
      end,
      locale: locale,
      pattern: pattern,
      separator: separator,
    );
  }
}
