import 'package:flutter_date_formatter/src/models/models.dart';

/// Hebrew Locale
class HeLocale extends DateFormatterLocale {
  @override
  String code() => 'he';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n';

  @override
  RelativeDateTime relativeDateTime() => HeRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => HeShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => HeCalendarDateTime();

  @override
  DurationUnits durationUnits() => HeDurationUnits();

  @override
  DurationUnits shortDurationUnits() => HeShortDurationUnits();
}

/// Hebrew relative date time
class HeRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'לפני';
  @override
  String prefixFromNow() => 'בעוד';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'כמה רגעים';
  @override
  String aboutAMinute(int minutes) => 'דקה';
  @override
  String minutes(int minutes) => '$minutes דקות';
  @override
  String aboutAnHour(int minutes) => 'כשעה';
  @override
  String hours(int hours) => '$hours שעות';
  @override
  String aDay(int hours) => 'יום';
  @override
  String days(int days) => '$days ימים';
  @override
  String aboutAMonth(int days) => 'כחודש';
  @override
  String months(int months) => '$months חודשים';
  @override
  String aboutAYear(int year) => 'כשנה';
  @override
  String years(int years) => '$years שנים';
  @override
  String wordSeparator() => ' ';
}

/// Hebrew short relative date time
class HeShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'כעת';
  @override
  String aboutAMinute(int minutes) => 'דקה';
  @override
  String minutes(int minutes) => '$minutes דקות';
  @override
  String aboutAnHour(int minutes) => 'כשעה';
  @override
  String hours(int hours) => '$hours שעות';
  @override
  String aDay(int hours) => 'יום';
  @override
  String days(int days) => '$days ימים';
  @override
  String aboutAMonth(int days) => 'כחודש';
  @override
  String months(int months) => '$months חודשים';
  @override
  String aboutAYear(int year) => 'כשנה';
  @override
  String years(int years) => '$years שנים';
  @override
  String wordSeparator() => ' ';
}

/// Hebrew calendar date time
class HeCalendarDateTime implements CalendarDateTime {
  // Weekday names without the word "יום", Monday first.
  static const _weekdays = [
    'שני',
    'שלישי',
    'רביעי',
    'חמישי',
    'שישי',
    'שבת',
    'ראשון',
  ];

  @override
  String sameDay(String time) => 'היום ב־$time';
  @override
  String nextDay(String time) => 'מחר ב־$time';
  @override
  String lastDay(String time) => 'אתמול ב־$time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'יום ${_weekdays[date.weekday - 1]} בשעה $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'ביום ${_weekdays[date.weekday - 1]} האחרון בשעה $time';
}

/// Hebrew duration units
class HeDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => seconds == 1 ? 'שנייה אחת' : '$seconds שניות';
  @override
  String minutes(int minutes) => minutes == 1 ? 'דקה אחת' : '$minutes דקות';
  @override
  String hours(int hours) => switch (hours) {
        1 => 'שעה אחת',
        2 => 'שעתיים',
        _ => '$hours שעות',
      };
  @override
  String days(int days) => switch (days) {
        1 => 'יום אחד',
        2 => 'יומיים',
        _ => '$days ימים',
      };
  @override
  String weeks(int weeks) => switch (weeks) {
        1 => 'שבוע אחד',
        2 => 'שבועיים',
        _ => '$weeks שבועות',
      };
  @override
  String delimiter() => ' ';
}

/// Hebrew short duration units
class HeShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds שנ׳';
  @override
  String minutes(int minutes) => '$minutes דק׳';
  @override
  String hours(int hours) => '$hours שע׳';
  @override
  String days(int days) => '$days ימ׳';
  @override
  String weeks(int weeks) => '$weeks שב׳';
  @override
  String delimiter() => ' ';
}
