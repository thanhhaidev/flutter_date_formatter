import 'package:flutter_date_formatter/src/models/models.dart';

/// Urdu Locale
class UrLocale extends Locale {
  @override
  String code() => 'ur';

  @override
  String ordinal(int n) => '';

  @override
  RelativeDateTime relativeDateTime() => UrRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => UrShortRelativeDateTime();
}

/// Urdu relative date time
class UrRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'پہلے';
  @override
  String suffixFromNow() => 'اب سے';
  @override
  String lessThanOneMinute(int seconds) => 'ایک لمحہ';
  @override
  String aboutAMinute(int minutes) => 'ایک منٹ';
  @override
  String minutes(int minutes) => '${_convertToUrduNumbers(minutes)} منٹ';
  @override
  String aboutAnHour(int minutes) => 'ایک گھنٹہ';
  @override
  String hours(int hours) => '${_convertToUrduNumbers(hours)} گھنٹے';
  @override
  String aDay(int hours) => 'ایک دن';
  @override
  String days(int days) => '${_convertToUrduNumbers(days)} دن';
  @override
  String aboutAMonth(int days) => 'ایک مہینہ';
  @override
  String months(int months) => '${_convertToUrduNumbers(months)} مہینہ';
  @override
  String aboutAYear(int year) => 'ایک سال';
  @override
  String years(int years) => '${_convertToUrduNumbers(years)} برس';
  @override
  String wordSeparator() => ' ';
}

/// Urdu short relative date time
class UrShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'ابھی';
  @override
  String aboutAMinute(int minutes) => '١ م';
  @override
  String minutes(int minutes) => '${_convertToUrduNumbers(minutes)} منٹ';
  @override
  String aboutAnHour(int minutes) => '~١ گھ';
  @override
  String hours(int hours) => '${_convertToUrduNumbers(hours)} گھ';
  @override
  String aDay(int hours) => '~١ د';
  @override
  String days(int days) => '${_convertToUrduNumbers(days)} د';
  @override
  String aboutAMonth(int days) => '~١ ماہ';
  @override
  String months(int months) => '${_convertToUrduNumbers(months)} ماہ';
  @override
  String aboutAYear(int year) => '~١ س';
  @override
  String years(int years) => '${_convertToUrduNumbers(years)} س';
  @override
  String wordSeparator() => ' ';
}

String _convertToUrduNumbers(int input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const urdu = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  var result = input.toString();
  for (var i = 0; i < english.length; i++) {
    result = result.replaceAll(english[i], urdu[i]);
  }

  return result;
}
