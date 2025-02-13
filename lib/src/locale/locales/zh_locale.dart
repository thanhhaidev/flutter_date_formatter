import 'package:flutter_date_formatter/src/models/models.dart';

/// Chinese locale
class ZhLocale extends Locale {
  @override
  String code() => 'zh';

  @override
  String ordinal(int n) => '日';

  @override
  RelativeDateTime relativeDateTime() => ZhRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => ZhRelativeDateTime();
}

/// Chinese-CN locale
class ZhCnLocale extends ZhLocale {
  @override
  String code() => 'zh_cn';

  @override
  RelativeDateTime relativeDateTime() => ZhCnRelativeDateTime();
}

/// Chinese relative date time
class ZhRelativeDateTime extends RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '前';
  @override
  String suffixFromNow() => '内';
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
  String aDay(int hours) => '1 天';
  @override
  String days(int days) => '$days 天';
  @override
  String aboutAMonth(int days) => '1 個月';
  @override
  String months(int months) => '$months 個月';
  @override
  String aboutAYear(int year) => '1 年';
  @override
  String years(int years) => '$years 年';
  @override
  String wordSeparator() => '';
}

/// Chinese-CN relative date time
class ZhCnRelativeDateTime extends RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '前';
  @override
  String suffixFromNow() => '内';
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
