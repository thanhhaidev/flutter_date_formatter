import 'package:flutter_date_formatter/src/models/models.dart';

/// Urdu Locale
class UrLocale extends DateFormatterLocale {
  @override
  String code() => 'ur';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) {
    // Urdu ordinals are irregular for 1-4 and 6, otherwise the suffix "واں".
    switch (n) {
      case 1:
        return 'پہلا';
      case 2:
        return 'دوسرا';
      case 3:
        return 'تیسرا';
      case 4:
        return 'چوتھا';
      case 6:
        return 'چھٹا';
      default:
        return '$nواں';
    }
  }

  @override
  RelativeDateTime relativeDateTime() => UrRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => UrShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => UrCalendarDateTime();

  @override
  DurationUnits durationUnits() => UrDurationUnits();

  @override
  DurationUnits shortDurationUnits() => UrShortDurationUnits();
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
  String suffixFromNow() => 'بعد';
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
  String months(int months) => '${_convertToUrduNumbers(months)} مہینے';
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
  String aboutAMinute(int minutes) => '۱ منٹ';
  @override
  String minutes(int minutes) => '${_convertToUrduNumbers(minutes)} منٹ';
  @override
  String aboutAnHour(int minutes) => '~۱ گھ';
  @override
  String hours(int hours) => '${_convertToUrduNumbers(hours)} گھ';
  @override
  String aDay(int hours) => '~۱ د';
  @override
  String days(int days) => '${_convertToUrduNumbers(days)} د';
  @override
  String aboutAMonth(int days) => '~۱ ماہ';
  @override
  String months(int months) => '${_convertToUrduNumbers(months)} ماہ';
  @override
  String aboutAYear(int year) => '~۱ س';
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

/// Urdu calendar date time
class UrCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'آج بوقت $time';
  @override
  String nextDay(String time) => 'کل بوقت $time';
  @override
  String lastDay(String time) => 'گذشتہ روز بوقت $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekday بوقت $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'گذشتہ $weekday بوقت $time';
}

/// Urdu duration units
class UrDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '${_convertToUrduNumbers(seconds)} سیکنڈ';
  @override
  String minutes(int minutes) => '${_convertToUrduNumbers(minutes)} منٹ';
  @override
  String hours(int hours) =>
      '${_convertToUrduNumbers(hours)} ${hours == 1 ? 'گھنٹہ' : 'گھنٹے'}';
  @override
  String days(int days) => '${_convertToUrduNumbers(days)} دن';
  @override
  String weeks(int weeks) =>
      '${_convertToUrduNumbers(weeks)} ${weeks == 1 ? 'ہفتہ' : 'ہفتے'}';
  @override
  String delimiter() => ' ';
}

/// Urdu short duration units
class UrShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '${_convertToUrduNumbers(seconds)} سیکنڈ';
  @override
  String minutes(int minutes) => '${_convertToUrduNumbers(minutes)} منٹ';
  @override
  String hours(int hours) =>
      '${_convertToUrduNumbers(hours)} ${hours == 1 ? 'گھنٹہ' : 'گھنٹے'}';
  @override
  String days(int days) => '${_convertToUrduNumbers(days)} دن';
  @override
  String weeks(int weeks) =>
      '${_convertToUrduNumbers(weeks)} ${weeks == 1 ? 'ہفتہ' : 'ہفتے'}';
  @override
  String delimiter() => ' ';
}
