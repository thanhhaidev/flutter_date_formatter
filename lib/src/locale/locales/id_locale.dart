import 'package:flutter_date_formatter/src/models/models.dart';

/// Indonesian Locale
class IdLocale extends Locale {
  @override
  String code() => 'id';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => 'ke-$n';

  @override
  RelativeDateTime relativeDateTime() => IdRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => IdShortRelativeDateTime();
}

/// Indonesian relative date time
class IdRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'yang lalu';
  @override
  String suffixFromNow() => 'dari sekarang';
  @override
  String lessThanOneMinute(int seconds) => 'kurang dari semenit';
  @override
  String aboutAMinute(int minutes) => 'semenit';
  @override
  String minutes(int minutes) => '$minutes menit';
  @override
  String aboutAnHour(int minutes) => 'sekitar sejam';
  @override
  String hours(int hours) => '$hours jam';
  @override
  String aDay(int hours) => 'sehari';
  @override
  String days(int days) => '$days hari';
  @override
  String aboutAMonth(int days) => 'sekitar sebulan';
  @override
  String months(int months) => '$months bulan';
  @override
  String aboutAYear(int year) => 'sekitar setahun';
  @override
  String years(int years) => '$years tahun';
  @override
  String wordSeparator() => ' ';
}

/// Indonesian short relative date time
class IdShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'baru saja';
  @override
  String aboutAMinute(int minutes) => '1m';
  @override
  String minutes(int minutes) => '${minutes}m';
  @override
  String aboutAnHour(int minutes) => '~1j';
  @override
  String hours(int hours) => '${hours}j';
  @override
  String aDay(int hours) => '~1h';
  @override
  String days(int days) => '${days}h';
  @override
  String aboutAMonth(int days) => '~1bln';
  @override
  String months(int months) => '${months}bln';
  @override
  String aboutAYear(int year) => '~1th';
  @override
  String years(int years) => '${years}th';
  @override
  String wordSeparator() => ' ';
}
