import 'package:flutter_date_formatter/src/models/models.dart';

/// Danish locale
class DaLocale extends DateFormatterLocale {
  @override
  String code() => 'da';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => DaRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => DaShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => DaCalendarDateTime();

  @override
  DurationUnits durationUnits() => DaDurationUnits();

  @override
  DurationUnits shortDurationUnits() => DaShortDurationUnits();
}

/// Danish relative date time
class DaRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'siden';
  @override
  String suffixFromNow() => 'fra nu';
  @override
  String lessThanOneMinute(int seconds) => 'et øjeblik';
  @override
  String aboutAMinute(int minutes) => 'et minut';
  @override
  String minutes(int minutes) => '$minutes minutter';
  @override
  String aboutAnHour(int minutes) => 'omkring en time';
  @override
  String hours(int hours) => '$hours timer';
  @override
  String aDay(int hours) => 'en dag';
  @override
  String days(int days) => '$days dage';
  @override
  String aboutAMonth(int days) => 'omkring en måned';
  @override
  String months(int months) => '$months måneder';
  @override
  String aboutAYear(int year) => 'omkring et år';
  @override
  String years(int years) => '$years år';
  @override
  String wordSeparator() => ' ';
}

/// Danish short relative date time
class DaShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'nu';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '~1 t';
  @override
  String hours(int hours) => '$hours t';
  @override
  String aDay(int hours) => '~1 d';
  @override
  String days(int days) => '$days d';
  @override
  String aboutAMonth(int days) => '~1 md';
  @override
  String months(int months) => '$months md';
  @override
  String aboutAYear(int year) => '~1 år';
  @override
  String years(int years) => '$years år';
  @override
  String wordSeparator() => ' ';
}

/// Danish calendar date time
class DaCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'I dag kl. $time';
  @override
  String nextDay(String time) => 'I morgen kl. $time';
  @override
  String lastDay(String time) => 'I går kl. $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'På $weekday kl. $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'I ${weekday}s kl. $time';
}

/// Danish duration units
class DaDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      seconds == 1 ? '1 sekund' : '$seconds sekunder';
  @override
  String minutes(int minutes) => minutes == 1 ? '1 minut' : '$minutes minutter';
  @override
  String hours(int hours) => hours == 1 ? '1 time' : '$hours timer';
  @override
  String days(int days) => days == 1 ? '1 dag' : '$days dage';
  @override
  String weeks(int weeks) => weeks == 1 ? '1 uge' : '$weeks uger';
  @override
  String delimiter() => ' ';
}

/// Danish short duration units
class DaShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds sek.';
  @override
  String minutes(int minutes) => '$minutes min.';
  @override
  String hours(int hours) => '$hours t.';
  @override
  String days(int days) => '$days d.';
  @override
  String weeks(int weeks) => '$weeks u.';
  @override
  String delimiter() => ' ';
}
