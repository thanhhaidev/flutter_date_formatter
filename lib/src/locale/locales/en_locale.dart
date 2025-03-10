import 'package:flutter_date_formatter/src/models/models.dart';

/// English locale
class EnLocale extends Locale {
  @override
  String code() => 'en';

  @override
  String ordinal(int n) => _getOrdinalSuffix(n);

  @override
  String ordinalNumber(int n) => '$n${_getOrdinalSuffix(n)}';

  @override
  RelativeDateTime relativeDateTime() => EnRelativeTime();

  @override
  RelativeDateTime shortRelativeDateTime() => EnShortRelativeTime();

  String _getOrdinalSuffix(int n) {
    const ordinals = ['st', 'nd', 'rd', 'th'];
    var suffix = ordinals.last;
    final digit = n % 10;
    if ((digit > 0 && digit < 4) && (n < 11 || n > 13)) {
      suffix = ordinals[digit - 1];
    }
    return suffix;
  }
}

/// English relative date time
class EnRelativeTime extends RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'in';
  @override
  String suffixAgo() => 'ago';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'a few seconds';
  @override
  String aboutAMinute(int minutes) => 'a minute';
  @override
  String minutes(int minutes) => '$minutes minutes';
  @override
  String aboutAnHour(int minutes) => 'an hour';
  @override
  String hours(int hours) => '$hours hours';
  @override
  String aDay(int hours) => 'a day';
  @override
  String days(int days) => '$days days';
  @override
  String aboutAMonth(int days) => 'a month';
  @override
  String months(int months) => '$months months';
  @override
  String aboutAYear(int year) => 'a year';
  @override
  String years(int years) => '$years years';
  @override
  String wordSeparator() => ' ';
}

/// English short relative date time
class EnShortRelativeTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'now';
  @override
  String aboutAMinute(int minutes) => '1m';
  @override
  String minutes(int minutes) => '${minutes}m';
  @override
  String aboutAnHour(int minutes) => '~1h';
  @override
  String hours(int hours) => '${hours}h';
  @override
  String aDay(int hours) => '~1d';
  @override
  String days(int days) => '${days}d';
  @override
  String aboutAMonth(int days) => '~1mo';
  @override
  String months(int months) => '${months}mo';
  @override
  String aboutAYear(int year) => '~1y';
  @override
  String years(int years) => '${years}y';
  @override
  String wordSeparator() => ' ';
}
