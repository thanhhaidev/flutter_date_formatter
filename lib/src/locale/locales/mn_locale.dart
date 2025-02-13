import 'package:flutter_date_formatter/src/models/models.dart';

/// Mongolian Locale
class MnLocale extends Locale {
  @override
  String code() => 'mn';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '${n}th';

  @override
  RelativeDateTime relativeDateTime() => MnRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => MnShortRelativeDateTime();
}

/// Mongolian relative date time
class MnRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'өмнө';
  @override
  String suffixFromNow() => 'дараа';
  @override
  String lessThanOneMinute(int seconds) => 'хэдхэн мөчийн';
  @override
  String aboutAMinute(int minutes) => 'минутын';
  @override
  String minutes(int minutes) => '$minutes минутын';
  @override
  String aboutAnHour(int minutes) => 'цаг орчим';
  @override
  String hours(int hours) => '$hours цагийн';
  @override
  String aDay(int hours) => 'өдрийн';
  @override
  String days(int days) => '$days өдрийн';
  @override
  String aboutAMonth(int days) => 'сар орчмын';
  @override
  String months(int months) => '$months сарын';
  @override
  String aboutAYear(int year) => 'жил орчмын';
  @override
  String years(int years) => '$years жилийн';
  @override
  String wordSeparator() => ' ';
}

/// Mongolian short relative date time
class MnShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'саяхан';
  @override
  String aboutAMinute(int minutes) => '1 мин';
  @override
  String minutes(int minutes) => '$minutes мин';
  @override
  String aboutAnHour(int minutes) => '~1 ц';
  @override
  String hours(int hours) => '$hours ц';
  @override
  String aDay(int hours) => '~1 ө';
  @override
  String days(int days) => '$days ө';
  @override
  String aboutAMonth(int days) => '~1 с';
  @override
  String months(int months) => '$months с';
  @override
  String aboutAYear(int year) => '~1 ж';
  @override
  String years(int years) => '$years ж';
  @override
  String wordSeparator() => ' ';
}
