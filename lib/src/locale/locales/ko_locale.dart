import 'package:flutter_date_formatter/src/models/models.dart';

/// Korean locale
class KoLocale extends DateFormatterLocale {
  @override
  String code() => 'ko';

  @override
  String ordinal(int n) => '일';

  @override
  String ordinalNumber(int n) => '$n번째';

  @override
  RelativeDateTime relativeDateTime() => KoRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => KoRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => KoCalendarDateTime();

  @override
  DurationUnits durationUnits() => KoDurationUnits();

  @override
  DurationUnits shortDurationUnits() => KoShortDurationUnits();
}

/// Korean relative date time
class KoRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '전';
  @override
  String suffixFromNow() => '후';
  @override
  String lessThanOneMinute(int seconds) => '몇 초';
  @override
  String aboutAMinute(int minutes) => '1분';
  @override
  String minutes(int minutes) => '$minutes분';
  @override
  String aboutAnHour(int minutes) => '1시간';
  @override
  String hours(int hours) => '$hours시간';
  @override
  String aDay(int hours) => '하루';
  @override
  String days(int days) => '$days일';
  @override
  String aboutAMonth(int days) => '한 달';
  @override
  String months(int months) => '$months개월'; // "달" 대신 "개월" 사용
  @override
  String aboutAYear(int year) => '1년'; // "일 년" 대신 "1년" 사용
  @override
  String years(int years) => '$years년';
  @override
  String wordSeparator() => ' ';
}

/// Korean calendar date time
class KoCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => '오늘 $time';
  @override
  String nextDay(String time) => '내일 $time';
  @override
  String lastDay(String time) => '어제 $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${isSameWeek ? '' : '다음 주 '}$weekday $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${isSameWeek ? '' : '지난주 '}$weekday $time';
}

/// Korean duration units
class KoDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds초';
  @override
  String minutes(int minutes) => '$minutes분';
  @override
  String hours(int hours) => '$hours시간';
  @override
  String days(int days) => '$days일';
  @override
  String weeks(int weeks) => '$weeks주';
  @override
  String delimiter() => ' ';
}

/// Korean short duration units
class KoShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds초';
  @override
  String minutes(int minutes) => '$minutes분';
  @override
  String hours(int hours) => '$hours시간';
  @override
  String days(int days) => '$days일';
  @override
  String weeks(int weeks) => '$weeks주';
  @override
  String delimiter() => ' ';
}
