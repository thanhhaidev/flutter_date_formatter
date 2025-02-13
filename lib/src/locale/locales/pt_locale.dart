import 'package:flutter_date_formatter/src/models/models.dart';

/// Portuguese-Brazil locale
class PtLocale extends Locale {
  @override
  String code() => 'pt';

  @override
  String ordinal(int n) => 'º';

  @override
  RelativeDateTime relativeDateTime() => PtRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => PtShortRelativeDateTime();
}

/// Portuguese-Brazil relative date time
class PtRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'há';
  @override
  String prefixFromNow() => 'em';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'alguns segundos';
  @override
  String aboutAMinute(int minutes) => 'cerca de um minuto';
  @override
  String minutes(int minutes) => '$minutes minutos';
  @override
  String aboutAnHour(int minutes) => 'cerca de uma hora';
  @override
  String hours(int hours) => '$hours horas';
  @override
  String aDay(int hours) => 'um dia';
  @override
  String days(int days) => '$days dias';
  @override
  String aboutAMonth(int days) => 'cerca de um mês';
  @override
  String months(int months) => '$months meses';
  @override
  String aboutAYear(int year) => 'cerca de um ano';
  @override
  String years(int years) => '$years anos';
  @override
  String wordSeparator() => ' ';
}

/// Portuguese-Brazil short relative date time
class PtShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'agora';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '~1h';
  @override
  String hours(int hours) => '$hours h';
  @override
  String aDay(int hours) => '~1 dia';
  @override
  String days(int days) => '$days dias';
  @override
  String aboutAMonth(int days) => '~1 mês';
  @override
  String months(int months) => '$months meses';
  @override
  String aboutAYear(int year) => '~1 ano';
  @override
  String years(int years) => '$years anos';
  @override
  String wordSeparator() => ' ';
}
