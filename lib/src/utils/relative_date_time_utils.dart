import 'package:flutter_date_formatter/src/models/models.dart';

/// A utility class for formatting relative date and time.
class RelativeDateTimeUtils {
  RelativeDateTimeUtils._();

  /// Formats the given [datetime] relative to the [clock] time
  /// using the specified [locale].
  /// If [allowFromNow] is true, it allows formatting for future dates.
  /// If [short] is true, it uses a shorter format.
  /// If [withPrefixAndSuffix] is false, it omits the prefix and suffix.
  static String format(
    DateTime datetime,
    DateTime clock,
    Locale locale, {
    bool allowFromNow = false,
    bool short = false,
    bool withPrefixAndSuffix = true,
  }) {
    // Calculate the elapsed time in milliseconds.
    var elapsed =
        clock.millisecondsSinceEpoch - datetime.millisecondsSinceEpoch;
    final relativeDateTime =
        short ? locale.shortRelativeDateTime() : locale.relativeDateTime();
    String prefix;
    String suffix;

    // Determine the prefix and suffix based on
    // whether the date is in the future or past.
    if (allowFromNow && elapsed < 0) {
      elapsed = datetime.isBefore(clock) ? elapsed : elapsed.abs();
      prefix = relativeDateTime.prefixFromNow();
      suffix = relativeDateTime.suffixFromNow();
    } else {
      prefix = relativeDateTime.prefixAgo();
      suffix = relativeDateTime.suffixAgo();
    }

    // Convert elapsed time to various units.
    final num seconds = elapsed / 1000;
    final num minutes = seconds / 60;
    final num hours = minutes / 60;
    final num days = hours / 24;
    final num months = days / 30;
    final num years = days / 365;

    // Determine the appropriate relative time string based on the elapsed time.
    String result;
    if (seconds < 45) {
      result = relativeDateTime.lessThanOneMinute(seconds.round());
    } else if (seconds < 90) {
      result = relativeDateTime.aboutAMinute(minutes.round());
    } else if (minutes < 45) {
      result = relativeDateTime.minutes(minutes.round());
    } else if (minutes < 90) {
      result = relativeDateTime.aboutAnHour(minutes.round());
    } else if (hours < 24) {
      result = relativeDateTime.hours(hours.round());
    } else if (hours < 48) {
      result = relativeDateTime.aDay(hours.round());
    } else if (days < 30) {
      result = relativeDateTime.days(days.round());
    } else if (days < 60) {
      result = relativeDateTime.aboutAMonth(days.round());
    } else if (days < 365) {
      result = relativeDateTime.months(months.round());
    } else if (years < 2) {
      result = relativeDateTime.aboutAYear(months.round());
    } else {
      result = relativeDateTime.years(years.round());
    }

    // Combine the prefix, result, and suffix into the final formatted string.
    if (withPrefixAndSuffix) {
      return [prefix, result, suffix]
          .where((str) => str.isNotEmpty)
          .join(relativeDateTime.wordSeparator());
    }

    return result;
  }
}
