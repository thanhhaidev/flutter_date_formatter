import 'package:flutter_date_formatter/src/models/models.dart';

/// Hebrew Locale
class HeLocale extends Locale {
  @override
  String code() => 'he';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n';

  @override
  RelativeDateTime relativeDateTime() => HeRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => HeShortRelativeDateTime();
}

/// Hebrew relative date time
class HeRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'לפני';
  @override
  String prefixFromNow() => 'בעוד';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'כמה רגעים';
  @override
  String aboutAMinute(int minutes) => 'דקה';
  @override
  String minutes(int minutes) => '$minutes דקות';
  @override
  String aboutAnHour(int minutes) => 'כשעה';
  @override
  String hours(int hours) => '$hours שעות';
  @override
  String aDay(int hours) => 'יום';
  @override
  String days(int days) => '$days ימים';
  @override
  String aboutAMonth(int days) => 'כחודש';
  @override
  String months(int months) => '$months חודשים';
  @override
  String aboutAYear(int year) => 'כשנה';
  @override
  String years(int years) => '$years שנים';
  @override
  String wordSeparator() => ' ';
}

/// Hebrew short relative date time
class HeShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'בעוד';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'כעת';
  @override
  String aboutAMinute(int minutes) => 'דקה';
  @override
  String minutes(int minutes) => '$minutes דקות';
  @override
  String aboutAnHour(int minutes) => 'כשעה';
  @override
  String hours(int hours) => '$hours שעות';
  @override
  String aDay(int hours) => 'יום';
  @override
  String days(int days) => '$days ימים';
  @override
  String aboutAMonth(int days) => 'כחודש';
  @override
  String months(int months) => '$months חודשים';
  @override
  String aboutAYear(int year) => 'כשנה';
  @override
  String years(int years) => '$years שנים';
  @override
  String wordSeparator() => ' ';
}
