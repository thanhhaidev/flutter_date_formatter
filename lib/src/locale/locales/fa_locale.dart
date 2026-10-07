import 'package:flutter_date_formatter/src/models/models.dart';
import 'package:intl/intl.dart';

/// Farsi Locale
class FaLocale extends DateFormatterLocale {
  @override
  String code() => 'fa';

  @override
  String ordinal(int n) => 'م';

  @override
  String ordinalNumber(int n) => '${NumberFormat('#', 'fa').format(n)}م';

  @override
  RelativeDateTime relativeDateTime() => FaRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => FaRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => FaCalendarDateTime();

  @override
  DurationUnits durationUnits() => FaDurationUnits();

  @override
  DurationUnits shortDurationUnits() => FaShortDurationUnits();
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

/// Farsi calendar date time
class FaCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'امروز ساعت $time';
  @override
  String nextDay(String time) => 'فردا ساعت $time';
  @override
  String lastDay(String time) => 'دیروز ساعت $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekday ساعت $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekday پیش ساعت $time';
}

/// Farsi duration units
class FaDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '${_faNumber(seconds)} ثانیه';
  @override
  String minutes(int minutes) => '${_faNumber(minutes)} دقیقه';
  @override
  String hours(int hours) => '${_faNumber(hours)} ساعت';
  @override
  String days(int days) => '${_faNumber(days)} روز';
  @override
  String weeks(int weeks) => '${_faNumber(weeks)} هفته';
  @override
  String delimiter() => ' و ';
}

/// Farsi short duration units
class FaShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '${_faNumber(seconds)} ثانیه';
  @override
  String minutes(int minutes) => '${_faNumber(minutes)} دقیقه';
  @override
  String hours(int hours) => '${_faNumber(hours)} ساعت';
  @override
  String days(int days) => '${_faNumber(days)} روز';
  @override
  String weeks(int weeks) => '${_faNumber(weeks)} هفته';
  @override
  String delimiter() => ' ';
}

final NumberFormat _faFormat = NumberFormat('#', 'fa');

/// Formats [n] with Persian digits, without compact abbreviations.
String _faNumber(int n) => _faFormat.format(n);
