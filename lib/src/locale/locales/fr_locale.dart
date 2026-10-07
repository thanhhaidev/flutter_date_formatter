import 'package:flutter_date_formatter/src/models/models.dart';

/// French Locale
class FrLocale extends DateFormatterLocale {
  @override
  String code() => 'fr';

  @override
  String ordinal(int n) {
    final ord = n == 1 ? 'er' : '';
    return ord;
  }

  @override
  String ordinalNumber(int n) => '$n${n == 1 ? 'er' : 'e'}';

  @override
  RelativeDateTime relativeDateTime() => FrRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => FrShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => FrCalendarDateTime();

  @override
  DurationUnits durationUnits() => FrDurationUnits();

  @override
  DurationUnits shortDurationUnits() => FrShortDurationUnits();
}

/// French relative date time
class FrRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'il y a';
  @override
  String prefixFromNow() => "d'ici";
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => "moins d'une minute";
  @override
  String aboutAMinute(int minutes) => 'environ une minute';
  @override
  String minutes(int minutes) => '$minutes minutes';
  @override
  String aboutAnHour(int minutes) => 'environ une heure';
  @override
  String hours(int hours) => '$hours heures';
  @override
  String aDay(int hours) => 'environ un jour';
  @override
  String days(int days) => '$days jours';
  @override
  String aboutAMonth(int days) => 'environ un mois';
  @override
  String months(int months) => '$months mois';
  @override
  String aboutAYear(int year) => 'environ un an';
  @override
  String years(int years) => '$years ans';
  @override
  String wordSeparator() => ' ';
}

/// French short relative date time
class FrShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'il y a';
  @override
  String prefixFromNow() => "d'ici";
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => "moins d'une minute";
  @override
  String aboutAMinute(int minutes) => 'une minute';
  @override
  String minutes(int minutes) => '$minutes minutes';
  @override
  String aboutAnHour(int minutes) => 'une heure';
  @override
  String hours(int hours) => '$hours heures';
  @override
  String aDay(int hours) => 'un jour';
  @override
  String days(int days) => '$days jours';
  @override
  String aboutAMonth(int days) => 'un mois';
  @override
  String months(int months) => '$months mois';
  @override
  String aboutAYear(int year) => 'un an';
  @override
  String years(int years) => '$years ans';
  @override
  String wordSeparator() => ' ';
}

/// French calendar date time
class FrCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Aujourd’hui à $time';
  @override
  String nextDay(String time) => 'Demain à $time';
  @override
  String lastDay(String time) => 'Hier à $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_capitalize(weekday)} à $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_capitalize(weekday)} dernier à $time';
}

/// French duration units
///
/// French uses the singular for 0 and 1 (CLDR plural rule `i = 0,1`).
class FrDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      seconds <= 1 ? '$seconds seconde' : '$seconds secondes';
  @override
  String minutes(int minutes) =>
      minutes <= 1 ? '$minutes minute' : '$minutes minutes';
  @override
  String hours(int hours) => hours <= 1 ? '$hours heure' : '$hours heures';
  @override
  String days(int days) => days <= 1 ? '$days jour' : '$days jours';
  @override
  String weeks(int weeks) => weeks <= 1 ? '$weeks semaine' : '$weeks semaines';
  @override
  String delimiter() => ' ';
}

/// French short duration units
class FrShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds s';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String hours(int hours) => '$hours h';
  @override
  String days(int days) => '$days j';
  @override
  String weeks(int weeks) => '$weeks sem.';
  @override
  String delimiter() => ' ';
}

String _capitalize(String text) =>
    text.isEmpty ? text : '${text[0].toUpperCase()}${text.substring(1)}';
