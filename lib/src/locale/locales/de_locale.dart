import 'package:flutter_date_formatter/src/models/models.dart';

/// German locale
class DeLocale extends DateFormatterLocale {
  @override
  String code() => 'de';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => DeRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => DeShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => DeCalendarDateTime();

  @override
  DurationUnits durationUnits() => DeDurationUnits();

  @override
  DurationUnits shortDurationUnits() => DeShortDurationUnits();
}

/// German relative date time
class DeRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'vor';
  @override
  String prefixFromNow() => 'in';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'weniger als einer Minute';
  @override
  String aboutAMinute(int minutes) => 'einer Minute';
  @override
  String minutes(int minutes) => '$minutes Minuten';
  @override
  String aboutAnHour(int minutes) => 'etwa einer Stunde';
  @override
  String hours(int hours) => '$hours Stunden';
  @override
  String aDay(int hours) => 'einem Tag';
  @override
  String days(int days) => '$days Tagen';
  @override
  String aboutAMonth(int days) => 'etwa einem Monat';
  @override
  String months(int months) => '$months Monaten';
  @override
  String aboutAYear(int year) => 'etwa einem Jahr';
  @override
  String years(int years) => '$years Jahren';
  @override
  String wordSeparator() => ' ';
}

/// German short relative date time
class DeShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'Jetzt';
  @override
  String aboutAMinute(int minutes) => '1 Min.';
  @override
  String minutes(int minutes) => '$minutes Min.';
  @override
  String aboutAnHour(int minutes) => '~1 Std.';
  @override
  String hours(int hours) => '$hours Std.';
  @override
  String aDay(int hours) => '~1 Tg.';
  @override
  String days(int days) => '$days Tg.';
  @override
  String aboutAMonth(int days) => '~1 Mo.';
  @override
  String months(int months) => '$months Mo.';
  @override
  String aboutAYear(int year) => '~1 J.';
  @override
  String years(int years) => '$years J.';
  @override
  String wordSeparator() => ' ';
}

/// German calendar date time
class DeCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Heute um ${_withUhr(time)}';
  @override
  String nextDay(String time) => 'Morgen um ${_withUhr(time)}';
  @override
  String lastDay(String time) => 'Gestern um ${_withUhr(time)}';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekday um ${_withUhr(time)}';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'Letzten $weekday um ${_withUhr(time)}';
}

/// German duration units
class DeDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      seconds == 1 ? '1 Sekunde' : '$seconds Sekunden';
  @override
  String minutes(int minutes) => minutes == 1 ? '1 Minute' : '$minutes Minuten';
  @override
  String hours(int hours) => hours == 1 ? '1 Stunde' : '$hours Stunden';
  @override
  String days(int days) => days == 1 ? '1 Tag' : '$days Tage';
  @override
  String weeks(int weeks) => weeks == 1 ? '1 Woche' : '$weeks Wochen';
  @override
  String delimiter() => ' ';
}

/// German short duration units
class DeShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds Sek.';
  @override
  String minutes(int minutes) => '$minutes Min.';
  @override
  String hours(int hours) => '$hours Std.';
  @override
  String days(int days) => '$days Tg.';
  @override
  String weeks(int weeks) => '$weeks Wo.';
  @override
  String delimiter() => ' ';
}

/// Adds "Uhr" to a 24-hour [time]; a 12-hour time with "AM"/"PM" is kept.
String _withUhr(String time) =>
    RegExp(r'\p{L}', unicode: true).hasMatch(time) ? time : '$time Uhr';
