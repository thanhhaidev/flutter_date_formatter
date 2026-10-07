import 'package:flutter_date_formatter/src/models/models.dart';

/// Norwegian-Nynorsk-Norway locale
class NnLocale extends DateFormatterLocale {
  @override
  String code() => 'nn';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => NnRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => NnShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => NnCalendarDateTime();

  @override
  DurationUnits durationUnits() => NnDurationUnits();

  @override
  DurationUnits shortDurationUnits() => NnShortDurationUnits();
}

/// Norwegian-Nynorsk-Norway relative date time
class NnRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'om';
  @override
  String suffixAgo() => 'sidan';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'eit augeblink';
  @override
  String aboutAMinute(int minutes) => 'eit minutt';
  @override
  String minutes(int minutes) => '$minutes minutt';
  @override
  String aboutAnHour(int minutes) => 'rundt ein time';
  @override
  String hours(int hours) => '$hours timar';
  @override
  String aDay(int hours) => 'ein dag';
  @override
  String days(int days) => '$days dagar';
  @override
  String aboutAMonth(int days) => 'omtrent ein månad';
  @override
  String months(int months) => '$months månadar';
  @override
  String aboutAYear(int year) => 'omtrent eit år';
  @override
  String years(int years) => '$years år';
  @override
  String wordSeparator() => ' ';
}

/// Norwegian-Nynorsk-Norway short relative date time
class NnShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'no';
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
  String aboutAMonth(int days) => '~1 mnd';
  @override
  String months(int months) => '$months mnd';
  @override
  String aboutAYear(int year) => '~1 år';
  @override
  String years(int years) => '$years år';
  @override
  String wordSeparator() => ' ';
}

/// Norwegian-Nynorsk-Norway calendar date time
class NnCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'I dag klokka $time';
  @override
  String nextDay(String time) => 'I morgon klokka $time';
  @override
  String lastDay(String time) => 'I går klokka $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_capitalize(_weekdays[date.weekday - 1])} klokka $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'Førre ${_weekdays[date.weekday - 1]} klokka $time';
}

/// Norwegian-Nynorsk-Norway duration units
class NnDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds sekund';
  @override
  String minutes(int minutes) => '$minutes minutt';
  @override
  String hours(int hours) => hours == 1 ? '1 time' : '$hours timar';
  @override
  String days(int days) => days == 1 ? '1 dag' : '$days dagar';
  @override
  String weeks(int weeks) => weeks == 1 ? '1 veke' : '$weeks veker';
  @override
  String delimiter() => ' ';
}

/// Norwegian-Nynorsk-Norway short duration units
class NnShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds s';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String hours(int hours) => '$hours t';
  @override
  String days(int days) => '$days d';
  @override
  String weeks(int weeks) => '$weeks v';
  @override
  String delimiter() => ' ';
}

/// Nynorsk weekday names, Monday first (`intl` has no `nn` data).
const _weekdays = [
  'måndag',
  'tysdag',
  'onsdag',
  'torsdag',
  'fredag',
  'laurdag',
  'sundag',
];

String _capitalize(String text) =>
    text.isEmpty ? text : '${text[0].toUpperCase()}${text.substring(1)}';
