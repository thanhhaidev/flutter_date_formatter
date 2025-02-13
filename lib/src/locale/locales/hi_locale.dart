import 'package:flutter_date_formatter/src/models/models.dart';

/// Hindi Locale
class HiLocale extends Locale {
  @override
  String code() => 'hi';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n';

  @override
  RelativeDateTime relativeDateTime() => HiRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => HiShortRelativeDateTime();
}

/// Hindi relative date time
class HiRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'पहले';
  @override
  String suffixFromNow() => 'अब से';
  @override
  String lessThanOneMinute(int seconds) => 'एक क्षण';
  @override
  String aboutAMinute(int minutes) => 'एक मिनट';
  @override
  String minutes(int minutes) => '$minutes मिनट';
  @override
  String aboutAnHour(int minutes) => 'करीब एक घंटा';
  @override
  String hours(int hours) => '$hours घंटे';
  @override
  String aDay(int hours) => 'एक दिन';
  @override
  String days(int days) => '$days दिन';
  @override
  String aboutAMonth(int days) => 'तक़रीबन एक महीना';
  @override
  String months(int months) => '$months महीने';
  @override
  String aboutAYear(int year) => 'एक साल';
  @override
  String years(int years) => '$years वर्षों';
  @override
  String wordSeparator() => ' ';
}

/// Hindi short relative date time
class HiShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'अभी अभी';
  @override
  String aboutAMinute(int minutes) => '1 मि';
  @override
  String minutes(int minutes) => '$minutes मि';
  @override
  String aboutAnHour(int minutes) => '~1 घं';
  @override
  String hours(int hours) => '$hours घं';
  @override
  String aDay(int hours) => '~1 दि';
  @override
  String days(int days) => '$days दि';
  @override
  String aboutAMonth(int days) => '~1 म';
  @override
  String months(int months) => '$months म';
  @override
  String aboutAYear(int year) => '~1 सा';
  @override
  String years(int years) => '$years सा';
  @override
  String wordSeparator() => ' ';
}
