import 'package:flutter_date_formatter/src/models/models.dart';

/// Finnish Locale
class FiLocale extends Locale {
  @override
  String code() => 'fi';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => FiRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => FiShortRelativeDateTime();
}

/// Finnish relative date time
class FiRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'sitten';
  @override
  String suffixFromNow() => 'kuluttua';
  @override
  String lessThanOneMinute(int seconds) => 'hetki';
  @override
  String aboutAMinute(int minutes) => 'noin minuutti';
  @override
  String minutes(int minutes) => '$minutes minuuttia';
  @override
  String aboutAnHour(int minutes) => 'noin tunti';
  @override
  String hours(int hours) => '$hours tuntia';
  @override
  String aDay(int hours) => 'vuorokausi';
  @override
  String days(int days) => '$days päivää';
  @override
  String aboutAMonth(int days) => 'noin kuukausi';
  @override
  String months(int months) => '$months kuukautta';
  @override
  String aboutAYear(int year) => 'noin vuosi';
  @override
  String years(int years) => '$years vuotta';
  @override
  String wordSeparator() => ' ';
}

/// Finnish short relative date time
class FiShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'nyt';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min:ia';
  @override
  String aboutAnHour(int minutes) => '~1 t';
  @override
  String hours(int hours) => '$hours t';
  @override
  String aDay(int hours) => '~pvä';
  @override
  String days(int days) => '$days pvää';
  @override
  String aboutAMonth(int days) => '~kk';
  @override
  String months(int months) => '$months kk:ta';
  @override
  String aboutAYear(int year) => '~1 v';
  @override
  String years(int years) => '${years}v:ta';
  @override
  String wordSeparator() => ' ';
}
