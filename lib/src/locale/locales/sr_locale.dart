import 'package:flutter_date_formatter/src/models/models.dart';

/// Serbian Locale
class SrLocale extends DateFormatterLocale {
  @override
  String code() => 'sr';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => SrRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => SrShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => SrCalendarDateTime();

  @override
  DurationUnits durationUnits() => SrDurationUnits();

  @override
  DurationUnits shortDurationUnits() => SrShortDurationUnits();
}

/// Serbian relative date time
class SrRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'пре';
  @override
  String prefixFromNow() => 'за';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'мање од минута';
  @override
  String aboutAMinute(int minutes) => 'минут';
  @override
  String minutes(int minutes) =>
      '$minutes ${_plural(minutes, 'минут', 'минута', 'минута')}';
  @override
  String aboutAnHour(int minutes) => 'сат';
  @override
  String hours(int hours) => '$hours ${_plural(hours, 'сат', 'сата', 'сати')}';
  @override
  String aDay(int hours) => 'дан';
  @override
  String days(int days) => '$days ${_plural(days, 'дан', 'дана', 'дана')}';
  @override
  String aboutAMonth(int days) => 'месец';
  @override
  String months(int months) =>
      '$months ${_plural(months, 'месец', 'месеца', 'месеци')}';
  @override
  String aboutAYear(int year) => 'годину';
  @override
  String years(int years) =>
      '$years ${_plural(years, 'годину', 'године', 'година')}';
  @override
  String wordSeparator() => ' ';

  /// CLDR plural selection for Serbian integers.
  ///
  /// one: n % 10 == 1 && n % 100 != 11
  /// few: n % 10 in 2..4 && n % 100 not in 12..14
  /// other: everything else
  String _plural(int n, String one, String few, String other) {
    final mod10 = n % 10;
    final mod100 = n % 100;
    if (mod10 == 1 && mod100 != 11) return one;
    if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) return few;
    return other;
  }
}

/// Serbian short relative date time
class SrShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'сад';
  @override
  String aboutAMinute(int minutes) => '1 мин.';
  @override
  String minutes(int minutes) => '$minutes мин.';
  @override
  String aboutAnHour(int minutes) => '~1 ч.';
  @override
  String hours(int hours) => '$hours ч.';
  @override
  String aDay(int hours) => '~1 д.';
  @override
  String days(int days) => '$days д.';
  @override
  String aboutAMonth(int days) => '~1 м.';
  @override
  String months(int months) => '$months м.';
  @override
  String aboutAYear(int year) => '~1 г.';
  @override
  String years(int years) => '$years г.';
  @override
  String wordSeparator() => ' ';
}

/// Serbian calendar date time
class SrCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Данас у $time';
  @override
  String nextDay(String time) => 'Сутра у $time';
  @override
  String lastDay(String time) => 'Јуче у $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_capitalize(_nextWeekdays[date.weekday - 1])} у $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_capitalize(_lastWeekdays[date.weekday - 1])} у $time';
}

/// Serbian duration units
class SrDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      _pluralForm(seconds, 'секунда', 'секунде', 'секунди');
  @override
  String minutes(int minutes) =>
      _pluralForm(minutes, 'минут', 'минута', 'минута');
  @override
  String hours(int hours) => _pluralForm(hours, 'сат', 'сата', 'сати');
  @override
  String days(int days) => _pluralForm(days, 'дан', 'дана', 'дана');
  @override
  String weeks(int weeks) => _pluralForm(weeks, 'недеља', 'недеље', 'недеља');
  @override
  String delimiter() => ' ';
}

/// Serbian short duration units
class SrShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds сек';
  @override
  String minutes(int minutes) => '$minutes мин';
  @override
  String hours(int hours) => '$hours ч';
  @override
  String days(int days) => '$days д';
  @override
  String weeks(int weeks) => '$weeks нед.';
  @override
  String delimiter() => ' ';
}

/// "On `weekday`" (accusative), Monday first.
const _nextWeekdays = [
  'у понедељак',
  'у уторак',
  'у среду',
  'у четвртак',
  'у петак',
  'у суботу',
  'у недељу',
];

/// "Last `weekday`" (genitive), Monday first.
const _lastWeekdays = [
  'прошлог понедељка',
  'прошлог уторка',
  'прошле среде',
  'прошлог четвртка',
  'прошлог петка',
  'прошле суботе',
  'прошле недеље',
];

/// CLDR plural selection for Serbian integers, e.g. "5 минута".
///
/// one: n % 10 == 1 && n % 100 != 11
/// few: n % 10 in 2..4 && n % 100 not in 12..14
/// other: everything else
String _pluralForm(int n, String one, String few, String other) {
  final mod10 = n % 10;
  final mod100 = n % 100;
  if (mod10 == 1 && mod100 != 11) return '$n $one';
  if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) {
    return '$n $few';
  }
  return '$n $other';
}

String _capitalize(String text) =>
    text.isEmpty ? text : '${text[0].toUpperCase()}${text.substring(1)}';
