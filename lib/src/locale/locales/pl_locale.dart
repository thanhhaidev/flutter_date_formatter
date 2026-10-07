import 'package:flutter_date_formatter/src/models/models.dart';

/// Polish Locale
class PlLocale extends DateFormatterLocale {
  @override
  String code() => 'pl';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => PlRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => PlShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => PlCalendarDateTime();

  @override
  DurationUnits durationUnits() => PlDurationUnits();

  @override
  DurationUnits shortDurationUnits() => PlShortDurationUnits();
}

/// Polish relative date time
class PlRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'za';
  @override
  String suffixAgo() => 'temu';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'chwilę';
  @override
  String aboutAMinute(int minutes) => 'około minuty';
  @override
  String minutes(int minutes) =>
      _pluralize(minutes, 'minutę', 'minuty', 'minut');
  @override
  String aboutAnHour(int minutes) => 'około godziny';
  @override
  String hours(int hours) => _pluralize(hours, 'godzinę', 'godziny', 'godzin');
  @override
  String aDay(int hours) => 'dzień';
  @override
  String days(int days) => _pluralize(days, 'dzień', 'dni', 'dni');
  @override
  String aboutAMonth(int days) => 'około miesiąca';
  @override
  String months(int months) =>
      _pluralize(months, 'miesiąc', 'miesiące', 'miesięcy');
  @override
  String aboutAYear(int year) => 'około roku';
  @override
  String years(int years) => _pluralize(years, 'rok', 'lata', 'lat');
  @override
  String wordSeparator() => ' ';
}

/// Polish short relative date time
class PlShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'teraz';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '~1 godz.';
  @override
  String hours(int hours) => '$hours godz.';
  @override
  String aDay(int hours) => '~1 d.';
  @override
  String days(int days) => '$days d.';
  @override
  String aboutAMonth(int days) => '~1 mies.';
  @override
  String months(int months) => '$months mies.';
  @override
  String aboutAYear(int year) => '~1 r.';
  @override
  String years(int years) => _pluralize(years, 'rok', 'lata', 'lat');
  @override
  String wordSeparator() => ' ';
}

/// CLDR plural selection for Polish integers (accusative forms, as used after
/// "za" and before "temu").
///
/// one: n == 1
/// few: n % 10 in 2..4 && n % 100 not in 12..14
/// many: everything else
String _pluralize(int n, String one, String few, String many) {
  if (n == 1) return '$n $one';
  final mod10 = n % 10;
  final mod100 = n % 100;
  if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) {
    return '$n $few';
  }
  return '$n $many';
}

/// Polish calendar date time
class PlCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Dziś o $time';
  @override
  String nextDay(String time) => 'Jutro o $time';
  @override
  String lastDay(String time) => 'Wczoraj o $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) {
    final day = _weekdaysAccusative[date.weekday - 1];
    final preposition = date.weekday == DateTime.tuesday ? 'We' : 'W';
    return '$preposition $day o $time';
  }

  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) {
    final day = _weekdaysAccusative[date.weekday - 1];
    switch (date.weekday) {
      case DateTime.wednesday:
      case DateTime.saturday:
      case DateTime.sunday:
        return 'W zeszłą $day o $time';
      default:
        return 'W zeszły $day o $time';
    }
  }
}

/// Polish duration units
class PlDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      _pluralize(seconds, 'sekunda', 'sekundy', 'sekund');
  @override
  String minutes(int minutes) =>
      _pluralize(minutes, 'minuta', 'minuty', 'minut');
  @override
  String hours(int hours) => _pluralize(hours, 'godzina', 'godziny', 'godzin');
  @override
  String days(int days) => _pluralize(days, 'dzień', 'dni', 'dni');
  @override
  String weeks(int weeks) =>
      _pluralize(weeks, 'tydzień', 'tygodnie', 'tygodni');
  @override
  String delimiter() => ' ';
}

/// Polish short duration units
class PlShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds s';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String hours(int hours) => '$hours godz.';
  @override
  String days(int days) => '$days d';
  @override
  String weeks(int weeks) => '$weeks tyg.';
  @override
  String delimiter() => ' ';
}

/// Polish weekday names in the accusative case, Monday first.
const _weekdaysAccusative = [
  'poniedziałek',
  'wtorek',
  'środę',
  'czwartek',
  'piątek',
  'sobotę',
  'niedzielę',
];
