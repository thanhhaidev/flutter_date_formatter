import 'package:flutter_date_formatter/src/models/models.dart';

/// Catalan locale
class CaLocale extends Locale {
  @override
  String code() => 'ca';

  @override
  String ordinal(int n) {
    String ord;
    if (n == 1 || n == 3) {
      ord = 'r';
    } else if (n == 2) {
      ord = 'n';
    } else if (n == 4) {
      ord = 't';
    } else {
      ord = 'è';
    }
    return ord;
  }

  @override
  RelativeDateTime relativeDateTime() => CaRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => CaShortRelativeDateTime();
}

/// Catalan relative date time
class CaRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'fa';
  @override
  String prefixFromNow() => "d'aquí a";
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'un moment';
  @override
  String aboutAMinute(int minutes) => 'un minut';
  @override
  String minutes(int minutes) => '$minutes minuts';
  @override
  String aboutAnHour(int minutes) => 'una hora';
  @override
  String hours(int hours) => '$hours hores';
  @override
  String aDay(int hours) => 'un dia';
  @override
  String days(int days) => '$days dies';
  @override
  String aboutAMonth(int days) => 'un mes';
  @override
  String months(int months) => '$months mesos';
  @override
  String aboutAYear(int year) => 'un any';
  @override
  String years(int years) => '$years anys';
  @override
  String wordSeparator() => ' ';
}

/// Catalan short relative date time
class CaShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'ara';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '~1 hr';
  @override
  String hours(int hours) => '$hours hr';
  @override
  String aDay(int hours) => '~1 dia';
  @override
  String days(int days) => '$days dies';
  @override
  String aboutAMonth(int days) => '~1 mes';
  @override
  String months(int months) => '$months mesos';
  @override
  String aboutAYear(int year) => '~1 any';
  @override
  String years(int years) => '$years anys';
  @override
  String wordSeparator() => ' ';
}
