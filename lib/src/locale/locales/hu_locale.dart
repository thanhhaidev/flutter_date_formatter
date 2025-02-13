import 'package:flutter_date_formatter/src/models/models.dart';

/// Hungarian Locale
class HuLocale extends Locale {
  @override
  String code() => 'hu';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => HuRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => HuShortRelativeDateTime();
}

/// Hungarian relative date time
class HuRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'ezelőtt';
  @override
  String prefixFromNow() => 'mostantól';
  @override
  String suffixAgo() => 'e';
  @override
  String suffixFromNow() => 'mostantól';
  @override
  String lessThanOneMinute(int seconds) => 'kevesebb mint egy perc';
  @override
  String aboutAMinute(int minutes) => 'kb. egy perc';
  @override
  String minutes(int minutes) => '$minutes perc';
  @override
  String aboutAnHour(int minutes) => 'kb. 1 óra';
  @override
  String hours(int hours) => '$hours óra';
  @override
  String aDay(int hours) => 'egy nap';
  @override
  String days(int days) => '$days napok';
  @override
  String aboutAMonth(int days) => 'kb. egy hónap';
  @override
  String months(int months) => '$months hónap';
  @override
  String aboutAYear(int year) => 'kb. egy év';
  @override
  String years(int years) => '$years évek';
  @override
  String wordSeparator() => ' ';
}

/// Hungarian short relative date time
class HuShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'ezelőtt';
  @override
  String prefixFromNow() => 'mostantól';
  @override
  String suffixAgo() => 'e';
  @override
  String suffixFromNow() => 'mostantól';
  @override
  String lessThanOneMinute(int seconds) => 'kevesebb mint egy perc';
  @override
  String aboutAMinute(int minutes) => 'kb. 1 perc';
  @override
  String minutes(int minutes) => '$minutes perc';
  @override
  String aboutAnHour(int minutes) => 'kb. 1 óra';
  @override
  String hours(int hours) => '$hours óra';
  @override
  String aDay(int hours) => 'egy nap';
  @override
  String days(int days) => '$days nap';
  @override
  String aboutAMonth(int days) => 'kb. 1 hónap';
  @override
  String months(int months) => '$months honap';
  @override
  String aboutAYear(int year) => 'kb. 1 év';
  @override
  String years(int years) => '$years év';
  @override
  String wordSeparator() => ' ';
}
