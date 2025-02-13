import 'package:flutter_date_formatter/src/models/models.dart';

/// Cambodian Locale
class KmLocale extends Locale {
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
