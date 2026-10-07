import 'package:flutter_date_formatter/src/models/models.dart';

/// Cambodian Locale
class KmLocale extends DateFormatterLocale {
  @override
  String code() => 'km';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => 'ទី$n';

  @override
  RelativeDateTime relativeDateTime() => KmRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => KmShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => KmCalendarDateTime();

  @override
  DurationUnits durationUnits() => KmDurationUnits();

  @override
  DurationUnits shortDurationUnits() => KmShortDurationUnits();
}

/// Cambodian relative date time
class KmRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'មុននេះ';
  @override
  String prefixFromNow() => 'ក្រោយពីនេះ';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'បន្ដិច';
  @override
  String aboutAMinute(int minutes) => 'ប្រមាណមួយនាទី';
  @override
  String minutes(int minutes) => ' $minutes នាទី';
  @override
  String aboutAnHour(int minutes) => 'ប្រមាណមួយម៉ោង';
  @override
  String hours(int hours) => ' $hours ម៉ោង';
  @override
  String aDay(int hours) => 'មួយថ្ងៃ';
  @override
  String days(int days) => ' $days ថ្ងៃ';
  @override
  String aboutAMonth(int days) => 'ប្រមាណមួយខែ';
  @override
  String months(int months) => ' $months ខែ';
  @override
  String aboutAYear(int year) => 'ប្រមាណមួយឆ្នាំ';
  @override
  String years(int years) => ' $years ឆ្នាំ';
  @override
  String wordSeparator() => '​';
}

/// Cambodian short relative date time
class KmShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'មិញ';
  @override
  String aboutAMinute(int minutes) => '1 ន';
  @override
  String minutes(int minutes) => '$minutes ន';
  @override
  String aboutAnHour(int minutes) => '~1 ម';
  @override
  String hours(int hours) => '$hours ម';
  @override
  String aDay(int hours) => '~1 ថ';
  @override
  String days(int days) => '$days ថ';
  @override
  String aboutAMonth(int days) => '~1 ខ';
  @override
  String months(int months) => '$months ខ';
  @override
  String aboutAYear(int year) => '~1 ឆ';
  @override
  String years(int years) => '$years ឆ';
  @override
  String wordSeparator() => '';
}

/// Cambodian calendar date time
class KmCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'ថ្ងៃនេះ ម៉ោង $time';
  @override
  String nextDay(String time) => 'ស្អែក ម៉ោង $time';
  @override
  String lastDay(String time) => 'ម្សិលមិញ ម៉ោង $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekday ម៉ោង $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekday សប្តាហ៍មុន ម៉ោង $time';
}

/// Cambodian duration units
class KmDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds វិនាទី';
  @override
  String minutes(int minutes) => '$minutes នាទី';
  @override
  String hours(int hours) => '$hours ម៉ោង';
  @override
  String days(int days) => '$days ថ្ងៃ';
  @override
  String weeks(int weeks) => '$weeks សប្តាហ៍';
  @override
  String delimiter() => ' ';
}

/// Cambodian short duration units
class KmShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds វិ';
  @override
  String minutes(int minutes) => '$minutes នាទី';
  @override
  String hours(int hours) => '$hours ម៉ោង';
  @override
  String days(int days) => '$days ថ្ងៃ';
  @override
  String weeks(int weeks) => '$weeks សប្តាហ៍';
  @override
  String delimiter() => ' ';
}
