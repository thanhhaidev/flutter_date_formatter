import 'package:flutter_date_formatter/src/models/models.dart';

/// Azerbaijani locale.
class AzLocale extends DateFormatterLocale {
  @override
  String code() => 'az';

  @override
  String ordinal(int n) => _ordinalSuffix(n);

  @override
  String ordinalNumber(int n) => '$n${_ordinalSuffix(n)}';

  @override
  RelativeDateTime relativeDateTime() => AzRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => AzShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => AzCalendarDateTime();

  @override
  DurationUnits durationUnits() => AzDurationUnits();

  @override
  DurationUnits shortDurationUnits() => AzShortDurationUnits();

  static const Map<int, String> _suffixes = {
    1: '-inci',
    5: '-inci',
    8: '-inci',
    70: '-inci',
    80: '-inci',
    2: '-nci',
    7: '-nci',
    20: '-nci',
    50: '-nci',
    3: '-üncü',
    4: '-üncü',
    100: '-üncü',
    6: '-ncı',
    9: '-uncu',
    10: '-uncu',
    30: '-uncu',
    40: '-ıncı',
    60: '-ıncı',
    90: '-ıncı',
  };

  /// Ordinal suffix following vowel harmony of the last spoken number word.
  String _ordinalSuffix(int n) {
    if (n == 0) return '-ıncı';
    final lastDigit = n % 10;
    final tens = n % 100 - lastDigit;
    return _suffixes[lastDigit] ??
        _suffixes[tens] ??
        (n >= 100 ? _suffixes[100]! : '');
  }
}

/// Azerbaijani relative date time
class AzRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'əvvəl';
  @override
  String suffixFromNow() => 'sonra';
  @override
  String lessThanOneMinute(int seconds) => 'bir neçə saniyə';
  @override
  String aboutAMinute(int minutes) => 'bir dəqiqə';
  @override
  String minutes(int minutes) => '$minutes dəqiqə';
  @override
  String aboutAnHour(int minutes) => 'təxminən 1 saat';
  @override
  String hours(int hours) => '$hours saat';
  @override
  String aDay(int hours) => 'bir gün';
  @override
  String days(int days) => '$days gün';
  @override
  String aboutAMonth(int days) => 'təxminən 1 ay';
  @override
  String months(int months) => '$months ay';
  @override
  String aboutAYear(int year) => 'təxminən 1 il';
  @override
  String years(int years) => '$years il';
  @override
  String wordSeparator() => ' ';
}

/// Azerbaijani short relative date time
class AzShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'indi';
  @override
  String aboutAMinute(int minutes) => '1 dəq';
  @override
  String minutes(int minutes) => '$minutes dəq';
  @override
  String aboutAnHour(int minutes) => '~1 s';
  @override
  String hours(int hours) => '$hours s';
  @override
  String aDay(int hours) => '~1 g';
  @override
  String days(int days) => '$days g';
  @override
  String aboutAMonth(int days) => '~1 ay';
  @override
  String months(int months) => '$months ay';
  @override
  String aboutAYear(int year) => '~1 il';
  @override
  String years(int years) => '$years il';
  @override
  String wordSeparator() => ' ';
}

/// Azerbaijani calendar date time
class AzCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Bugün saat $time';
  @override
  String nextDay(String time) => 'Sabah saat $time';
  @override
  String lastDay(String time) => 'Dünən saat $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'Gələn həftə $weekday saat $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'Keçən həftə $weekday saat $time';
}

/// Azerbaijani duration units
class AzDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds saniyə';
  @override
  String minutes(int minutes) => '$minutes dəqiqə';
  @override
  String hours(int hours) => '$hours saat';
  @override
  String days(int days) => '$days gün';
  @override
  String weeks(int weeks) => '$weeks həftə';
  @override
  String delimiter() => ' ';
}

/// Azerbaijani short duration units
class AzShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds san';
  @override
  String minutes(int minutes) => '$minutes dəq';
  @override
  String hours(int hours) => '$hours saat';
  @override
  String days(int days) => '$days gün';
  @override
  String weeks(int weeks) => '$weeks həftə';
  @override
  String delimiter() => ' ';
}
