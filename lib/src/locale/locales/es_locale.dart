import 'package:flutter_date_formatter/src/models/models.dart';

/// Spanish locale
class EsLocale extends DateFormatterLocale {
  @override
  String code() => 'es';

  @override
  String ordinal(int n) => 'º';

  @override
  String ordinalNumber(int n) => '$n.º';

  @override
  RelativeDateTime relativeDateTime() => EsRelativeTime();

  @override
  RelativeDateTime shortRelativeDateTime() => EsShortRelativeTime();

  @override
  CalendarDateTime calendarDateTime() => EsCalendarDateTime();

  @override
  DurationUnits durationUnits() => EsDurationUnits();

  @override
  DurationUnits shortDurationUnits() => EsShortDurationUnits();
}

/// Spanish relative date time
class EsRelativeTime extends RelativeDateTime {
  @override
  String prefixAgo() => 'hace';
  @override
  String prefixFromNow() => 'en';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'un momento';
  @override
  String aboutAMinute(int minutes) => 'un minuto';
  @override
  String minutes(int minutes) => '$minutes minutos';
  @override
  String aboutAnHour(int minutes) => 'una hora';
  @override
  String hours(int hours) => '$hours horas';
  @override
  String aDay(int hours) => 'un día';
  @override
  String days(int days) => '$days días';
  @override
  String aboutAMonth(int days) => 'un mes';
  @override
  String months(int months) => '$months meses';
  @override
  String aboutAYear(int year) => 'un año';
  @override
  String years(int years) => '$years años';
  @override
  String wordSeparator() => ' ';
}

/// Spanish short relative date time
class EsShortRelativeTime extends RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'ahora';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '~1 h';
  @override
  String hours(int hours) => '$hours h';
  @override
  String aDay(int hours) => '~1 día';
  @override
  String days(int days) => '$days días';
  @override
  String aboutAMonth(int days) => '~1 mes';
  @override
  String months(int months) => '$months meses';
  @override
  String aboutAYear(int year) => '~1 año';
  @override
  String years(int years) => '$years años';
  @override
  String wordSeparator() => ' ';
}

/// Spanish calendar date time
class EsCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Hoy ${_at(time)} $time';
  @override
  String nextDay(String time) => 'Mañana ${_at(time)} $time';
  @override
  String lastDay(String time) => 'Ayer ${_at(time)} $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_capitalize(weekday)} ${_at(time)} $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'El $weekday pasado ${_at(time)} $time';
}

/// Spanish duration units
class EsDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      seconds == 1 ? '1 segundo' : '$seconds segundos';
  @override
  String minutes(int minutes) => minutes == 1 ? '1 minuto' : '$minutes minutos';
  @override
  String hours(int hours) => hours == 1 ? '1 hora' : '$hours horas';
  @override
  String days(int days) => days == 1 ? '1 día' : '$days días';
  @override
  String weeks(int weeks) => weeks == 1 ? '1 semana' : '$weeks semanas';
  @override
  String delimiter() => ' ';
}

/// Spanish short duration units
class EsShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds s';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String hours(int hours) => '$hours h';
  @override
  String days(int days) => '$days d';
  @override
  String weeks(int weeks) => '$weeks sem.';
  @override
  String delimiter() => ' ';
}

/// "a la" before one o'clock ("a la 1:00"), otherwise "a las".
String _at(String time) {
  final hour = RegExp(r'\d+').firstMatch(time)?.group(0);
  return hour != null && int.parse(hour) == 1 ? 'a la' : 'a las';
}

String _capitalize(String text) =>
    text.isEmpty ? text : '${text[0].toUpperCase()}${text.substring(1)}';
