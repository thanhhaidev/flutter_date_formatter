import 'package:flutter_date_formatter/src/models/models.dart';

/// Turkish Locale
class TrLocale extends Locale {
  @override
  String code() => 'tr';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => TrRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => TrShortRelativeDateTime();
}

/// Turkish relative date time
class TrRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'önce';
  @override
  String suffixFromNow() => 'kaldı';
  @override
  String lessThanOneMinute(int seconds) => 'biraz';
  @override
  String aboutAMinute(int minutes) => 'bir dakika';
  @override
  String minutes(int minutes) => '$minutes dakika';
  @override
  String aboutAnHour(int minutes) => 'bir saat';
  @override
  String hours(int hours) => '$hours saat';
  @override
  String aDay(int hours) => 'bir gün';
  @override
  String days(int days) => '$days gün';
  @override
  String aboutAMonth(int days) => 'bir ay';
  @override
  String months(int months) => '$months ay';
  @override
  String aboutAYear(int year) => 'bir yıl';
  @override
  String years(int years) => '$years yıl';
  @override
  String wordSeparator() => ' ';
}

/// Turkish short relative date time
class TrShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'az önce';
  @override
  String aboutAMinute(int minutes) => '1dk';
  @override
  String minutes(int minutes) => '${minutes}dk';
  @override
  String aboutAnHour(int minutes) => '~1sa';
  @override
  String hours(int hours) => '${hours}sa';
  @override
  String aDay(int hours) => '~1g';
  @override
  String days(int days) => '${days}g';
  @override
  String aboutAMonth(int days) => '~1ay';
  @override
  String months(int months) => '${months}ay';
  @override
  String aboutAYear(int year) => '~1y';
  @override
  String years(int years) => '${years}y';
  @override
  String wordSeparator() => ' ';
}
