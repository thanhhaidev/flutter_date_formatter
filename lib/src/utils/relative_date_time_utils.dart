import 'package:flutter_date_formatter/src/enums/unit.dart';
import 'package:flutter_date_formatter/src/extensions/date_time_ext.dart';
import 'package:flutter_date_formatter/src/models/models.dart';

/// A utility class for formatting relative date and time.
class RelativeDateTimeUtils {
  RelativeDateTimeUtils._();

  /// Formats the difference between two [DateTime] objects
  /// as a relative time string.
  ///
  /// The [firstDateTime] and [secondDateTime] parameters
  /// specify the two dates to compare.
  /// The [locale] parameter specifies the locale to use for formatting.
  /// The [short] parameter specifies whether to use short format.
  /// The [withPrefixAndSuffix] parameter specifies
  /// whether to include prefix and suffix.
  ///
  /// Returns a [String] representing the relative time difference.
  static String format(
    DateTime firstDateTime,
    DateTime secondDateTime,
    Locale locale, {
    bool short = false,
    bool withPrefixAndSuffix = true,
  }) {
    final isFirstDateTimeSameOrAfterSecondDateTime =
        firstDateTime.isSameOrAfter(secondDateTime);

    final relativeDateTime =
        short ? locale.shortRelativeDateTime() : locale.relativeDateTime();
    String prefix;
    String suffix;

    if (isFirstDateTimeSameOrAfterSecondDateTime) {
      prefix = relativeDateTime.prefixFromNow();
      suffix = relativeDateTime.suffixFromNow();
    } else {
      prefix = relativeDateTime.prefixAgo();
      suffix = relativeDateTime.suffixAgo();
    }

    final seconds = firstDateTime
        .diff(secondDateTime, unit: Unit.second, asFloat: true)
        .abs();
    final minutes = firstDateTime
        .diff(secondDateTime, unit: Unit.minute, asFloat: true)
        .abs();
    final hours = firstDateTime
        .diff(secondDateTime, unit: Unit.hour, asFloat: true)
        .abs();
    final days =
        firstDateTime.diff(secondDateTime, unit: Unit.day, asFloat: true).abs();
    final months = firstDateTime
        .diff(secondDateTime, unit: Unit.month, asFloat: true)
        .abs();
    final years = firstDateTime
        .diff(secondDateTime, unit: Unit.year, asFloat: true)
        .abs();

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

    if (withPrefixAndSuffix) {
      return [prefix, result, suffix]
          .where((str) => str.isNotEmpty)
          .join(relativeDateTime.wordSeparator());
    }

    return result;
  }
}
