import 'package:flutter_date_formatter/src/models/models.dart';

/// Romanian Locale
class RoLocale extends Locale {
  @override
  String code() => 'ro';

  @override
  String ordinal(int n) => '';

  @override
  RelativeDateTime relativeDateTime() => RoRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => RoShortRelativeDateTime();
}

/// Romanian relative date time
class RoRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'acum';
  @override
  String prefixFromNow() => 'peste';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'o clipă';
  @override
  String aboutAMinute(int minutes) => 'un minut';
  @override
  String minutes(int minutes) => '$minutes minute';
  @override
  String aboutAnHour(int minutes) => 'o oră';
  @override
  String hours(int hours) => '$hours ore';
  @override
  String aDay(int hours) => 'o zi';
  @override
  String days(int days) => '$days zile';
  @override
  String aboutAMonth(int days) => 'o luna';
  @override
  String months(int months) => '$months luni';
  @override
  String aboutAYear(int year) => 'un an';
  @override
  String years(int years) => '$years ani';
  @override
  String wordSeparator() => ' ';
}

/// Romanian short relative date time
class RoShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'acum';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '~1 oră';
  @override
  String hours(int hours) => '$hours ore';
  @override
  String aDay(int hours) => '~1 zi';
  @override
  String days(int days) => '$days zile';
  @override
  String aboutAMonth(int days) => '~1 luni';
  @override
  String months(int months) => '$months luni';
  @override
  String aboutAYear(int year) => '~1 ani';
  @override
  String years(int years) => '$years ani';
  @override
  String wordSeparator() => ' ';
}
