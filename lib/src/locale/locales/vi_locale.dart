import 'package:flutter_date_formatter/src/models/models.dart';

/// Vietnamese locale
class ViLocale extends Locale {
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
