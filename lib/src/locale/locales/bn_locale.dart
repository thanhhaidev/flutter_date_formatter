import 'package:flutter_date_formatter/src/models/models.dart';
import 'package:intl/intl.dart';

/// Bengali locale
class BnLocale extends Locale {
  @override
  String code() => 'bn';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => NumberFormat.compact(locale: 'bn').format(n);

  @override
  RelativeDateTime relativeDateTime() => BnRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => BnShortRelativeDateTime();
}

/// Bengali relative date time
class BnRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'আগে';
  @override
  String suffixFromNow() => 'এখন থেকে';
  @override
  String lessThanOneMinute(int seconds) => 'কিছুক্ষন';
  @override
  String aboutAMinute(int minutes) => 'প্রায় এক মিনিট';
  @override
  String minutes(int minutes) => '$minutes মিনিট';
  @override
  String aboutAnHour(int minutes) => 'প্রায় এক ঘন্টা';
  @override
  String hours(int hours) => '$hours ঘন্টা';
  @override
  String aDay(int hours) => 'এক দিন';
  @override
  String days(int days) =>
      '${NumberFormat.compact(locale: 'bn').format(days)} দিন';
  @override
  String aboutAMonth(int days) => 'প্রায় এক মাস';
  @override
  String months(int months) =>
      '${NumberFormat.compact(locale: 'bn').format(months)} মাস';
  @override
  String aboutAYear(int year) => 'প্রায় এক বছর';
  @override
  String years(int years) =>
      '${NumberFormat.compact(locale: 'bn').format(years)} বছর';
  @override
  String wordSeparator() => ' ';
}

/// Bengali short relative date time
class BnShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'এখন';
  @override
  String aboutAMinute(int minutes) => '১মিনিট ';
  @override
  String minutes(int minutes) =>
      '${NumberFormat.compact(locale: 'bn').format(minutes)}মিনিট';
  @override
  String aboutAnHour(int minutes) => '~১ঘন্টা';
  @override
  String hours(int hours) =>
      '${NumberFormat.compact(locale: 'bn').format(hours)}ঘন্টা';
  @override
  String aDay(int hours) => '~১দি';
  @override
  String days(int days) =>
      '${NumberFormat.compact(locale: 'bn').format(days)}দি';
  @override
  String aboutAMonth(int days) => '~১মাস';
  @override
  String months(int months) =>
      '${NumberFormat.compact(locale: 'bn').format(months)}মাস';
  @override
  String aboutAYear(int year) => '~১বছর';
  @override
  String years(int years) =>
      '${NumberFormat.compact(locale: 'bn').format(years)}বছর';
  @override
  String wordSeparator() => ' ';
}
