import 'package:flutter_date_formatter/src/models/models.dart';

/// Divehi Locale
class DvLocale extends DateFormatterLocale {
  @override
  String code() => 'dv';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n';

  @override
  RelativeDateTime relativeDateTime() => DvRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => DvShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => DvCalendarDateTime();

  @override
  DurationUnits durationUnits() => DvDurationUnits();

  @override
  DurationUnits shortDurationUnits() => DvShortDurationUnits();
}

/// Divehi relative date time
class DvRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'ކުރިން';
  @override
  String suffixFromNow() => 'ފަހުން';
  @override
  String lessThanOneMinute(int seconds) => 'ހިނދުކޮޅެއް';
  @override
  String aboutAMinute(int minutes) => 'މިނެޓެއް ހާއިރު';
  @override
  String minutes(int minutes) => '$minutes މިނެޓު';
  @override
  String aboutAnHour(int minutes) => 'ގަޑިއިރެއް ހާއިރު';
  @override
  String hours(int hours) => '$hours ގަޑިއިރު';
  @override
  String aDay(int hours) => 'އެއް ދުވަސް';
  @override
  String days(int days) => '$days ދުވަސް';
  @override
  String aboutAMonth(int days) => 'މަހެއް ހާ ދުވަސް';
  @override
  String months(int months) => '$months މަސް';
  @override
  String aboutAYear(int year) => 'އަހަރެއް ހާ ދުވަސް';
  @override
  String years(int years) => '$years އަހަރު';
  @override
  String wordSeparator() => ' ';
}

/// Divehi short relative date time
class DvShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'މިހާރު';
  @override
  String aboutAMinute(int minutes) => '1 މިނެޓް';
  @override
  String minutes(int minutes) => '$minutes މިނެޓް';
  @override
  String aboutAnHour(int minutes) => '~1 ގ';
  @override
  String hours(int hours) => '$hours ގ';
  @override
  String aDay(int hours) => '~1 ދުވަސް';
  @override
  String days(int days) => '$days ދުވަސް';
  @override
  String aboutAMonth(int days) => '~1 މަސް';
  @override
  String months(int months) => '$months މަސް';
  @override
  String aboutAYear(int year) => '~1 އަހަރު';
  @override
  String years(int years) => '$years އަހަރު';
  @override
  String wordSeparator() => ' ';
}

/// Divehi calendar date time
class DvCalendarDateTime implements CalendarDateTime {
  /// Weekday names from Monday to Sunday (intl has no Divehi data).
  static const List<String> _weekdays = [
    'ހޯމަ',
    'އަންގާރަ',
    'ބުދަ',
    'ބުރާސްފަތި',
    'ހުކުރު',
    'ހޮނިހިރު',
    'އާދިއްތަ',
  ];

  @override
  String sameDay(String time) => 'މިއަދު $time';
  @override
  String nextDay(String time) => 'މާދަމާ $time';
  @override
  String lastDay(String time) => 'އިއްޔެ $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_weekdays[date.weekday - 1]} $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'ފާއިތުވި ${_weekdays[date.weekday - 1]} $time';
}

/// Divehi duration units
class DvDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds ސިކުންތު';
  @override
  String minutes(int minutes) => '$minutes މިނެޓު';
  @override
  String hours(int hours) => '$hours ގަޑިއިރު';
  @override
  String days(int days) => '$days ދުވަސް';
  @override
  String weeks(int weeks) => '$weeks ހަފްތާ';
  @override
  String delimiter() => ' ';
}

/// Divehi short duration units
class DvShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds ސިކުންތު';
  @override
  String minutes(int minutes) => '$minutes މިނެޓު';
  @override
  String hours(int hours) => '$hours ގަޑިއިރު';
  @override
  String days(int days) => '$days ދުވަސް';
  @override
  String weeks(int weeks) => '$weeks ހަފްތާ';
  @override
  String delimiter() => ' ';
}
