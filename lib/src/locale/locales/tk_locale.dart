import 'package:flutter_date_formatter/src/models/models.dart';

/// Turkish Locale
class TkLocale extends Locale {
  @override
  String code() => 'tk';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '${n}th';

  @override
  RelativeDateTime relativeDateTime() => TkRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => TkRelativeDateTime();
}

/// Turkish relative date time
class TkRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'öň';
  @override
  String suffixFromNow() => 'galdy';
  @override
  String lessThanOneMinute(int seconds) => 'biraz';
  @override
  String aboutAMinute(int minutes) => 'bir minut';
  @override
  String minutes(int minutes) => '$minutes minut';
  @override
  String aboutAnHour(int minutes) => 'bir sagat';
  @override
  String hours(int hours) => '$hours sagat';
  @override
  String aDay(int hours) => 'bir gün';
  @override
  String days(int days) => '$days gün';
  @override
  String aboutAMonth(int days) => 'bir aý';
  @override
  String months(int months) => '$months aý';
  @override
  String aboutAYear(int year) => 'bir ýyl';
  @override
  String years(int years) => '$years ýyl';
  @override
  String wordSeparator() => ' ';
}
