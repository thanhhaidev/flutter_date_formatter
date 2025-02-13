import 'package:flutter_date_formatter/src/models/models.dart';
import 'package:intl/intl.dart';

/// Pashto Locale
class PsLocale extends Locale {
  @override
  String code() => 'ps';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) =>
      '${NumberFormat.compact(locale: 'ps').format(n)}th';

  @override
  RelativeDateTime relativeDateTime() => PsRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => PsRelativeDateTime();
}

/// Pashto relative date time
class PsRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'مخکې';
  @override
  String suffixFromNow() => 'له اوس څخه';
  @override
  String lessThanOneMinute(int seconds) => 'یوه شیبه';
  @override
  String aboutAMinute(int minutes) => 'ځینې ​​شیبې';
  @override
  String minutes(int minutes) =>
      '${NumberFormat.compact(locale: 'ps').format(minutes)} دقیقې';
  @override
  String aboutAnHour(int minutes) => 'شاوخوا یو ساعت';
  @override
  String hours(int hours) =>
      '${NumberFormat.compact(locale: 'ps').format(hours)} ساعته';
  @override
  String aDay(int hours) => 'یوه ورځ';
  @override
  String days(int days) =>
      '${NumberFormat.compact(locale: 'ps').format(days)} ورځې';
  @override
  String aboutAMonth(int days) => 'شاوخوا یوه میاشت ';
  @override
  String months(int months) =>
      '${NumberFormat.compact(locale: 'ps').format(months)} میاشتې';
  @override
  String aboutAYear(int year) => 'شاوخوا یو کال';
  @override
  String years(int years) =>
      '${NumberFormat.compact(locale: 'ps').format(years)} کاله';
  @override
  String wordSeparator() => ' ';
}
