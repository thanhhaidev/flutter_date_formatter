import 'package:flutter_date_formatter/src/models/models.dart';

/// Romanian Locale
class RoLocale extends DateFormatterLocale {
  @override
  String code() => 'ro';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '${n}a';

  @override
  RelativeDateTime relativeDateTime() => RoRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => RoShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => RoCalendarDateTime();

  @override
  DurationUnits durationUnits() => RoDurationUnits();

  @override
  DurationUnits shortDurationUnits() => RoShortDurationUnits();
}

/// Romanian relative date time
class RoRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'acum';
  @override
  String prefixFromNow() => 'peste';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'o clipă';
  @override
  String aboutAMinute(int minutes) => 'un minut';
  @override
  String minutes(int minutes) => _withDe(minutes, 'minute');
  @override
  String aboutAnHour(int minutes) => 'o oră';
  @override
  String hours(int hours) => _withDe(hours, 'ore');
  @override
  String aDay(int hours) => 'o zi';
  @override
  String days(int days) => _withDe(days, 'zile');
  @override
  String aboutAMonth(int days) => 'o lună';
  @override
  String months(int months) => _withDe(months, 'luni');
  @override
  String aboutAYear(int year) => 'un an';
  @override
  String years(int years) => _withDe(years, 'ani');
  @override
  String wordSeparator() => ' ';
}

/// Romanian short relative date time
class RoShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'acum';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '~1 oră';
  @override
  String hours(int hours) => _withDe(hours, 'ore');
  @override
  String aDay(int hours) => '~1 zi';
  @override
  String days(int days) => _withDe(days, 'zile');
  @override
  String aboutAMonth(int days) => '~1 lună';
  @override
  String months(int months) => _withDe(months, 'luni');
  @override
  String aboutAYear(int year) => '~1 an';
  @override
  String years(int years) => _withDe(years, 'ani');
  @override
  String wordSeparator() => ' ';
}

/// Romanian inserts "de" between the number and the noun when
/// n % 100 == 0 or n % 100 >= 20 (e.g. "22 de minute", "100 de ani").
String _withDe(int n, String noun) {
  final mod100 = n % 100;
  return (n != 0 && (mod100 == 0 || mod100 >= 20)) ? '$n de $noun' : '$n $noun';
}

/// Romanian calendar date time
class RoCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Azi la $time';
  @override
  String nextDay(String time) => 'Mâine la $time';
  @override
  String lastDay(String time) => 'Ieri la $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_capitalize(weekday)} la $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'Fosta $weekday la $time';
}

/// Romanian duration units
class RoDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      seconds == 1 ? '1 secundă' : _withDe(seconds, 'secunde');
  @override
  String minutes(int minutes) =>
      minutes == 1 ? '1 minut' : _withDe(minutes, 'minute');
  @override
  String hours(int hours) => hours == 1 ? '1 oră' : _withDe(hours, 'ore');
  @override
  String days(int days) => days == 1 ? '1 zi' : _withDe(days, 'zile');
  @override
  String weeks(int weeks) =>
      weeks == 1 ? '1 săptămână' : _withDe(weeks, 'săptămâni');
  @override
  String delimiter() => ' ';
}

/// Romanian short duration units
class RoShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds s';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String hours(int hours) => '$hours h';
  @override
  String days(int days) => '$days z';
  @override
  String weeks(int weeks) => '$weeks săpt.';
  @override
  String delimiter() => ' ';
}

String _capitalize(String text) =>
    text.isEmpty ? text : '${text[0].toUpperCase()}${text.substring(1)}';
