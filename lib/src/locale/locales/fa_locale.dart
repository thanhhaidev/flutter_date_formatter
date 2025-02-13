import 'package:flutter_date_formatter/src/models/models.dart';
import 'package:intl/intl.dart';

/// Farsi Locale
class FaLocale extends Locale {
  @override
  String code() => 'fa';

  @override
  String ordinal(int n) => 'م';

  @override
  String ordinalNumber(int n) =>
      '${NumberFormat.compact(locale: 'fa').format(n)}.';

  @override
  RelativeDateTime relativeDateTime() => FaRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => FaRelativeDateTime();
}

/// Farsi relative date time
class FaRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'پیش';
  @override
  String suffixFromNow() => 'بعد';
  @override
  String lessThanOneMinute(int seconds) => 'چند لحظه';
  @override
  String aboutAMinute(int minutes) => 'یک دقیقه';
  @override
  String minutes(int minutes) =>
      '${NumberFormat.compact(locale: 'fa').format(minutes)} دقیقه';
  @override
  String aboutAnHour(int minutes) => '~یک ساعت';
  @override
  String hours(int hours) =>
      '${NumberFormat.compact(locale: 'fa').format(hours)} ساعت';
  @override
  String aDay(int hours) => '~یک روز';
  @override
  String days(int days) =>
      '${NumberFormat.compact(locale: 'fa').format(days)} روز';
  @override
  String aboutAMonth(int days) => '~یک ماه';
  @override
  String months(int months) =>
      '${NumberFormat.compact(locale: 'fa').format(months)} ماه';
  @override
  String aboutAYear(int year) => '~یک سال';
  @override
  String years(int years) =>
      '${NumberFormat.compact(locale: 'fa').format(years)} سال';
  @override
  String wordSeparator() => ' ';
}
