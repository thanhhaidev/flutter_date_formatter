import 'package:flutter_date_formatter/src/models/models.dart';

/// Divehi Locale
class DvLocale extends Locale {
  @override
  String code() => 'dv';

  @override
  String ordinal(int n) => '';

  @override
  RelativeDateTime relativeDateTime() => DvRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => DvShortRelativeDateTime();
}

/// Divehi relative date time
class DvRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'ކުރިން';
  @override
  String suffixFromNow() => 'ފަހުން';
  @override
  String lessThanOneMinute(int seconds) => 'ހިނދުކޮޅެއް';
  @override
  String aboutAMinute(int minutes) => 'މިނެޓެއް ހާއިރު';
  @override
  String minutes(int minutes) => '$minutes މިނެޓު';
  @override
  String aboutAnHour(int minutes) => 'ގަޑިއިރެއް ހާއިރު';
  @override
  String hours(int hours) => '$hours ގަޑިއިރު';
  @override
  String aDay(int hours) => 'އެއް ދުވަސް';
  @override
  String days(int days) => '$days ދުވަސް';
  @override
  String aboutAMonth(int days) => 'މަހެއް ހާ ދުވަސް';
  @override
  String months(int months) => '$months މަސް';
  @override
  String aboutAYear(int year) => 'އަހަރެއް ހާ ދުވަސް';
  @override
  String years(int years) => '$years އަހަރު';
  @override
  String wordSeparator() => ' ';
}

/// Divehi short relative date time
class DvShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'މިހާރު';
  @override
  String aboutAMinute(int minutes) => '1 މިނެޓް';
  @override
  String minutes(int minutes) => '$minutes މިނެޓް';
  @override
  String aboutAnHour(int minutes) => '~1 ގ';
  @override
  @override
  String hours(int hours) => '$hours ގ';
  @override
  String aDay(int hours) => '~1 ދުވަސް';
  @override
  String days(int days) => '$days ދުވަސް';
  @override
  String aboutAMonth(int days) => '~1 މަސް';
  @override
  String months(int months) => '$months މަސް';
  @override
  String aboutAYear(int year) => '~1 އަހަރު';
  @override
  String years(int years) => '$years އަހަރު';
  @override
  String wordSeparator() => ' ';
}
