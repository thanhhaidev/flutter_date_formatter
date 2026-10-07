import 'package:flutter_date_formatter/src/models/models.dart';

/// Portuguese-Brazil locale
class PtLocale extends DateFormatterLocale {
  @override
  String code() => 'pt';

  @override
  String ordinal(int n) => 'º';

  @override
  String ordinalNumber(int n) => '$nº';

  @override
  RelativeDateTime relativeDateTime() => PtRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => PtShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => PtCalendarDateTime();

  @override
  DurationUnits durationUnits() => PtDurationUnits();

  @override
  DurationUnits shortDurationUnits() => PtShortDurationUnits();
}

/// Portuguese-Brazil relative date time
class PtRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'há';
  @override
  String prefixFromNow() => 'em';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'alguns segundos';
  @override
  String aboutAMinute(int minutes) => 'cerca de um minuto';
  @override
  String minutes(int minutes) => '$minutes minutos';
  @override
  String aboutAnHour(int minutes) => 'cerca de uma hora';
  @override
  String hours(int hours) => '$hours horas';
  @override
  String aDay(int hours) => 'um dia';
  @override
  String days(int days) => '$days dias';
  @override
  String aboutAMonth(int days) => 'cerca de um mês';
  @override
  String months(int months) => '$months meses';
  @override
  String aboutAYear(int year) => 'cerca de um ano';
  @override
  String years(int years) => '$years anos';
  @override
  String wordSeparator() => ' ';
}

/// Portuguese-Brazil short relative date time
class PtShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'agora';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '~1h';
  @override
  String hours(int hours) => '$hours h';
  @override
  String aDay(int hours) => '~1 dia';
  @override
  String days(int days) => '$days dias';
  @override
  String aboutAMonth(int days) => '~1 mês';
  @override
  String months(int months) => '$months meses';
  @override
  String aboutAYear(int year) => '~1 ano';
  @override
  String years(int years) => '$years anos';
  @override
  String wordSeparator() => ' ';
}

/// Portuguese-Brazil calendar date time
class PtCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Hoje às $time';
  @override
  String nextDay(String time) => 'Amanhã às $time';
  @override
  String lastDay(String time) => 'Ontem às $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_capitalize(weekday)} às $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) {
    // "sábado" and "domingo" are masculine, the "-feira" days feminine.
    final isMasculine =
        date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
    return '${isMasculine ? 'Último' : 'Última'} $weekday às $time';
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
}

/// Portuguese-Brazil duration units.
///
/// CLDR uses the singular for 0 and 1 in Portuguese.
class PtDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      seconds == 1 ? '$seconds segundo' : '$seconds segundos';
  @override
  String minutes(int minutes) =>
      minutes == 1 ? '$minutes minuto' : '$minutes minutos';
  @override
  String hours(int hours) => hours == 1 ? '$hours hora' : '$hours horas';
  @override
  String days(int days) => days == 1 ? '$days dia' : '$days dias';
  @override
  String weeks(int weeks) => weeks == 1 ? '$weeks semana' : '$weeks semanas';
  @override
  String delimiter() => ' ';
}

/// Portuguese-Brazil short duration units
class PtShortDurationUnits implements DurationUnits {
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
