import 'package:flutter_date_formatter/src/models/models.dart';

/// Georgian Locale
class KaLocale extends Locale {
  @override
  String code() => 'ka';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => KaRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => KaShortRelativeDateTime();
}

/// Georgian relative date time
class KaRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'წინ';
  @override
  String suffixFromNow() => 'ამიერიდან';
  @override
  String lessThanOneMinute(int seconds) => 'ერთ წუთზე ნაკლები';
  @override
  String aboutAMinute(int minutes) => 'წუთი';
  @override
  String minutes(int minutes) => '$minutes წუთი';
  @override
  String aboutAnHour(int minutes) => 'დაახლოებით 1 საათი';
  @override
  String hours(int hours) => '$hours საათი';
  @override
  String aDay(int hours) => 'დღე';
  @override
  String days(int days) => '$days დღე';
  @override
  String aboutAMonth(int days) => 'დაახლოებით 1 თვე';
  @override
  String months(int months) => '$months თვე';
  @override
  String aboutAYear(int year) => 'დაახლოებით 1 წელი';
  @override
  String years(int years) => '$years წელი';
  @override
  String wordSeparator() => ' ';
}

/// Georgian short relative date time
class KaShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'ახლა';
  @override
  String aboutAMinute(int minutes) => '1წთ';
  @override
  String minutes(int minutes) => '$minutesწთ';
  @override
  String aboutAnHour(int minutes) => '~1სთ';
  @override
  String hours(int hours) => '$hoursსთ';
  @override
  String aDay(int hours) => '~1დღ';
  @override
  String days(int days) => '$daysდღ';
  @override
  String aboutAMonth(int days) => '~1თვ';
  @override
  String months(int months) => '$monthsთვ';
  @override
  String aboutAYear(int year) => '~1წ';
  @override
  String years(int years) => '$yearsწ';
  @override
  String wordSeparator() => ' ';
}
