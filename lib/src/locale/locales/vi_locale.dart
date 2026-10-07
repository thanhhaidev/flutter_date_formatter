import 'package:flutter_date_formatter/src/models/models.dart';

/// Vietnamese locale
class ViLocale extends DateFormatterLocale {
  @override
  String code() => 'vi';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => 'thứ $n';

  @override
  RelativeDateTime relativeDateTime() => ViRelativeTime();

  @override
  RelativeDateTime shortRelativeDateTime() => ViShortRelativeTime();

  @override
  CalendarDateTime calendarDateTime() => ViCalendarDateTime();

  @override
  DurationUnits durationUnits() => ViDurationUnits();

  @override
  DurationUnits shortDurationUnits() => ViShortDurationUnits();
}

/// Vietnamese relative date time
class ViRelativeTime extends RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'trước';
  @override
  String suffixFromNow() => 'sau';
  @override
  String lessThanOneMinute(int seconds) => 'vài giây';
  @override
  String aboutAMinute(int minutes) => 'một phút';
  @override
  String minutes(int minutes) => '$minutes phút';
  @override
  String aboutAnHour(int minutes) => 'một giờ';
  @override
  String hours(int hours) => '$hours giờ';
  @override
  String aDay(int hours) => 'một ngày';
  @override
  String days(int days) => '$days ngày';
  @override
  String aboutAMonth(int days) => 'một tháng';
  @override
  String months(int months) => '$months tháng';
  @override
  String aboutAYear(int year) => 'một năm';
  @override
  String years(int years) => '$years năm';
  @override
  String wordSeparator() => ' ';
}

/// Vietnamese short relative date time
class ViShortRelativeTime extends RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'bây giờ';
  @override
  String aboutAMinute(int minutes) => '1 ph';
  @override
  String minutes(int minutes) => '$minutes ph';
  @override
  String aboutAnHour(int minutes) => '~1 h';
  @override
  String hours(int hours) => '$hours h';
  @override
  String aDay(int hours) => '~1 ngày';
  @override
  String days(int days) => '$days ngày';
  @override
  String aboutAMonth(int days) => '~1 tháng';
  @override
  String months(int months) => '$months tháng';
  @override
  String aboutAYear(int year) => '~1 năm';
  @override
  String years(int years) => '$years năm';
  @override
  String wordSeparator() => ' ';
}

/// Vietnamese calendar date time
class ViCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Hôm nay lúc $time';
  @override
  String nextDay(String time) => 'Ngày mai lúc $time';
  @override
  String lastDay(String time) => 'Hôm qua lúc $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      isSameWeek ? '$weekday lúc $time' : '$weekday tuần tới lúc $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      isSameWeek ? '$weekday lúc $time' : '$weekday tuần trước lúc $time';
}

/// Vietnamese duration units
class ViDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds giây';
  @override
  String minutes(int minutes) => '$minutes phút';
  @override
  String hours(int hours) => '$hours giờ';
  @override
  String days(int days) => '$days ngày';
  @override
  String weeks(int weeks) => '$weeks tuần';
  @override
  String delimiter() => ' ';
}

/// Vietnamese short duration units
class ViShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds giây';
  @override
  String minutes(int minutes) => '$minutes ph';
  @override
  String hours(int hours) => '$hours h';
  @override
  String days(int days) => '$days ngày';
  @override
  String weeks(int weeks) => '$weeks tuần';
  @override
  String delimiter() => ' ';
}
