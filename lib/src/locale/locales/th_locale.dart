import 'package:flutter_date_formatter/src/models/models.dart';

/// Thai locale
class ThLocale extends DateFormatterLocale {
  @override
  String code() => 'th';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => 'ที่ $n';

  @override
  RelativeDateTime relativeDateTime() => ThRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => ThShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => ThCalendarDateTime();

  @override
  DurationUnits durationUnits() => ThDurationUnits();

  @override
  DurationUnits shortDurationUnits() => ThShortDurationUnits();
}

/// Thai relative date time
class ThRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'เมื่อ';
  @override
  String prefixFromNow() => 'ในอีก';
  @override
  String suffixAgo() => 'ที่แล้ว';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'ไม่กี่วินาที';
  @override
  String aboutAMinute(int minutes) => 'ประมาณหนึ่งนาที';
  @override
  String minutes(int minutes) => '$minutes นาที';
  @override
  String aboutAnHour(int minutes) => 'ประมาณหนึ่งชั่วโมง';
  @override
  String hours(int hours) => '$hours ชั่วโมง';
  @override
  String aDay(int hours) => 'หนึ่งวัน';
  @override
  String days(int days) => '$days วัน';
  @override
  String aboutAMonth(int days) => 'ประมาณหนึ่งเดือน';
  @override
  String months(int months) => '$months เดือน';
  @override
  String aboutAYear(int year) => 'ประมาณหนึ่งปี';
  @override
  String years(int years) => '$years ปี';
  @override
  String wordSeparator() => ' ';
}

/// Thai short relative date time
class ThShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'ตอนนี้';
  @override
  String aboutAMinute(int minutes) => '1 นาที';
  @override
  String minutes(int minutes) => '$minutes นาที';
  @override
  String aboutAnHour(int minutes) => '~1 ชม';
  @override
  String hours(int hours) => '$hours ชม';
  @override
  String aDay(int hours) => '~1 ว';
  @override
  String days(int days) => '$days ว';
  @override
  String aboutAMonth(int days) => '~1 ด';
  @override
  String months(int months) => '$months ด';
  @override
  String aboutAYear(int year) => '~1 ป';
  @override
  String years(int years) => '$years ป';
  @override
  String wordSeparator() => ' ';
}

/// Thai calendar date time
///
/// `intl` already prefixes Thai weekday names with "วัน" (e.g. "วันจันทร์").
class ThCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'วันนี้ เวลา $time';
  @override
  String nextDay(String time) => 'พรุ่งนี้ เวลา $time';
  @override
  String lastDay(String time) => 'เมื่อวานนี้ เวลา $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekdayหน้า เวลา $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekdayที่แล้ว เวลา $time';
}

/// Thai duration units
class ThDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds วินาที';
  @override
  String minutes(int minutes) => '$minutes นาที';
  @override
  String hours(int hours) => '$hours ชั่วโมง';
  @override
  String days(int days) => '$days วัน';
  @override
  String weeks(int weeks) => '$weeks สัปดาห์';
  @override
  String delimiter() => ' ';
}

/// Thai short duration units
class ThShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds วิ';
  @override
  String minutes(int minutes) => '$minutes นาที';
  @override
  String hours(int hours) => '$hours ชม.';
  @override
  String days(int days) => '$days วัน';
  @override
  String weeks(int weeks) => '$weeks สัปดาห์';
  @override
  String delimiter() => ' ';
}
