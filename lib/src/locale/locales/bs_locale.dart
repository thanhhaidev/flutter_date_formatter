import 'package:flutter_date_formatter/src/models/models.dart';

/// Bosnian locale
class BsLocale extends DateFormatterLocale {
  @override
  String code() => 'bs';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => BsRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => BsShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => BsCalendarDateTime();

  @override
  DurationUnits durationUnits() => BsDurationUnits();

  @override
  DurationUnits shortDurationUnits() => BsShortDurationUnits();
}

/// Bosnian relative date time
class BsRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'prije';
  @override
  String prefixFromNow() => 'za';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'manje od minute';
  @override
  String aboutAMinute(int minutes) => 'minutu';
  @override
  String minutes(int minutes) => _plural(minutes, 'minutu', 'minute', 'minuta');
  @override
  String aboutAnHour(int minutes) => 'sat';
  @override
  String hours(int hours) => _plural(hours, 'sat', 'sata', 'sati');
  @override
  String aDay(int hours) => 'dan';
  @override
  String days(int days) => _plural(days, 'dan', 'dana', 'dana');
  @override
  String aboutAMonth(int days) => 'mjesec';
  @override
  String months(int months) => _plural(months, 'mjesec', 'mjeseca', 'mjeseci');
  @override
  String aboutAYear(int year) => 'godinu';
  @override
  String years(int years) => _plural(years, 'godinu', 'godine', 'godina');
  @override
  String wordSeparator() => ' ';
}

/// Bosnian short relative date time
class BsShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'upravo sad';
  @override
  String aboutAMinute(int minutes) => '1 min.';
  @override
  String minutes(int minutes) => '$minutes min.';
  @override
  String aboutAnHour(int minutes) => '~1 h.';
  @override
  String hours(int hours) => '$hours h.';
  @override
  String aDay(int hours) => '~1 d.';
  @override
  String days(int days) => '$days d.';
  @override
  String aboutAMonth(int days) => '~1 m.';
  @override
  String months(int months) => '$months m.';
  @override
  String aboutAYear(int year) => '~1 g.';
  @override
  String years(int years) => '$years g.';
  @override
  String wordSeparator() => ' ';
}

/// Picks the CLDR plural form (one / few / other) for Bosnian.
String _plural(int n, String one, String few, String other) {
  final mod10 = n % 10;
  final mod100 = n % 100;
  if (mod10 == 1 && mod100 != 11) return '$n $one';
  if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) {
    return '$n $few';
  }
  return '$n $other';
}

/// Bosnian calendar date time
class BsCalendarDateTime implements CalendarDateTime {
  /// "On weekday" phrases (accusative), from Monday to Sunday.
  static const List<String> _nextWeekdays = [
    'U ponedjeljak',
    'U utorak',
    'U srijedu',
    'U četvrtak',
    'U petak',
    'U subotu',
    'U nedjelju',
  ];

  /// "Last weekday" phrases, from Monday to Sunday, as in moment.js.
  static const List<String> _lastWeekdays = [
    'Prošli ponedjeljak',
    'Prošli utorak',
    'Prošlu srijedu',
    'Prošli četvrtak',
    'Prošli petak',
    'Prošle subote',
    'Prošlu nedjelju',
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
      '${_nextWeekdays[date.weekday - 1]} u $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_lastWeekdays[date.weekday - 1]} u $time';
}

/// Bosnian duration units
class BsDurationUnits implements DurationUnits {
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
  String weeks(int weeks) => _plural(weeks, 'sedmica', 'sedmice', 'sedmica');
  @override
  String delimiter() => ' ';
}

/// Bosnian short duration units
class BsShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds sek.';
  @override
  String minutes(int minutes) => '$minutes min.';
  @override
  String hours(int hours) => '$hours h';
  @override
  String days(int days) => '$days d.';
  @override
  String weeks(int weeks) => '$weeks sedm.';
  @override
  String delimiter() => ' ';
}
