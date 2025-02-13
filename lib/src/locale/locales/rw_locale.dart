import 'package:flutter_date_formatter/src/models/models.dart';

/// Kinyarwanda Locale
class RwLocale extends Locale {
  @override
  String code() => 'rw';

  @override
  String ordinal(int n) => '';

  @override
  RelativeDateTime relativeDateTime() => RwRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => RwShortRelativeDateTime();
}

/// Kinyarwanda Messages
class RwRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'hashize';
  @override
  String prefixFromNow() => 'kuva';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'agahe gato';
  @override
  String aboutAMinute(int minutes) => 'umunota';
  @override
  String minutes(int minutes) => 'iminota $minutes';
  @override
  String aboutAnHour(int minutes) => 'isaha';
  @override
  String hours(int hours) => 'amasaha $hours';
  @override
  String aDay(int hours) => 'umunsi';
  @override
  String days(int days) => 'iminsi $days';
  @override
  String aboutAMonth(int days) => 'ukwezi';
  @override
  String months(int months) => 'amezi $months';
  @override
  String aboutAYear(int year) => 'umwaka';
  @override
  String years(int years) => 'imyaka$years';
  @override
  String wordSeparator() => ' ';
}

/// Kinyarwanda short Messages
class RwShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'ubu';
  @override
  String aboutAMinute(int minutes) => 'umunota';
  @override
  String minutes(int minutes) => 'iminota $minutes';
  @override
  String aboutAnHour(int minutes) => 'isaha';
  @override
  String hours(int hours) => 'amasaha $hours';
  @override
  String aDay(int hours) => 'umunsi';
  @override
  String days(int days) => 'iminsi $days';
  @override
  String aboutAMonth(int days) => 'ukwezi';
  @override
  String months(int months) => 'amezi $months';
  @override
  String aboutAYear(int year) => 'umwaka';
  @override
  String years(int years) => 'imyaka $years';
  @override
  String wordSeparator() => ' ';
}
