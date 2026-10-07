import 'package:flutter_date_formatter/src/models/models.dart';

/// Latvian Locale
class LvLocale extends DateFormatterLocale {
  @override
  String code() => 'lv';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => LvRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => LvShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => LvCalendarDateTime();

  @override
  DurationUnits durationUnits() => LvDurationUnits();

  @override
  DurationUnits shortDurationUnits() => LvShortDurationUnits();
}

/// Latvian relative date time
class LvRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'pirms';
  @override
  String prefixFromNow() => 'pēc';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'minūtes';
  @override
  String aboutAMinute(int minutes) => 'minūtes';
  @override
  String minutes(int minutes) => '$minutes ${_convert(minutes, 'minutes')}';
  @override
  String aboutAnHour(int minutes) => 'stundas';
  @override
  String hours(int hours) => '$hours ${_convert(hours, 'hours')}';
  @override
  String aDay(int hours) => 'dienas';
  @override
  String days(int days) => '$days ${_convert(days, 'days')}';
  @override
  String aboutAMonth(int days) => 'mēneša';
  @override
  String months(int months) => '$months ${_convert(months, 'months')}';
  @override
  String aboutAYear(int year) => 'gada';
  @override
  String years(int years) => '$years ${_convert(years, 'years')}';
  @override
  String wordSeparator() => ' ';

  String _convert(int number, String type) {
    // CLDR: one when n % 10 == 1 and n % 100 != 11.
    if (number % 10 == 1 && number % 100 != 11) {
      switch (type) {
        case 'minutes':
          return 'minūtes';
        case 'hours':
          return 'stundas';
        case 'days':
          return 'dienas';
        case 'months':
          return 'mēneša';
        case 'years':
          return 'gada';
        default:
          return '';
      }
    }
    switch (type) {
      case 'minutes':
        return 'minūtēm';
      case 'hours':
        return 'stundām';
      case 'days':
        return 'dienām';
      case 'months':
        return 'mēnešiem';
      case 'years':
        return 'gadiem';
      default:
        return '';
    }
  }
}

/// Latvian short relative date time
class LvShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'tikai tagad';
  @override
  String aboutAMinute(int minutes) => '1 min.';
  @override
  String minutes(int minutes) => '$minutes min.';
  @override
  String aboutAnHour(int minutes) => '~1 st.';
  @override
  String hours(int hours) => '$hours st.';
  @override
  String aDay(int hours) => '~1 d.';
  @override
  String days(int days) => '$days d.';
  @override
  String aboutAMonth(int days) => '~1 mēn.';
  @override
  String months(int months) => '$months mēn.';
  @override
  String aboutAYear(int year) => '~1 g.';
  @override
  String years(int years) => '$years g.';
  @override
  String wordSeparator() => ' ';
}

/// Latvian calendar date time
class LvCalendarDateTime implements CalendarDateTime {
  // Adverbial weekday names ("on Monday"), Monday first.
  static const _on = [
    'Pirmdien',
    'Otrdien',
    'Trešdien',
    'Ceturtdien',
    'Piektdien',
    'Sestdien',
    'Svētdien',
  ];

  // Locative weekday names, Monday first ("pirmdienā").
  static const _last = [
    'pirmdienā',
    'otrdienā',
    'trešdienā',
    'ceturtdienā',
    'piektdienā',
    'sestdienā',
    'svētdienā',
  ];

  @override
  String sameDay(String time) => 'Šodien pulksten $time';
  @override
  String nextDay(String time) => 'Rīt pulksten $time';
  @override
  String lastDay(String time) => 'Vakar pulksten $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_on[date.weekday - 1]} pulksten $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'Pagājušajā ${_last[date.weekday - 1]} pulksten $time';
}

/// Latvian duration units
class LvDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      _unit(seconds, 'sekunde', 'sekundes', 'sekunžu');
  @override
  String minutes(int minutes) => _unit(minutes, 'minūte', 'minūtes', 'minūšu');
  @override
  String hours(int hours) => _unit(hours, 'stunda', 'stundas', 'stundu');
  @override
  String days(int days) => _unit(days, 'diena', 'dienas', 'dienu');
  @override
  String weeks(int weeks) => _unit(weeks, 'nedēļa', 'nedēļas', 'nedēļu');
  @override
  String delimiter() => ' ';
}

/// Latvian short duration units
class LvShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds sek.';
  @override
  String minutes(int minutes) => '$minutes min.';
  @override
  String hours(int hours) => '$hours st.';
  @override
  String days(int days) => '$days d.';
  @override
  String weeks(int weeks) => '$weeks ned.';
  @override
  String delimiter() => ' ';
}

/// Picks the CLDR plural form for Latvian: zero (n % 10 == 0 or
/// n % 100 in 11..19) takes the genitive plural, one (n % 10 == 1,
/// n % 100 != 11) the nominative singular, other the nominative plural.
String _unit(int n, String one, String other, String zero) {
  if (n % 10 == 0 || (n % 100 >= 11 && n % 100 <= 19)) return '$n $zero';
  return n % 10 == 1 ? '$n $one' : '$n $other';
}
