import 'dart:math';

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
    DateFormatterLocale locale, {
    bool short = false,
    bool withPrefixAndSuffix = true,
  }) {
    // Equal dates count as past ("a moment ago"), as in moment.js.
    final isFuture = firstDateTime.isAfter(secondDateTime);

    var relativeDateTime =
        short ? locale.shortRelativeDateTime() : locale.relativeDateTime();
    if (relativeDateTime is DirectionalRelativeDateTime) {
      relativeDateTime = relativeDateTime.forDirection(isFuture: isFuture);
    }
    String prefix;
    String suffix;

    if (isFuture) {
      prefix = relativeDateTime.prefixFromNow();
      suffix = relativeDateTime.suffixFromNow();
    } else {
      prefix = relativeDateTime.prefixAgo();
      suffix = relativeDateTime.suffixAgo();
    }

    // Round first and compare the rounded values, so a value just below a
    // threshold never shows the next bucket's number (e.g. "45 minutes").
    final seconds = firstDateTime
        .diff(secondDateTime, unit: Unit.second, asFloat: true)
        .abs()
        .round();
    final minutes = firstDateTime
        .diff(secondDateTime, unit: Unit.minute, asFloat: true)
        .abs()
        .round();
    final hours = firstDateTime
        .diff(secondDateTime, unit: Unit.hour, asFloat: true)
        .abs()
        .round();
    final days = firstDateTime
        .diff(secondDateTime, unit: Unit.day, asFloat: true)
        .abs()
        .round();
    final months = firstDateTime
        .diff(secondDateTime, unit: Unit.month, asFloat: true)
        .abs()
        .round();
    final years = firstDateTime
        .diff(secondDateTime, unit: Unit.year, asFloat: true)
        .abs();

    String result;

    if (seconds < 45) {
      result = relativeDateTime.lessThanOneMinute(max(1, seconds));
    } else if (seconds < 90) {
      result = relativeDateTime.aboutAMinute(minutes);
    } else if (minutes < 45) {
      result = relativeDateTime.minutes(minutes);
    } else if (minutes < 90) {
      result = relativeDateTime.aboutAnHour(minutes);
    } else if (hours < 24) {
      result = relativeDateTime.hours(hours);
    } else if (hours < 48) {
      result = relativeDateTime.aDay(hours);
    } else if (days < 30) {
      result = relativeDateTime.days(days);
    } else if (days < 60) {
      result = relativeDateTime.aboutAMonth(days);
    } else if (months < 12) {
      result = relativeDateTime.months(months);
    } else if (years < 2) {
      result = relativeDateTime.aboutAYear(months);
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
