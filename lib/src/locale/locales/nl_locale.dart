import 'package:flutter_date_formatter/src/models/models.dart';

/// Dutch locale
class NlLocale extends DateFormatterLocale {
  @override
  String code() => 'nl';

  @override
  String ordinal(int n) {
    return n == 1 || n == 8 || n >= 20 ? 'ste' : 'de';
  }

  @override
  String ordinalNumber(int n) => '${n}e';

  @override
  RelativeDateTime relativeDateTime() => NlRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => NlShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => NlCalendarDateTime();

  @override
  DurationUnits durationUnits() => NlDurationUnits();

  @override
  DurationUnits shortDurationUnits() => NlShortDurationUnits();
}

/// Dutch relative date time
class NlRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'over';
  @override
  String suffixAgo() => 'geleden';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'een moment';
  @override
  String aboutAMinute(int minutes) => 'één minuut';
  @override
  String minutes(int minutes) => '$minutes minuten';
  @override
  String aboutAnHour(int minutes) => 'ongeveer één uur';
  @override
  String hours(int hours) => '$hours uur';
  @override
  String aDay(int hours) => 'één dag';
  @override
  String days(int days) => '$days dagen';
  @override
  String aboutAMonth(int days) => 'ongeveer één maand';
  @override
  String months(int months) => '$months maanden';
  @override
  String aboutAYear(int year) => 'ongeveer één jaar';
  @override
  String years(int years) => '$years jaar';
  @override
  String wordSeparator() => ' ';
}

/// Dutch short relative date time
class NlShortRelativeDateTime implements RelativeDateTime {
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
  String aboutAnHour(int minutes) => '~1 u';
  @override
  String hours(int hours) => '$hours u';
  @override
  String aDay(int hours) => '~1 d';
  @override
  String days(int days) => '$days d';
  @override
  String aboutAMonth(int days) => '~1 ma';
  @override
  String months(int months) => '$months ma';
  @override
  String aboutAYear(int year) => '~1 jr';
  @override
  String years(int years) => '$years jr';
  @override
  String wordSeparator() => ' ';
}

/// Dutch calendar date time
class NlCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Vandaag om $time';
  @override
  String nextDay(String time) => 'Morgen om $time';
  @override
  String lastDay(String time) => 'Gisteren om $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_capitalize(weekday)} om $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'Afgelopen $weekday om $time';
}

/// Dutch duration units
class NlDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => _plural(seconds, 'seconde', 'seconden');
  @override
  String minutes(int minutes) => _plural(minutes, 'minuut', 'minuten');
  @override
  String hours(int hours) => '$hours uur';
  @override
  String days(int days) => _plural(days, 'dag', 'dagen');
  @override
  String weeks(int weeks) => _plural(weeks, 'week', 'weken');
  @override
  String delimiter() => ' ';
}

/// Dutch short duration units
class NlShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds sec';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String hours(int hours) => '$hours u';
  @override
  String days(int days) => '$days d';
  @override
  String weeks(int weeks) => '$weeks w';
  @override
  String delimiter() => ' ';
}

/// Picks the CLDR plural form (one / other) for Dutch.
String _plural(int n, String one, String other) =>
    n == 1 ? '1 $one' : '$n $other';

/// Returns [text] with its first letter in upper case.
String _capitalize(String text) =>
    text.isEmpty ? text : '${text[0].toUpperCase()}${text.substring(1)}';
