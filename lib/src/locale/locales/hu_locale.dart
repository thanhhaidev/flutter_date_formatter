import 'package:flutter_date_formatter/src/models/models.dart';

/// Hungarian Locale
class HuLocale extends DateFormatterLocale {
  @override
  String code() => 'hu';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => HuRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => HuShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => HuCalendarDateTime();

  @override
  DurationUnits durationUnits() => HuDurationUnits();

  @override
  DurationUnits shortDurationUnits() => HuShortDurationUnits();
}

/// Hungarian relative date time
class HuRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'ezelőtt';
  @override
  String suffixFromNow() => 'múlva';
  @override
  String lessThanOneMinute(int seconds) => 'kevesebb, mint egy perc';
  @override
  String aboutAMinute(int minutes) => 'kb. egy perc';
  @override
  String minutes(int minutes) => '$minutes perc';
  @override
  String aboutAnHour(int minutes) => 'kb. 1 óra';
  @override
  String hours(int hours) => '$hours óra';
  @override
  String aDay(int hours) => 'egy nap';
  @override
  String days(int days) => '$days nap';
  @override
  String aboutAMonth(int days) => 'kb. egy hónap';
  @override
  String months(int months) => '$months hónap';
  @override
  String aboutAYear(int year) => 'kb. egy év';
  @override
  String years(int years) => '$years év';
  @override
  String wordSeparator() => ' ';
}

/// Hungarian short relative date time
class HuShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'kevesebb, mint egy perc';
  @override
  String aboutAMinute(int minutes) => 'kb. 1 perc';
  @override
  String minutes(int minutes) => '$minutes perc';
  @override
  String aboutAnHour(int minutes) => 'kb. 1 óra';
  @override
  String hours(int hours) => '$hours óra';
  @override
  String aDay(int hours) => 'egy nap';
  @override
  String days(int days) => '$days nap';
  @override
  String aboutAMonth(int days) => 'kb. 1 hónap';
  @override
  String months(int months) => '$months hónap';
  @override
  String aboutAYear(int year) => 'kb. 1 év';
  @override
  String years(int years) => '$years év';
  @override
  String wordSeparator() => ' ';
}

/// Hungarian calendar date time
class HuCalendarDateTime implements CalendarDateTime {
  // Weekday names meaning "on <day>", Monday first ("hétfőn").
  static const _weekdays = [
    'hétfőn',
    'kedden',
    'szerdán',
    'csütörtökön',
    'pénteken',
    'szombaton',
    'vasárnap',
  ];

  @override
  String sameDay(String time) => 'Ma $time-kor';
  @override
  String nextDay(String time) => 'Holnap $time-kor';
  @override
  String lastDay(String time) => 'Tegnap $time-kor';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_capitalize(_weekdays[date.weekday - 1])} $time-kor';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'Múlt ${_weekdays[date.weekday - 1]} $time-kor';
}

/// Hungarian duration units
class HuDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds másodperc';
  @override
  String minutes(int minutes) => '$minutes perc';
  @override
  String hours(int hours) => '$hours óra';
  @override
  String days(int days) => '$days nap';
  @override
  String weeks(int weeks) => '$weeks hét';
  @override
  String delimiter() => ' ';
}

/// Hungarian short duration units
class HuShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds mp';
  @override
  String minutes(int minutes) => '$minutes perc';
  @override
  String hours(int hours) => '$hours ó';
  @override
  String days(int days) => '$days nap';
  @override
  String weeks(int weeks) => '$weeks hét';
  @override
  String delimiter() => ' ';
}

/// Returns [text] with its first letter in upper case.
String _capitalize(String text) =>
    text.isEmpty ? text : '${text[0].toUpperCase()}${text.substring(1)}';
