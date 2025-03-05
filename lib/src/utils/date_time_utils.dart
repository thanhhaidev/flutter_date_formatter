import 'dart:math';

import 'package:flutter_date_formatter/src/enums/start_of_week.dart';
import 'package:flutter_date_formatter/src/extensions/date_time_ext.dart';
import 'package:intl/date_symbol_data_local.dart' as date_intl;
import 'package:intl/intl.dart';

/// A utility class for DateTime operations.
class DateTimeUtils {
  DateTimeUtils._();

  /// Adds the specified number of months to the given [dateTime].
  ///
  /// The [months] parameter specifies the number of months to add.
  /// If the resulting month has fewer days than the original day,
  /// the day will be adjusted to the last day of the resulting month.
  ///
  /// Returns a new [DateTime] object with the added months.
  static DateTime addMonths(DateTime dateTime, int months) {
    final modMonths = months % 12;
    var newYear = dateTime.year + ((months - modMonths) ~/ 12);
    var newMonth = dateTime.month + modMonths;
    if (newMonth > 12) {
      newYear++;
      newMonth -= 12;
    }
    final newDay = min(dateTime.day, DateTime(newYear, newMonth).daysInMonth);
    return dateTime.copyWith(
      year: newYear,
      month: newMonth,
      day: newDay,
      hour: dateTime.hour,
      minute: dateTime.minute,
      second: dateTime.second,
      millisecond: dateTime.millisecond,
      microsecond: dateTime.microsecond,
    );
  }

  /// Gets the start day of the week based on the locale.
  ///
  /// Returns a [StartOfWeek] enum value representing the start day of the week.
  /// Throws an [Exception] if the locale is not supported.
  static StartOfWeek getStartOfWeek() {
    final locale = Intl.defaultLocale ?? Intl.systemLocale;
    final supportedLocale = date_intl.dateTimeSymbolMap()[locale];

    if (supportedLocale == null) {
      throw Exception("The specified locale '$locale' is not supported.");
    }

    return switch (supportedLocale.FIRSTDAYOFWEEK) {
      0 => StartOfWeek.monday,
      5 => StartOfWeek.saturday,
      6 => StartOfWeek.sunday,
      _ => throw Exception(
          'Start of week with index ${supportedLocale.FIRSTDAYOFWEEK} '
          'not supported'),
    };
  }

  /// Calculates the difference in months between two [DateTime] objects.
  ///
  /// The [firstDateTime] and [secondDateTime] parameters specify the two
  /// dates to compare.
  ///
  /// Returns the difference in months as a [num].
  static num monthDiff(DateTime firstDateTime, DateTime secondDateTime) {
    if (firstDateTime.day < secondDateTime.day) {
      return -DateTimeUtils.monthDiff(secondDateTime, firstDateTime);
    }

    final monthDiff = ((secondDateTime.year - firstDateTime.year) * 12) +
        (secondDateTime.month - firstDateTime.month);

    final thirdDateTime = addMonths(firstDateTime, monthDiff);
    final thirdDateTimeMicrosecondsSinceEpoch =
        thirdDateTime.microsecondsSinceEpoch;

    final diffMicrosecondsSinceEpoch = secondDateTime.microsecondsSinceEpoch -
        thirdDateTimeMicrosecondsSinceEpoch;

    double offset;

    if (diffMicrosecondsSinceEpoch < 0) {
      final fifthDateTime = addMonths(firstDateTime, monthDiff - 1);
      offset = diffMicrosecondsSinceEpoch /
          (thirdDateTimeMicrosecondsSinceEpoch -
              fifthDateTime.microsecondsSinceEpoch);
    } else {
      final fifthDateTime = addMonths(firstDateTime, monthDiff + 1);
      offset = diffMicrosecondsSinceEpoch /
          (fifthDateTime.microsecondsSinceEpoch -
              thirdDateTimeMicrosecondsSinceEpoch);
    }

    return -(monthDiff + offset);
  }
}
