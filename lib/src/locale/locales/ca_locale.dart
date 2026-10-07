import 'package:flutter_date_formatter/src/models/models.dart';

/// Catalan locale
class CaLocale extends DateFormatterLocale {
  @override
  String code() => 'ca';

  @override
  String ordinal(int n) => _getOrdinalSuffix(n);

  @override
  String ordinalNumber(int n) => '$n${_getOrdinalSuffix(n)}';

  @override
  RelativeDateTime relativeDateTime() => CaRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => CaShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => CaCalendarDateTime();

  @override
  DurationUnits durationUnits() => CaDurationUnits();

  @override
  DurationUnits shortDurationUnits() => CaShortDurationUnits();

  String _getOrdinalSuffix(int n) {
    String ord;
    if (n == 1 || n == 3) {
      ord = 'r';
    } else if (n == 2) {
      ord = 'n';
    } else if (n == 4) {
      ord = 't';
    } else {
      ord = 'è';
    }
    return ord;
  }
}

/// Catalan relative date time
class CaRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'fa';
  @override
  String prefixFromNow() => "d'aquí a";
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'un moment';
  @override
  String aboutAMinute(int minutes) => 'un minut';
  @override
  String minutes(int minutes) => '$minutes minuts';
  @override
  String aboutAnHour(int minutes) => 'una hora';
  @override
  String hours(int hours) => '$hours hores';
  @override
  String aDay(int hours) => 'un dia';
  @override
  String days(int days) => '$days dies';
  @override
  String aboutAMonth(int days) => 'un mes';
  @override
  String months(int months) => '$months mesos';
  @override
  String aboutAYear(int year) => 'un any';
  @override
  String years(int years) => '$years anys';
  @override
  String wordSeparator() => ' ';
}

/// Catalan short relative date time
class CaShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'ara';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '~1 h';
  @override
  String hours(int hours) => '$hours h';
  @override
  String aDay(int hours) => '~1 dia';
  @override
  String days(int days) => '$days dies';
  @override
  String aboutAMonth(int days) => '~1 mes';
  @override
  String months(int months) => '$months mesos';
  @override
  String aboutAYear(int year) => '~1 any';
  @override
  String years(int years) => '$years anys';
  @override
  String wordSeparator() => ' ';
}

/// Catalan calendar date time
class CaCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Avui ${_at(time)} $time';
  @override
  String nextDay(String time) => 'Demà ${_at(time)} $time';
  @override
  String lastDay(String time) => 'Ahir ${_at(time)} $time';
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
      'El $weekday passat ${_at(time)} $time';
}

/// Catalan duration units
class CaDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => seconds == 1 ? '1 segon' : '$seconds segons';
  @override
  String minutes(int minutes) => minutes == 1 ? '1 minut' : '$minutes minuts';
  @override
  String hours(int hours) => hours == 1 ? '1 hora' : '$hours hores';
  @override
  String days(int days) => days == 1 ? '1 dia' : '$days dies';
  @override
  String weeks(int weeks) => weeks == 1 ? '1 setmana' : '$weeks setmanes';
  @override
  String delimiter() => ' ';
}

/// Catalan short duration units
class CaShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds s';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String hours(int hours) => '$hours h';
  @override
  String days(int days) => '$days d';
  @override
  String weeks(int weeks) => '$weeks setm.';
  @override
  String delimiter() => ' ';
}

/// "a la" before one o'clock ("a la 1:00"), otherwise "a les".
String _at(String time) {
  final hour = RegExp(r'\d+').firstMatch(time)?.group(0);
  return hour != null && int.parse(hour) == 1 ? 'a la' : 'a les';
}

String _capitalize(String text) =>
    text.isEmpty ? text : '${text[0].toUpperCase()}${text.substring(1)}';
