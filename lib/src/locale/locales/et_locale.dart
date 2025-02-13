import 'package:flutter_date_formatter/src/models/models.dart';

/// Estonian Locale
class EtLocale extends Locale {
  @override
  String code() => 'et';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => EtRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => EtShortRelativeDateTime();
}

/// Estonian relative date time
class EtRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'tagasi';
  @override
  String suffixFromNow() => 'pärast';
  @override
  String lessThanOneMinute(int seconds) => 'hetk';
  @override
  String aboutAMinute(int minutes) => 'üks minut';
  @override
  String minutes(int minutes) => '$minutes minutit';
  @override
  String aboutAnHour(int minutes) => 'umbes tunni';
  @override
  String hours(int hours) => '$hours tunni';
  @override
  String aDay(int hours) => 'üks päev';
  @override
  String days(int days) => '$days päeva';
  @override
  String aboutAMonth(int days) => 'umbes kuu';
  @override
  String months(int months) => '$months kuud';
  @override
  String aboutAYear(int year) => 'umbes aasta';
  @override
  String years(int years) => '$years aastat';
  @override
  String wordSeparator() => ' ';
}

/// Estonian short relative date time
class EtShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'nüüd';
  @override
  String aboutAMinute(int minutes) => '1m';
  @override
  String minutes(int minutes) => '${minutes}m';
  @override
  String aboutAnHour(int minutes) => '~1t';
  @override
  String hours(int hours) => '${hours}t';
  @override
  String aDay(int hours) => '~1p';
  @override
  String days(int days) => '${days}p';
  @override
  String aboutAMonth(int days) => '~1k';
  @override
  String months(int months) => '${months}k';
  @override
  String aboutAYear(int year) => '~1a';
  @override
  String years(int years) => '${years}a';
  @override
  String wordSeparator() => ' ';
}
