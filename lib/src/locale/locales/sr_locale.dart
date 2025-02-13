import 'package:flutter_date_formatter/src/models/models.dart';

/// Serbian Locale
class SrLocale extends Locale {
  @override
  String code() => 'sr';

  @override
  String ordinal(int n) => '.';

  @override
  RelativeDateTime relativeDateTime() => SrRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => SrShortRelativeDateTime();
}

/// Serbian relative date time
class SrRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'пре';
  @override
  String prefixFromNow() => 'за';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'мање од минута';
  @override
  String aboutAMinute(int minutes) => 'пре минут';
  @override
  String minutes(int minutes) => '$minutes минута';
  @override
  String aboutAnHour(int minutes) => '~1 сат';
  @override
  String hours(int hours) => '$hours сати';
  @override
  String aDay(int hours) => '~1 дан';
  @override
  String days(int days) => '$days дана';
  @override
  String aboutAMonth(int days) => '~1 месец';
  @override
  String months(int months) => '$months месеци';
  @override
  String aboutAYear(int year) => '~1 година';
  @override
  String years(int years) => '$years године';
  @override
  String wordSeparator() => ' ';
}

/// Serbian short relative date time
class SrShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'сад';
  @override
  String aboutAMinute(int minutes) => '1 мин.';
  @override
  String minutes(int minutes) => '$minutes мин.';
  @override
  String aboutAnHour(int minutes) => '~1 ч.';
  @override
  String hours(int hours) => '$hours ч.';
  @override
  String aDay(int hours) => '~1 д.';
  @override
  String days(int days) => '$days д.';
  @override
  String aboutAMonth(int days) => '~1 м.';
  @override
  String months(int months) => '$months м.';
  @override
  String aboutAYear(int year) => '~1 г.';
  @override
  String years(int years) => '$years г.';
  @override
  String wordSeparator() => ' ';
}
