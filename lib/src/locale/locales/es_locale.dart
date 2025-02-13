import 'package:flutter_date_formatter/src/models/models.dart';

/// A class that represents the Spanish locale.
class EsLocale extends Locale {
  @override
  String code() => 'es';

  @override
  String ordinal(int n) => 'º';

  @override
  RelativeDateTime relativeDateTime() => EsRelativeTime();

  @override
  RelativeDateTime shortRelativeDateTime() => EsRelativeTime();
}

/// A class that formats relative date/time values for the Spanish locale.
class EsRelativeTime extends RelativeDateTime {
  @override
  String prefixAgo() => 'hace';
  @override
  String prefixFromNow() => 'en';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'un momento';
  @override
  String aboutAMinute(int minutes) => 'un minuto';
  @override
  String minutes(int minutes) => '$minutes minutos';
  @override
  String aboutAnHour(int minutes) => 'una hora';
  @override
  String hours(int hours) => '$hours horas';
  @override
  String aDay(int hours) => 'un día';
  @override
  String days(int days) => '$days días';
  @override
  String aboutAMonth(int days) => 'un mes';
  @override
  String months(int months) => '$months meses';
  @override
  String aboutAYear(int year) => 'un año';
  @override
  String years(int years) => '$years años';
  @override
  String wordSeparator() => ' ';
}
