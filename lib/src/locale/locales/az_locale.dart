import 'package:flutter_date_formatter/src/models/models.dart';

/// Azerbaijani locale.
class AzLocale extends Locale {
  @override
  String code() => 'az';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => "$n'inci";

  @override
  RelativeDateTime relativeDateTime() => AzRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => AzShortRelativeDateTime();
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
  String suffixFromNow() => 'indidən';
  @override
  String lessThanOneMinute(int seconds) => 'bir dəqiqə';
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
