import 'package:flutter_date_formatter/src/models/models.dart';

/// A class that represents the Bengali locale.
class BnLocale extends Locale {
  @override
  String code() => 'bn';

  @override
  String ordinal(int n) => '';

  @override
  RelativeDateTime relativeDateTime() => BnRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => BnShortRelativeDateTime();
}

/// A class that represents the Bengali locale.
class BnRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'আগে';
  @override
  String suffixFromNow() => 'এখন থেকে';
  @override
  String lessThanOneMinute(int seconds) => 'কিছুক্ষন';
  @override
  String aboutAMinute(int minutes) => 'এক মিনিট';
  @override
  String minutes(int minutes) => '$minutes মিনিট';
  @override
  String aboutAnHour(int minutes) => 'এক ঘন্টা';
  @override
  String hours(int hours) => '$hours ঘন্টা';
  @override
  String aDay(int hours) => 'এক দিন';
  @override
  String days(int days) => '$days দিন';
  @override
  String aboutAMonth(int days) => 'এক মাস';
  @override
  String months(int months) => '$months মাস';
  @override
  String aboutAYear(int year) => 'এক বছর';
  @override
  String years(int years) => '$years বছর';
  @override
  String wordSeparator() => ' ';
}

/// A class that represents the Bengali short locale.
class BnShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'এখন';
  @override
  String aboutAMinute(int minutes) => '1মিনিট';
  @override
  String minutes(int minutes) => '$minutesমাস';
  @override
  String aboutAnHour(int minutes) => '~1ঘন্টা';
  @override
  String hours(int hours) => '$hoursঘন্টা';
  @override
  String aDay(int hours) => '~1দিন';
  @override
  String days(int days) => '$daysদিন';
  @override
  String aboutAMonth(int days) => '~1মাস';
  @override
  String months(int months) => '$monthsমাস';
  @override
  String aboutAYear(int year) => '~1বছর';
  @override
  String years(int years) => '$yearsবছর';
  @override
  String wordSeparator() => ' ';
}
