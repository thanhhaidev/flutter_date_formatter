import 'package:flutter_date_formatter/src/models/models.dart';

/// Kinyarwanda Locale
class RwLocale extends DateFormatterLocale {
  @override
  String code() => 'rw';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n';

  @override
  RelativeDateTime relativeDateTime() => RwRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => RwShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => RwCalendarDateTime();

  @override
  DurationUnits durationUnits() => RwDurationUnits();

  @override
  DurationUnits shortDurationUnits() => RwShortDurationUnits();
}

/// Kinyarwanda Messages
class RwRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'hashize';
  @override
  String prefixFromNow() => 'mu';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'agahe gato';
  @override
  String aboutAMinute(int minutes) => 'umunota';
  @override
  String minutes(int minutes) => 'iminota $minutes';
  @override
  String aboutAnHour(int minutes) => 'isaha';
  @override
  String hours(int hours) => 'amasaha $hours';
  @override
  String aDay(int hours) => 'umunsi';
  @override
  String days(int days) => 'iminsi $days';
  @override
  String aboutAMonth(int days) => 'ukwezi';
  @override
  String months(int months) => 'amezi $months';
  @override
  String aboutAYear(int year) => 'umwaka';
  @override
  String years(int years) => 'imyaka $years';
  @override
  String wordSeparator() => ' ';
}

/// Kinyarwanda short Messages
class RwShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'ubu';
  @override
  String aboutAMinute(int minutes) => 'umunota';
  @override
  String minutes(int minutes) => 'iminota $minutes';
  @override
  String aboutAnHour(int minutes) => 'isaha';
  @override
  String hours(int hours) => 'amasaha $hours';
  @override
  String aDay(int hours) => 'umunsi';
  @override
  String days(int days) => 'iminsi $days';
  @override
  String aboutAMonth(int days) => 'ukwezi';
  @override
  String months(int months) => 'amezi $months';
  @override
  String aboutAYear(int year) => 'umwaka';
  @override
  String years(int years) => 'imyaka $years';
  @override
  String wordSeparator() => ' ';
}

/// Kinyarwanda calendar date time
class RwCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Uyu munsi saa $time';
  @override
  String nextDay(String time) => 'Ejo hazaza saa $time';
  @override
  String lastDay(String time) => 'Ejo hashize saa $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_weekdays[date.weekday - 1]} saa $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) {
    // Sunday is "Ku cyumweru hashize" (CLDR), since "icyumweru gishize"
    // would read as "last week"; the other days agree with the implied
    // "umunsi" (class 3), "ushize".
    final past = date.weekday == DateTime.sunday ? 'hashize' : 'ushize';
    return '${_weekdays[date.weekday - 1]} $past saa $time';
  }
}

/// Kinyarwanda duration units
class RwDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      seconds == 1 ? 'isegonda 1' : 'amasegonda $seconds';
  @override
  String minutes(int minutes) =>
      minutes == 1 ? 'umunota 1' : 'iminota $minutes';
  @override
  String hours(int hours) => hours == 1 ? 'isaha 1' : 'amasaha $hours';
  @override
  String days(int days) => days == 1 ? 'umunsi 1' : 'iminsi $days';
  @override
  String weeks(int weeks) => weeks == 1 ? 'icyumweru 1' : 'ibyumweru $weeks';
  @override
  String delimiter() => ' ';
}

/// Kinyarwanda short duration units (no common unit abbreviations)
class RwShortDurationUnits extends RwDurationUnits {}

/// Kinyarwanda weekday names, Monday first (`intl` has no `rw` data).
const _weekdays = [
  'Kuwa mbere',
  'Kuwa kabiri',
  'Kuwa gatatu',
  'Kuwa kane',
  'Kuwa gatanu',
  'Kuwa gatandatu',
  'Ku cyumweru',
];
