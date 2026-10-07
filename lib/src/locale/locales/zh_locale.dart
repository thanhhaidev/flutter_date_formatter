import 'package:flutter_date_formatter/src/models/models.dart';

/// Chinese locale
///
/// Uses Simplified Chinese, matching the date symbols that `intl` ships for
/// the `zh` locale. See [ZhTwLocale] for Traditional Chinese.
class ZhLocale extends DateFormatterLocale {
  @override
  String code() => 'zh';

  @override
  String ordinal(int n) => '日';

  @override
  String ordinalNumber(int n) => '第$n';

  @override
  RelativeDateTime relativeDateTime() => ZhRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => ZhRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => ZhCalendarDateTime();

  @override
  DurationUnits durationUnits() => ZhDurationUnits();

  @override
  DurationUnits shortDurationUnits() => ZhShortDurationUnits();
}

/// Chinese-CN locale (Simplified Chinese)
class ZhCnLocale extends ZhLocale {
  @override
  String code() => 'zh_CN';

  @override
  String ordinalNumber(int n) => '$n';

  @override
  RelativeDateTime relativeDateTime() => ZhCnRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => ZhCnRelativeDateTime();
}

/// Chinese-TW locale (Traditional Chinese)
///
/// Not registered by default; register it for `zh_TW` / `zh_HK` if needed.
class ZhTwLocale extends ZhLocale {
  @override
  String code() => 'zh_TW';

  @override
  RelativeDateTime relativeDateTime() => ZhTwRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => ZhTwRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => ZhTwCalendarDateTime();

  @override
  DurationUnits durationUnits() => ZhTwDurationUnits();

  @override
  DurationUnits shortDurationUnits() => ZhTwShortDurationUnits();
}

/// Chinese relative date time (Simplified Chinese)
class ZhRelativeDateTime extends RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '前';
  @override
  String suffixFromNow() => '后';
  @override
  String lessThanOneMinute(int seconds) => '几秒';
  @override
  String aboutAMinute(int minutes) => '1 分钟';
  @override
  String minutes(int minutes) => '$minutes 分钟';
  @override
  String aboutAnHour(int minutes) => '1 小时';
  @override
  String hours(int hours) => '$hours 小时';
  @override
  String aDay(int hours) => '1 天';
  @override
  String days(int days) => '$days 天';
  @override
  String aboutAMonth(int days) => '1 个月';
  @override
  String months(int months) => '$months 个月';
  @override
  String aboutAYear(int year) => '1 年';
  @override
  String years(int years) => '$years 年';
  @override
  String wordSeparator() => '';
}

/// Chinese-CN relative date time (Simplified Chinese)
class ZhCnRelativeDateTime extends ZhRelativeDateTime {}

/// Chinese-TW relative date time (Traditional Chinese)
class ZhTwRelativeDateTime extends ZhRelativeDateTime {
  @override
  String suffixFromNow() => '後';
  @override
  String lessThanOneMinute(int seconds) => '幾秒';
  @override
  String aboutAMinute(int minutes) => '1 分鐘';
  @override
  String minutes(int minutes) => '$minutes 分鐘';
  @override
  String aboutAnHour(int minutes) => '1 小時';
  @override
  String hours(int hours) => '$hours 小時';
  @override
  String aboutAMonth(int days) => '1 個月';
  @override
  String months(int months) => '$months 個月';
}

/// Chinese calendar date time (Simplified Chinese).
///
/// moment.js picks "本" or "上"/"下" by comparing calendar weeks with now,
/// which is not known here, so the 2-6 day range uses the bare weekday
/// ("周四15:00"), as chat apps do.
class ZhCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => '今天$time';
  @override
  String nextDay(String time) => '明天$time';
  @override
  String lastDay(String time) => '昨天$time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${isSameWeek ? '本' : '下'}${_weekdays[date.weekday - 1]}$time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${isSameWeek ? '本' : '上'}${_weekdays[date.weekday - 1]}$time';
}

/// Chinese duration units (Simplified Chinese)
class ZhDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds秒';
  @override
  String minutes(int minutes) => '$minutes分钟';
  @override
  String hours(int hours) => '$hours小时';
  @override
  String days(int days) => '$days天';
  @override
  String weeks(int weeks) => '$weeks周';
  @override
  String delimiter() => '';
}

/// Chinese short duration units (Simplified Chinese)
class ZhShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds秒';
  @override
  String minutes(int minutes) => '$minutes分';
  @override
  String hours(int hours) => '$hours小时';
  @override
  String days(int days) => '$days天';
  @override
  String weeks(int weeks) => '$weeks周';
  @override
  String delimiter() => '';
}

/// Chinese-TW calendar date time (Traditional Chinese).
///
/// Uses the bare weekday for the 2-6 day range; see [ZhCalendarDateTime].
class ZhTwCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => '今天 $time';
  @override
  String nextDay(String time) => '明天 $time';
  @override
  String lastDay(String time) => '昨天 $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${isSameWeek ? '' : '下'}${_twWeekdays[date.weekday - 1]} $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${isSameWeek ? '' : '上'}${_twWeekdays[date.weekday - 1]} $time';
}

/// Chinese-TW duration units (Traditional Chinese)
class ZhTwDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds秒';
  @override
  String minutes(int minutes) => '$minutes分鐘';
  @override
  String hours(int hours) => '$hours小時';
  @override
  String days(int days) => '$days天';
  @override
  String weeks(int weeks) => '$weeks週';
  @override
  String delimiter() => '';
}

/// Chinese-TW short duration units (Traditional Chinese)
class ZhTwShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds秒';
  @override
  String minutes(int minutes) => '$minutes分';
  @override
  String hours(int hours) => '$hours小時';
  @override
  String days(int days) => '$days天';
  @override
  String weeks(int weeks) => '$weeks週';
  @override
  String delimiter() => '';
}

/// Simplified Chinese short weekday names, Monday first.
const _weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];

/// Traditional Chinese weekday names, Monday first.
const _twWeekdays = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日'];
