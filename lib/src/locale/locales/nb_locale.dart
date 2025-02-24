import 'package:flutter_date_formatter/src/models/models.dart';

/// Norwegian-Bokm-Norway locale
class NbLocale extends Locale {
  @override
  String code() => 'nb';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => NbRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => NbShortRelativeDateTime();
}

/// Norwegian-Bokm-Norway relative date time
class NbRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'om';
  @override
  String suffixAgo() => 'siden';
  @override
  String suffixFromNow() => 'fra nå';
  @override
  String lessThanOneMinute(int seconds) => 'ett øyeblikk';
  @override
  String aboutAMinute(int minutes) => 'ett minutt';
  @override
  String minutes(int minutes) => '$minutes minutter';
  @override
  String aboutAnHour(int minutes) => 'rundt en time';
  @override
  String hours(int hours) => '$hours timer';
  @override
  String aDay(int hours) => 'en dag';
  @override
  String days(int days) => '$days dager';
  @override
  String aboutAMonth(int days) => 'omtrent en måned';
  @override
  String months(int months) => '$months måneder';
  @override
  String aboutAYear(int year) => 'omtrent et år';
  @override
  String years(int years) => '$years år';
  @override
  String wordSeparator() => ' ';
}

/// Norwegian-Bokm-Norway short relative date time
class NbShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'nå';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '~1 t';
  @override
  String hours(int hours) => '$hours t';
  @override
  String aDay(int hours) => '~1 d';
  @override
  String days(int days) => '$days d';
  @override
  String aboutAMonth(int days) => '~1 mnd';
  @override
  String months(int months) => '$months mnd';
  @override
  String aboutAYear(int year) => '~1 år';
  @override
  String years(int years) => '$years år';
  @override
  String wordSeparator() => ' ';
}
