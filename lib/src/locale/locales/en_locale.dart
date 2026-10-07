import 'package:flutter_date_formatter/src/models/models.dart';

/// English locale
class EnLocale extends DateFormatterLocale {
  @override
  String code() => 'en';

  @override
  String ordinal(int n) => _getOrdinalSuffix(n);

  @override
  String ordinalNumber(int n) => '$n${_getOrdinalSuffix(n)}';

  @override
  RelativeDateTime relativeDateTime() => EnRelativeTime();

  @override
  RelativeDateTime shortRelativeDateTime() => EnShortRelativeTime();

  @override
  CalendarDateTime calendarDateTime() => EnCalendarDateTime();

  @override
  DurationUnits durationUnits() => EnDurationUnits();

  @override
  DurationUnits shortDurationUnits() => EnShortDurationUnits();

  String _getOrdinalSuffix(int n) {
    const ordinals = ['st', 'nd', 'rd', 'th'];
    var suffix = ordinals.last;
    final digit = n % 10;
    if ((digit > 0 && digit < 4) && (n < 11 || n > 13)) {
      suffix = ordinals[digit - 1];
    }
    return suffix;
  }
}

/// English relative date time
class EnRelativeTime extends RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'in';
  @override
  String suffixAgo() => 'ago';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'a few seconds';
  @override
  String aboutAMinute(int minutes) => 'a minute';
  @override
  String minutes(int minutes) => '$minutes minutes';
  @override
  String aboutAnHour(int minutes) => 'an hour';
  @override
  String hours(int hours) => '$hours hours';
  @override
  String aDay(int hours) => 'a day';
  @override
  String days(int days) => '$days days';
  @override
  String aboutAMonth(int days) => 'a month';
  @override
  String months(int months) => '$months months';
  @override
  String aboutAYear(int year) => 'a year';
  @override
  String years(int years) => '$years years';
  @override
  String wordSeparator() => ' ';
}

/// English short relative date time
class EnShortRelativeTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'now';
  @override
  String aboutAMinute(int minutes) => '1m';
  @override
  String minutes(int minutes) => '${minutes}m';
  @override
  String aboutAnHour(int minutes) => '~1h';
  @override
  String hours(int hours) => '${hours}h';
  @override
  String aDay(int hours) => '~1d';
  @override
  String days(int days) => '${days}d';
  @override
  String aboutAMonth(int days) => '~1mo';
  @override
  String months(int months) => '${months}mo';
  @override
  String aboutAYear(int year) => '~1y';
  @override
  String years(int years) => '${years}y';
  @override
  String wordSeparator() => ' ';
}

/// English calendar date time
class EnCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Today at $time';
  @override
  String nextDay(String time) => 'Tomorrow at $time';
  @override
  String lastDay(String time) => 'Yesterday at $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekday at $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      isSameWeek ? '$weekday at $time' : 'Last $weekday at $time';
}

/// English duration units
class EnDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => seconds == 1 ? '1 second' : '$seconds seconds';
  @override
  String minutes(int minutes) => minutes == 1 ? '1 minute' : '$minutes minutes';
  @override
  String hours(int hours) => hours == 1 ? '1 hour' : '$hours hours';
  @override
  String days(int days) => days == 1 ? '1 day' : '$days days';
  @override
  String weeks(int weeks) => weeks == 1 ? '1 week' : '$weeks weeks';
  @override
  String delimiter() => ' ';
}

/// English short duration units
class EnShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '${seconds}s';
  @override
  String minutes(int minutes) => '${minutes}m';
  @override
  String hours(int hours) => '${hours}h';
  @override
  String days(int days) => '${days}d';
  @override
  String weeks(int weeks) => '${weeks}w';
  @override
  String delimiter() => ' ';
}
