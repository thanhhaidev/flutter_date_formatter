import 'package:flutter_date_formatter/src/models/models.dart';

/// Korean locale
class KoLocale extends Locale {
  @override
  String code() => 'ko';

  @override
  String ordinal(int n) => '일';

  @override
  RelativeDateTime relativeDateTime() => KoRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => KoRelativeDateTime();
}

/// Korean relative date time
class KoRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '지금부터';
  @override
  String suffixAgo() => '전';
  @override
  String suffixFromNow() => '후';
  @override
  String lessThanOneMinute(int seconds) => '방금';
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
