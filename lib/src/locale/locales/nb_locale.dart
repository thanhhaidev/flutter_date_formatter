import 'package:flutter_date_formatter/src/models/models.dart';

/// Norwegian-Bokm-Norway locale
class NbLocale extends DateFormatterLocale {
  @override
  String code() => 'nb';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => NbRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => NbShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => NbCalendarDateTime();

  @override
  DurationUnits durationUnits() => NbDurationUnits();

  @override
  DurationUnits shortDurationUnits() => NbShortDurationUnits();
}

/// Norwegian-Bokm-Norway relative date time
class NbRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'om';
  @override
  String suffixAgo() => 'siden';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'ett øyeblikk';
  @override
  String aboutAMinute(int minutes) => 'ett minutt';
  @override
  String minutes(int minutes) => '$minutes minutter';
  @override
  String aboutAnHour(int minutes) => 'rundt en time';
  @override
  String hours(int hours) => '$hours timer';
  @override
  String aDay(int hours) => 'en dag';
  @override
  String days(int days) => '$days dager';
  @override
  String aboutAMonth(int days) => 'omtrent en måned';
  @override
  String months(int months) => '$months måneder';
  @override
  String aboutAYear(int year) => 'omtrent et år';
  @override
  String years(int years) => '$years år';
  @override
  String wordSeparator() => ' ';
}

/// Norwegian-Bokm-Norway short relative date time
class NbShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'nå';
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

/// Norwegian-Bokm-Norway calendar date time
class NbCalendarDateTime implements CalendarDateTime {
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
      '${_capitalize(weekday)} kl. $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'Forrige $weekday kl. $time';
}

/// Norwegian-Bokm-Norway duration units
class NbDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => _plural(seconds, 'sekund', 'sekunder');
  @override
  String minutes(int minutes) => _plural(minutes, 'minutt', 'minutter');
  @override
  String hours(int hours) => _plural(hours, 'time', 'timer');
  @override
  String days(int days) => _plural(days, 'dag', 'dager');
  @override
  String weeks(int weeks) => _plural(weeks, 'uke', 'uker');
  @override
  String delimiter() => ' ';
}

/// Norwegian-Bokm-Norway short duration units
class NbShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds sek';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String hours(int hours) => '$hours t';
  @override
  String days(int days) => '$days d';
  @override
  String weeks(int weeks) => '$weeks u';
  @override
  String delimiter() => ' ';
}

/// Picks the CLDR plural form (one / other) for Norwegian Bokmål.
String _plural(int n, String one, String other) =>
    n == 1 ? '1 $one' : '$n $other';

/// Returns [text] with its first letter in upper case.
String _capitalize(String text) =>
    text.isEmpty ? text : '${text[0].toUpperCase()}${text.substring(1)}';
