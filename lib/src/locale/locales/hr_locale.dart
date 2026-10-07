import 'package:flutter_date_formatter/src/models/models.dart';

/// Croatian Locale
class HrLocale extends DateFormatterLocale {
  @override
  String code() => 'hr';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => HrRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => HrRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => HrCalendarDateTime();

  @override
  DurationUnits durationUnits() => HrDurationUnits();

  @override
  DurationUnits shortDurationUnits() => HrShortDurationUnits();
}

/// Croatian relative date time
class HrRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'prije';

  @override
  String prefixFromNow() => 'za';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => 'manje od jedne minute';

  @override
  String aboutAMinute(int minutes) => 'oko jedne minute';

  @override
  String minutes(int minutes) => _plural(minutes, 'minutu', 'minute', 'minuta');

  @override
  String aboutAnHour(int minutes) => 'oko jednog sata';

  @override
  String hours(int hours) => _plural(hours, 'sat', 'sata', 'sati');

  @override
  String aDay(int hours) => 'jedan dan';

  @override
  String days(int days) => _plural(days, 'dan', 'dana', 'dana');

  @override
  String aboutAMonth(int days) => 'oko jednog mjeseca';

  @override
  String months(int months) => _plural(months, 'mjesec', 'mjeseca', 'mjeseci');

  @override
  String aboutAYear(int year) => 'oko jedne godine';

  @override
  String years(int years) => _plural(years, 'godinu', 'godine', 'godina');

  @override
  String wordSeparator() => ' ';
}

/// Picks the CLDR plural form (one / few / other) for Croatian.
String _plural(int n, String one, String few, String other) {
  final mod10 = n % 10;
  final mod100 = n % 100;
  if (mod10 == 1 && mod100 != 11) return '$n $one';
  if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) {
    return '$n $few';
  }
  return '$n $other';
}

/// Croatian calendar date time
class HrCalendarDateTime implements CalendarDateTime {
  // Accusative weekday names, Monday first ("u srijedu").
  static const _weekdays = [
    'ponedjeljak',
    'utorak',
    'srijedu',
    'četvrtak',
    'petak',
    'subotu',
    'nedjelju',
  ];

  @override
  String sameDay(String time) => 'Danas u $time';

  @override
  String nextDay(String time) => 'Sutra u $time';

  @override
  String lastDay(String time) => 'Jučer u $time';

  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'U ${_weekdays[date.weekday - 1]} u $time';

  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) {
    final day = date.weekday;
    if (day == DateTime.saturday) return 'Prošle subote u $time';
    final prefix = day == DateTime.wednesday || day == DateTime.sunday
        ? 'Prošlu'
        : 'Prošli';
    return '$prefix ${_weekdays[day - 1]} u $time';
  }
}

/// Croatian duration units
class HrDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      _plural(seconds, 'sekunda', 'sekunde', 'sekundi');

  @override
  String minutes(int minutes) => _plural(minutes, 'minuta', 'minute', 'minuta');

  @override
  String hours(int hours) => _plural(hours, 'sat', 'sata', 'sati');

  @override
  String days(int days) => _plural(days, 'dan', 'dana', 'dana');

  @override
  String weeks(int weeks) => _plural(weeks, 'tjedan', 'tjedna', 'tjedana');

  @override
  String delimiter() => ' ';
}

/// Croatian short duration units
class HrShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds s';

  @override
  String minutes(int minutes) => '$minutes min';

  @override
  String hours(int hours) => '$hours h';

  @override
  String days(int days) => '$days d';

  @override
  String weeks(int weeks) => '$weeks tj.';

  @override
  String delimiter() => ' ';
}
