import 'package:flutter_date_formatter/src/models/models.dart';

/// Swedish Locale
class SvLocale extends DateFormatterLocale {
  @override
  String code() => 'sv';

  @override
  String ordinal(int n) => _getOrdinalSuffix(n);

  @override
  String ordinalNumber(int n) => '$n:${_getOrdinalSuffix(n)}';

  @override
  RelativeDateTime relativeDateTime() => SvRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => SvShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => SvCalendarDateTime();

  @override
  DurationUnits durationUnits() => SvDurationUnits();

  @override
  DurationUnits shortDurationUnits() => SvShortDurationUnits();

  String _getOrdinalSuffix(int n) {
    final b = n % 10;
    final rem100 = n % 100;
    // 1:a, 2:a, 21:a, 22:a ... but 11:e and 12:e.
    return ((b == 1 || b == 2) && rem100 != 11 && rem100 != 12) ? 'a' : 'e';
  }
}

/// Swedish relative date time
class SvRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'för';
  @override
  String prefixFromNow() => 'om';
  @override
  String suffixAgo() => 'sedan';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'en stund';
  @override
  String aboutAMinute(int minutes) => 'en minut';
  @override
  String minutes(int minutes) => '$minutes minuter';
  @override
  String aboutAnHour(int minutes) => 'ungefär en timme';
  @override
  String hours(int hours) => '$hours timmar';
  @override
  String aDay(int hours) => 'en dag';
  @override
  String days(int days) => '$days dagar';
  @override
  String aboutAMonth(int days) => 'ungefär en månad';
  @override
  String months(int months) => '$months månader';
  @override
  String aboutAYear(int year) => 'ungefär ett år';
  @override
  String years(int years) => '$years år';
  @override
  String wordSeparator() => ' ';
}

/// Swedish short relative date time
class SvShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'nu';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '~1 h';
  @override
  String hours(int hours) => '$hours h';
  @override
  String aDay(int hours) => '~1 d';
  @override
  String days(int days) => '$days d';
  @override
  String aboutAMonth(int days) => '~1 mån';
  @override
  String months(int months) => '$months mån';
  @override
  String aboutAYear(int year) => '~1 år';
  @override
  String years(int years) => '$years år';
  @override
  String wordSeparator() => ' ';
}

/// Swedish calendar date time
class SvCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Idag $time';
  @override
  String nextDay(String time) => 'Imorgon $time';
  @override
  String lastDay(String time) => 'Igår $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'På $weekday $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'I ${weekday}s $time';
}

/// Swedish duration units
class SvDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      seconds == 1 ? '1 sekund' : '$seconds sekunder';
  @override
  String minutes(int minutes) => minutes == 1 ? '1 minut' : '$minutes minuter';
  @override
  String hours(int hours) => hours == 1 ? '1 timme' : '$hours timmar';
  @override
  String days(int days) => days == 1 ? '1 dag' : '$days dagar';
  @override
  String weeks(int weeks) => weeks == 1 ? '1 vecka' : '$weeks veckor';
  @override
  String delimiter() => ' ';
}

/// Swedish short duration units
class SvShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds sek';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String hours(int hours) => '$hours tim';
  @override
  String days(int days) => '$days d';
  @override
  String weeks(int weeks) => '$weeks v';
  @override
  String delimiter() => ' ';
}
