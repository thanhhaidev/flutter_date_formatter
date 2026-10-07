import 'package:flutter_date_formatter/src/models/models.dart';

/// Japanese Locale
class JaLocale extends DateFormatterLocale {
  @override
  String code() => 'ja';

  @override
  String ordinal(int n) => '日';

  @override
  String ordinalNumber(int n) => '第$n';

  @override
  RelativeDateTime relativeDateTime() => JaRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => JaRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => JaCalendarDateTime();

  @override
  DurationUnits durationUnits() => JaDurationUnits();

  @override
  DurationUnits shortDurationUnits() => JaShortDurationUnits();
}

/// Japanese relative date time
class JaRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '今から';
  @override
  String suffixAgo() => '前';
  @override
  String suffixFromNow() => '後';
  @override
  String lessThanOneMinute(int seconds) => '$seconds秒';
  @override
  String aboutAMinute(int minutes) => '約1分';
  @override
  String minutes(int minutes) => '$minutes分';
  @override
  String aboutAnHour(int minutes) => '約1時間';
  @override
  String hours(int hours) => '$hours時間';
  @override
  String aDay(int hours) => '1日';
  @override
  String days(int days) => '$days日';
  @override
  String aboutAMonth(int days) => '約1か月';
  @override
  String months(int months) => '$monthsか月';
  @override
  String aboutAYear(int year) => '約1年';
  @override
  String years(int years) => '$years年';
  @override
  String wordSeparator() => '';
}

/// Japanese calendar date time
class JaCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => '今日 $time';
  @override
  String nextDay(String time) => '明日 $time';
  @override
  String lastDay(String time) => '昨日 $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) {
    return '${isSameWeek ? '' : '来週'}$weekday $time';
  }

  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) {
    return '${isSameWeek ? '' : '先週'}$weekday $time';
  }
}

/// Japanese duration units
class JaDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds秒';
  @override
  String minutes(int minutes) => '$minutes分';
  @override
  String hours(int hours) => '$hours時間';
  @override
  String days(int days) => '$days日';
  @override
  String weeks(int weeks) => '$weeks週間';
  @override
  String delimiter() => '';
}

/// Japanese short duration units
class JaShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds秒';
  @override
  String minutes(int minutes) => '$minutes分';
  @override
  String hours(int hours) => '$hours時間';
  @override
  String days(int days) => '$days日';
  @override
  String weeks(int weeks) => '$weeks週';
  @override
  String delimiter() => '';
}
