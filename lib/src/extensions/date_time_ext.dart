import 'package:flutter_date_formatter/src/config/date_formatter_config.dart';
import 'package:flutter_date_formatter/src/enums/enums.dart';
import 'package:flutter_date_formatter/src/utils/date_time_utils.dart';

/// Extension methods for the [DateTime] class.
extension DateTimeExtensions on DateTime {
  /// Checks if the DateTime is in the future.
  bool get isFuture => isAfter(DateFormatterConfig.now());

  /// Checks if the DateTime is in the past.
  bool get isPast => isBefore(DateFormatterConfig.now());

  /// Checks if the DateTime is today.
  bool get isToday {
    final now = DateFormatterConfig.now();
    return isSame(now, unit: Unit.day);
  }

  /// Checks if the DateTime is yesterday.
  bool get isYesterday {
    final now = DateFormatterConfig.now();
    final yesterday = now.subDays(1);
    return isSame(yesterday, unit: Unit.day);
  }

  /// Checks if the DateTime is tomorrow.
  bool get isTomorrow {
    final now = DateFormatterConfig.now();
    final tomorrow = now.addDays(1);
    return isSame(tomorrow, unit: Unit.day);
  }

  /// Checks if the DateTime is set as local time.
  bool get isLocal => !isUtc;

  /// Checks if the DateTime is a weekday.
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// Gets the day of the week, adjusted for the start of the week.
  int get dayOfWeek {
    final startOfWeek = DateTimeUtils.getStartOfWeek();
    const weekDays = [1, 2, 3, 4, 5, 6, 7, 1, 2];
    var weekDayIndex = weekday - 1;

    switch (startOfWeek) {
      case StartOfWeek.monday:
        break;
      case StartOfWeek.sunday:
        weekDayIndex += 1;
      case StartOfWeek.saturday:
        weekDayIndex += 2;
    }

    return weekDays[weekDayIndex];
  }

  /// Checks if the year is a leap year.
  bool get isLeapYear {
    return (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
  }

  /// Gets the day of the year.
  int get dayOfYear {
    const dayCount = <int>[
      0,
      0,
      31,
      59,
      90,
      120,
      151,
      181,
      212,
      243,
      273,
      304,
      334,
    ];

    final dayOfTheYear = dayCount[month] + day;

    if (isLeapYear && month > 2) {
      return dayOfTheYear + 1;
    }

    return dayOfTheYear;
  }

  /// Gets the number of days in the month.
  int get daysInMonth {
    return DateTime(year, month + 1, 0).day;
  }

  /// Gets the ISO-8601 week number of the year (1-53).
  ///
  /// Weeks start on Monday, and week 1 is the week that contains the first
  /// Thursday of the year, so the first days of January can belong to the
  /// last week of the previous year, and the last days of December to week 1
  /// of the next year.
  int get weekOfYear {
    int weeksInYear(int year) {
      final jan1 = DateTime(year).weekday;
      final isLeap =
          (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
      return jan1 == DateTime.thursday || (isLeap && jan1 == DateTime.wednesday)
          ? 53
          : 52;
    }

    final week = (dayOfYear - weekday + 10) ~/ 7;
    if (week < 1) return weeksInYear(year - 1);
    if (week > weeksInYear(year)) return 1;
    return week;
  }

  /// Gets the quarter of the year.
  int get quarterOfYear {
    return ((month - 1) / 3).floor() + 1;
  }

  /// Returns the start of the day.
  DateTime get startOfDay => startOf(Unit.day);

  /// Returns the start of the week.
  DateTime get startOfWeek => startOf(Unit.week);

  /// Returns the start of the month.
  DateTime get startOfMonth => startOf(Unit.month);

  /// Returns the start of the year.
  DateTime get startOfYear => startOf(Unit.year);

  /// Returns the start of the quarter.
  DateTime get startOfQuarter {
    final quarter = quarterOfYear;
    return copyWith(month: (quarter - 1) * 3 + 1, day: 1).startOfMonth;
  }

  /// Returns the end of the day.
  DateTime get endOfDay => endOf(Unit.day);

  /// Returns the end of the week.
  DateTime get endOfWeek => endOf(Unit.week);

  /// Returns the end of the month.
  DateTime get endOfMonth => endOf(Unit.month);

  /// Returns the end of the year.
  DateTime get endOfYear => endOf(Unit.year);

  /// Returns the end of the quarter.
  DateTime get endOfQuarter {
    final quarter = quarterOfYear;
    return copyWith(month: quarter * 3, day: 1).endOfMonth;
  }

  /// Get the index of the closest day in the [dates] list.
  int indexOfClosestDay(Iterable<DateTime> dates) {
    var closestIndex = -1;
    int? minDifference;
    var index = 0;

    for (final date in dates) {
      final diff = date.difference(this).inMicroseconds.abs();
      if (minDifference == null || diff < minDifference) {
        closestIndex = index;
        minDifference = diff;
      }
      index++;
    }

    return closestIndex;
  }

  /// Get the closest day to the current one.
  /// Returns `null` if the list is empty.
  DateTime? closestDayTo(Iterable<DateTime> dates) {
    final index = indexOfClosestDay(dates);
    return index == -1 ? null : dates.elementAt(index);
  }

  /// Returns a copy of the DateTime.
  DateTime clone() => DateTime.fromMicrosecondsSinceEpoch(
        microsecondsSinceEpoch,
        isUtc: isUtc,
      );

  /// Moves this date by [days] calendar days, keeping the wall-clock time
  /// even across daylight saving time transitions.
  DateTime _addCalendarDays(int days) =>
      days == 0 ? this : copyWith(day: day + days);

  /// Returns the start of the specified unit of time.
  DateTime startOf(Unit unit) {
    DateTime newDateTime;

    switch (unit) {
      case Unit.microsecond:
        newDateTime = copyWith();

      case Unit.millisecond:
        newDateTime = copyWith(
          microsecond: 0,
        );
      case Unit.second:
        newDateTime = copyWith(
          millisecond: 0,
          microsecond: 0,
        );
      case Unit.minute:
        newDateTime = copyWith(
          second: 0,
          millisecond: 0,
          microsecond: 0,
        );
      case Unit.hour:
        newDateTime = copyWith(
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        );
      case Unit.day:
        newDateTime = copyWith(
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        );
      case Unit.week:
        newDateTime = copyWith(
          day: day - (dayOfWeek - 1),
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        );
      case Unit.month:
        newDateTime = copyWith(
          day: 1,
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        );
      case Unit.year:
        newDateTime = copyWith(
          month: 1,
          day: 1,
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        );
    }

    return newDateTime;
  }

  /// Returns the end of the specified unit of time.
  DateTime endOf(Unit unit) {
    DateTime newDateTime;

    switch (unit) {
      case Unit.microsecond:
        newDateTime = copyWith();
      case Unit.millisecond:
        newDateTime = copyWith(
          microsecond: 999,
        );
      case Unit.second:
        newDateTime = copyWith(
          millisecond: 999,
          microsecond: 999,
        );
      case Unit.minute:
        newDateTime = copyWith(
          second: 59,
          millisecond: 999,
          microsecond: 999,
        );
      case Unit.hour:
        newDateTime = copyWith(
          minute: 59,
          second: 59,
          millisecond: 999,
          microsecond: 999,
        );
      case Unit.day:
        newDateTime = copyWith(
          hour: 23,
          minute: 59,
          second: 59,
          millisecond: 999,
          microsecond: 999,
        );
      case Unit.week:
        newDateTime = copyWith(
          day: day + (DateTime.daysPerWeek - dayOfWeek),
          hour: 23,
          minute: 59,
          second: 59,
          millisecond: 999,
          microsecond: 999,
        );
      case Unit.month:
        newDateTime = copyWith(
          day: daysInMonth,
          hour: 23,
          minute: 59,
          second: 59,
          millisecond: 999,
          microsecond: 999,
        );
      case Unit.year:
        newDateTime = copyWith(
          month: 12,
          day: 31,
          hour: 23,
          minute: 59,
          second: 59,
          millisecond: 999,
          microsecond: 999,
        );
    }

    return newDateTime;
  }

  /// Subtracts the specified duration from the DateTime.
  ///
  /// Days and weeks are calendar days, so the wall-clock time is kept across
  /// daylight saving time transitions. Months and years are clamped to the
  /// last day of the resulting month.
  DateTime subtractDate({
    int microseconds = 0,
    int milliseconds = 0,
    int seconds = 0,
    int minutes = 0,
    int hours = 0,
    int days = 0,
    int weeks = 0,
    int months = 0,
    int years = 0,
  }) {
    var newDateTime = _addCalendarDays(-(days + (weeks * 7))).subtract(
      Duration(
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        milliseconds: milliseconds,
        microseconds: microseconds,
      ),
    );
    newDateTime = DateTimeUtils.addMonths(newDateTime, -months);
    newDateTime = DateTimeUtils.addMonths(newDateTime, -years * 12);
    return newDateTime;
  }

  /// Subtracts an amount of years from this [DateTime]
  DateTime subYears(int amount) => subtractDate(years: amount);

  /// Subtracts an amount of months from this [DateTime]
  DateTime subMonths(int amount) => subtractDate(months: amount);

  /// Subtracts an amount of weeks from this [DateTime]
  DateTime subWeeks(int amount) => subtractDate(weeks: amount);

  /// Subtracts an amount of days from this [DateTime]
  DateTime subDays(int amount) => subtractDate(days: amount);

  /// Subtracts an amount of hours from this [DateTime]
  DateTime subHours(int amount) => subtract(Duration(hours: amount));

  /// Subtracts an amount of minutes from this [DateTime]
  DateTime subMinutes(int amount) => subtract(Duration(minutes: amount));

  /// Subtracts an amount of seconds from this [DateTime]
  DateTime subSeconds(int amount) => subtract(Duration(seconds: amount));

  /// Subtracts an amount of milliseconds from this [DateTime]
  DateTime subMilliseconds(int amount) =>
      subtract(Duration(milliseconds: amount));

  /// Subtracts an amount of microseconds from this [DateTime]
  DateTime subMicroseconds(int amount) =>
      subtract(Duration(microseconds: amount));

  /// Adds the specified duration to the DateTime.
  ///
  /// Days and weeks are calendar days, so the wall-clock time is kept across
  /// daylight saving time transitions. Months and years are clamped to the
  /// last day of the resulting month.
  DateTime addDate({
    int microseconds = 0,
    int milliseconds = 0,
    int seconds = 0,
    int minutes = 0,
    int hours = 0,
    int days = 0,
    int weeks = 0,
    int months = 0,
    int years = 0,
  }) {
    var newDateTime = _addCalendarDays(days + (weeks * 7)).add(
      Duration(
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        milliseconds: milliseconds,
        microseconds: microseconds,
      ),
    );
    newDateTime = DateTimeUtils.addMonths(newDateTime, months);
    newDateTime = DateTimeUtils.addMonths(newDateTime, years * 12);
    return newDateTime;
  }

  /// Adds an amount of years to this [DateTime]
  DateTime addYears(int amount) => addDate(years: amount);

  /// Adds an amount of months to this [DateTime]
  DateTime addMonths(int amount) => addDate(months: amount);

  /// Adds an amount of weeks to this [DateTime]
  DateTime addWeeks(int amount) => addDate(weeks: amount);

  /// Adds an amount of days to this [DateTime]
  DateTime addDays(int amount) => addDate(days: amount);

  /// Adds an amount of hours to this [DateTime]
  DateTime addHours(int amount) => add(Duration(hours: amount));

  /// Adds an amount of minutes to this [DateTime]
  DateTime addMinutes(int amount) => add(Duration(minutes: amount));

  /// Adds an amount of seconds to this [DateTime]
  DateTime addSeconds(int amount) => add(Duration(seconds: amount));

  /// Adds an amount of milliseconds to this [DateTime]
  DateTime addMilliseconds(int amount) => add(Duration(milliseconds: amount));

  /// Adds an amount of microseconds to this [DateTime]
  DateTime addMicroseconds(int amount) => add(Duration(microseconds: amount));

  /// Returns the difference between two DateTime objects in the specified
  /// unit of time.
  num diff(
    DateTime other, {
    Unit unit = Unit.microsecond,
    bool asFloat = false,
  }) {
    final firstDateTimeMicrosecondsSinceEpoch = microsecondsSinceEpoch;
    final secondDateTimeMicrosecondsSinceEpoch = other.microsecondsSinceEpoch;
    final diffMicrosecondsSinceEpoch = firstDateTimeMicrosecondsSinceEpoch -
        secondDateTimeMicrosecondsSinceEpoch;

    num diff;

    switch (unit) {
      case Unit.microsecond:
        diff = diffMicrosecondsSinceEpoch;

      case Unit.millisecond:
        diff = diffMicrosecondsSinceEpoch / Duration.microsecondsPerMillisecond;

      case Unit.second:
        diff = diffMicrosecondsSinceEpoch / Duration.microsecondsPerSecond;

      case Unit.minute:
        diff = diffMicrosecondsSinceEpoch / Duration.microsecondsPerMinute;

      case Unit.hour:
        diff = diffMicrosecondsSinceEpoch / Duration.microsecondsPerHour;

      case Unit.day:
        diff = _calendarMicroseconds(other, diffMicrosecondsSinceEpoch) /
            Duration.microsecondsPerDay;

      case Unit.week:
        diff = _calendarMicroseconds(other, diffMicrosecondsSinceEpoch) /
            Duration.microsecondsPerDay /
            DateTime.daysPerWeek;

      case Unit.month:
        diff = DateTimeUtils.monthDiff(this, other);

      case Unit.year:
        diff = DateTimeUtils.monthDiff(this, other) / 12;
    }

    return asFloat
        ? diff
        : diff < 0
            ? diff.ceil()
            : diff.floor();
  }

  /// Returns [elapsedMicroseconds] corrected by the change in time zone
  /// offset, so that day and week differences count calendar days across
  /// daylight saving time transitions.
  int _calendarMicroseconds(DateTime other, int elapsedMicroseconds) =>
      elapsedMicroseconds +
      (timeZoneOffset - other.timeZoneOffset).inMicroseconds;

  /// Returns the difference between two DateTime objects in years.
  num diffInYears(DateTime other, {bool asFloat = false}) {
    return diff(other, unit: Unit.year, asFloat: asFloat);
  }

  /// Returns the difference between two DateTime objects in months.
  num diffInMonths(DateTime other, {bool asFloat = false}) {
    return diff(other, unit: Unit.month, asFloat: asFloat);
  }

  /// Returns the difference between two DateTime objects in weeks.
  num diffInWeeks(DateTime other, {bool asFloat = false}) {
    return diff(other, unit: Unit.week, asFloat: asFloat);
  }

  /// Returns the difference between two DateTime objects in days.
  num diffInDays(DateTime other, {bool asFloat = false}) {
    return diff(other, unit: Unit.day, asFloat: asFloat);
  }

  /// Returns the difference between two DateTime objects in hours.
  num diffInHours(DateTime other, {bool asFloat = false}) {
    return diff(other, unit: Unit.hour, asFloat: asFloat);
  }

  /// Returns the difference between two DateTime objects in minutes.
  num diffInMinutes(DateTime other, {bool asFloat = false}) {
    return diff(other, unit: Unit.minute, asFloat: asFloat);
  }

  /// Returns the difference between two DateTime objects in seconds.
  num diffInSeconds(DateTime other, {bool asFloat = false}) {
    return diff(other, unit: Unit.second, asFloat: asFloat);
  }

  /// Returns the difference between two DateTime objects in milliseconds.
  num diffInMilliseconds(DateTime other, {bool asFloat = false}) {
    return diff(other, unit: Unit.millisecond, asFloat: asFloat);
  }

  /// Checks if the DateTime is before the specified DateTime in the given
  /// unit of time.
  bool isBeforeDate(DateTime other, {Unit unit = Unit.microsecond}) {
    final firstDateTimeMicrosecondsSinceEpoch = microsecondsSinceEpoch;
    final secondDateTimeMicrosecondsSinceEpoch = other.microsecondsSinceEpoch;

    if (unit == Unit.microsecond) {
      return firstDateTimeMicrosecondsSinceEpoch <
          secondDateTimeMicrosecondsSinceEpoch;
    }

    final endOfFirstDateTimeMicrosecondsSinceEpoch =
        endOf(unit).microsecondsSinceEpoch;

    return endOfFirstDateTimeMicrosecondsSinceEpoch <
        secondDateTimeMicrosecondsSinceEpoch;
  }

  /// Checks if the DateTime is after the specified DateTime in the given
  /// unit of time.
  bool isAfterDate(DateTime other, {Unit unit = Unit.microsecond}) {
    final firstDateTimeMicrosecondsSinceEpoch = microsecondsSinceEpoch;
    final secondDateTimeMicrosecondsSinceEpoch = other.microsecondsSinceEpoch;

    if (unit == Unit.microsecond) {
      return firstDateTimeMicrosecondsSinceEpoch >
          secondDateTimeMicrosecondsSinceEpoch;
    }

    final startOfFirstDateTimeMicrosecondsSinceEpoch =
        startOf(unit).microsecondsSinceEpoch;

    return secondDateTimeMicrosecondsSinceEpoch <
        startOfFirstDateTimeMicrosecondsSinceEpoch;
  }

  /// Checks if the DateTime is the same as the specified DateTime in the given
  /// unit of time.
  bool isSame(DateTime other, {Unit unit = Unit.microsecond}) {
    final firstDateTimeMicrosecondsSinceEpoch = microsecondsSinceEpoch;
    final secondDateTimeMicrosecondsSinceEpoch = other.microsecondsSinceEpoch;

    if (unit == Unit.microsecond) {
      return firstDateTimeMicrosecondsSinceEpoch ==
          secondDateTimeMicrosecondsSinceEpoch;
    }

    final startOfFirstDateTimeMicrosecondsSinceEpoch =
        startOf(unit).microsecondsSinceEpoch;
    final endOfFirstDateTimeMicrosecondsSinceEpoch =
        endOf(unit).microsecondsSinceEpoch;

    return startOfFirstDateTimeMicrosecondsSinceEpoch <=
            secondDateTimeMicrosecondsSinceEpoch &&
        secondDateTimeMicrosecondsSinceEpoch <=
            endOfFirstDateTimeMicrosecondsSinceEpoch;
  }

  /// Checks if the DateTime is in the same day as the specified DateTime.
  bool isSameDay(DateTime other) {
    return isSame(other, unit: Unit.day);
  }

  /// Checks if the DateTime is in the same week as the specified DateTime.
  bool isSameWeek(DateTime other) {
    return isSame(other, unit: Unit.week);
  }

  /// Checks if the DateTime is in the same month as the specified DateTime.
  bool isSameMonth(DateTime other) {
    return isSame(other, unit: Unit.month);
  }

  /// Checks if the DateTime is in the same year as the specified DateTime.
  bool isSameYear(DateTime other) {
    return isSame(other, unit: Unit.year);
  }

  /// Checks if the DateTime is in the same minute as the specified DateTime.
  bool isSameMinute(DateTime other) {
    return isSame(other, unit: Unit.minute);
  }

  /// Checks if the DateTime is in the same hour as the specified DateTime.
  bool isSameHour(DateTime other) {
    return isSame(other, unit: Unit.hour);
  }

  /// Checks if the DateTime is in the same second as the specified DateTime.
  bool isSameSecond(DateTime other) {
    return isSame(other, unit: Unit.second);
  }

  /// Checks if the DateTime is the same or before the specified DateTime
  /// in the given unit of time.
  bool isSameOrBefore(DateTime other, {Unit unit = Unit.microsecond}) {
    return isSame(other, unit: unit) || isBeforeDate(other, unit: unit);
  }

  /// Checks if the DateTime is the same or after the specified DateTime
  /// in the given unit of time.
  bool isSameOrAfter(DateTime other, {Unit unit = Unit.microsecond}) {
    return isSame(other, unit: unit) || isAfterDate(other, unit: unit);
  }

  /// Checks if the DateTime is between the specified start and end DateTime
  /// in the given unit of time.
  bool isBetween(
    DateTime startDateTime,
    DateTime endDateTime, {
    Unit unit = Unit.microsecond,
  }) {
    return isAfterDate(startDateTime, unit: unit) &&
        isBeforeDate(endDateTime, unit: unit);
  }
}
