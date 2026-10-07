import 'dart:math';

import 'package:flutter_date_formatter/src/config/date_formatter_config.dart';
import 'package:flutter_date_formatter/src/enums/start_of_week.dart';
import 'package:flutter_date_formatter/src/extensions/date_time_ext.dart';
import 'package:intl/date_symbol_data_local.dart' as date_intl;
import 'package:intl/date_symbols.dart';
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
  /// Uses [DateFormatterConfig.startOfWeek] when set, otherwise the locale
  /// data of [locale], or of [Intl.defaultLocale] (or [Intl.systemLocale])
  /// when [locale] is `null`. Region-qualified and BCP-47 tags such as
  /// `de_DE` or `en-US` fall back to their language data.
  /// Returns [StartOfWeek.monday] (ISO-8601) when the locale is unknown or
  /// starts its week on a day not covered by [StartOfWeek].
  static StartOfWeek getStartOfWeek({String? locale}) {
    final configured = DateFormatterConfig.startOfWeek;
    if (configured != null) return configured;

    final symbols = date_intl.dateTimeSymbolMap();
    final verifiedLocale = Intl.verifiedLocale(
      locale ?? Intl.defaultLocale ?? Intl.systemLocale,
      symbols.containsKey,
      onFailure: (_) => null,
    );
    // intl < 0.20 types this map as Map<dynamic, dynamic>.
    final supportedLocale =
        switch (verifiedLocale == null ? null : symbols[verifiedLocale]) {
      final DateSymbols symbols => symbols,
      _ => null,
    };

    return switch (supportedLocale?.FIRSTDAYOFWEEK) {
      5 => StartOfWeek.saturday,
      6 => StartOfWeek.sunday,
      _ => StartOfWeek.monday,
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

    final result = -(monthDiff + offset);
    // Avoid returning -0.0 for equal dates.
    return result == 0 ? 0.0 : result;
  }
}
