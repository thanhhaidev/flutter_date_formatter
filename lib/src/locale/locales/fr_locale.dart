import 'package:flutter_date_formatter/src/models/models.dart';

/// French Locale
class FrLocale extends Locale {
  @override
  String code() => 'fr';

  @override
  String ordinal(int n) {
    final ord = n == 1 ? 'er' : '';
    return ord;
  }

  @override
  RelativeDateTime relativeDateTime() => FrRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => FrShortRelativeDateTime();
}

/// French relative date time
class FrRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'il y a';
  @override
  String prefixFromNow() => "d'ici";
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => "moins d'une minute";
  @override
  String aboutAMinute(int minutes) => 'environ une minute';
  @override
  String minutes(int minutes) => 'environ $minutes minutes';
  @override
  String aboutAnHour(int minutes) => 'environ une heure';
  @override
  String hours(int hours) => '$hours heures';
  @override
  String aDay(int hours) => 'environ un jour';
  @override
  String days(int days) => 'environ $days jours';
  @override
  String aboutAMonth(int days) => 'environ un mois';
  @override
  String months(int months) => 'environ $months mois';
  @override
  String aboutAYear(int year) => 'un an';
  @override
  String years(int years) => '$years ans';
  @override
  String wordSeparator() => ' ';
}

/// French short relative date time
class FrShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'il y a';
  @override
  String prefixFromNow() => "d'ici";
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => "moins d'une minute";
  @override
  String aboutAMinute(int minutes) => 'une minute';
  @override
  String minutes(int minutes) => '$minutes minutes';
  @override
  String aboutAnHour(int minutes) => 'une heure';
  @override
  String hours(int hours) => '$hours heures';
  @override
  String aDay(int hours) => 'un jour';
  @override
  String days(int days) => '$days jours';
  @override
  String aboutAMonth(int days) => 'un mois';
  @override
  String months(int months) => '$months mois';
  @override
  String aboutAYear(int year) => 'un an';
  @override
  String years(int years) => '$years ans';
  @override
  String wordSeparator() => ' ';
}
