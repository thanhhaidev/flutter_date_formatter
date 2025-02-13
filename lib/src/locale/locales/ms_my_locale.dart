import 'package:flutter_date_formatter/src/models/models.dart';

/// Malay-Malaysia locale
class MsMyLocale extends Locale {
  @override
  String code() => 'ms_my';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n';

  @override
  RelativeDateTime relativeDateTime() => MsMyRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => MsMyShortRelativeDateTime();
}

/// Malay-Malaysia relative date time
class MsMyRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'lepas';
  @override
  String suffixFromNow() => 'dari sekarang';
  @override
  String lessThanOneMinute(int seconds) => 'saat';
  @override
  String aboutAMinute(int minutes) => 'seminit';
  @override
  String minutes(int minutes) => '$minutes minit';
  @override
  String aboutAnHour(int minutes) => 'sejam';
  @override
  String hours(int hours) => '$hours jam';
  @override
  String aDay(int hours) => 'sehari';
  @override
  String days(int days) => '$days hari';
  @override
  String aboutAMonth(int days) => 'sebulan';
  @override
  String months(int months) => '$months bulan';
  @override
  String aboutAYear(int year) => 'setahun';
  @override
  String years(int years) => '$years tahun';
  @override
  String wordSeparator() => ' ';
}

/// Malay-Malaysia short relative date time
class MsMyShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'sekarang';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '~1 jam';
  @override
  String hours(int hours) => '$hours jam';
  @override
  String aDay(int hours) => '~1 hri';
  @override
  String days(int days) => '$days hri';
  @override
  String aboutAMonth(int days) => '~1 bln';
  @override
  String months(int months) => '$months bln';
  @override
  String aboutAYear(int year) => '~1 thn';
  @override
  String years(int years) => '$years thn';
  @override
  String wordSeparator() => ' ';
}
