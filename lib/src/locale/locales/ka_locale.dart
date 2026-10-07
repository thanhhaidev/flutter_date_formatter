import 'package:flutter_date_formatter/src/models/models.dart';

/// Georgian Locale
class KaLocale extends DateFormatterLocale {
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

  @override
  CalendarDateTime calendarDateTime() => KaCalendarDateTime();

  @override
  DurationUnits durationUnits() => KaDurationUnits();

  @override
  DurationUnits shortDurationUnits() => KaShortDurationUnits();
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

/// Georgian calendar date time
class KaCalendarDateTime implements CalendarDateTime {
  // Dative weekday names, Monday first ("ორშაბათს").
  static const _weekdays = [
    'ორშაბათს',
    'სამშაბათს',
    'ოთხშაბათს',
    'ხუთშაბათს',
    'პარასკევს',
    'შაბათს',
    'კვირას',
  ];

  @override
  String sameDay(String time) => 'დღეს $time-ზე';
  @override
  String nextDay(String time) => 'ხვალ $time-ზე';
  @override
  String lastDay(String time) => 'გუშინ $time-ზე';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'შემდეგ ${_weekdays[date.weekday - 1]} $time-ზე';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'წინა ${_weekdays[date.weekday - 1]} $time-ზე';
}

/// Georgian duration units
class KaDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds წამი';
  @override
  String minutes(int minutes) => '$minutes წუთი';
  @override
  String hours(int hours) => '$hours საათი';
  @override
  String days(int days) => '$days დღე';
  @override
  String weeks(int weeks) => '$weeks კვირა';
  @override
  String delimiter() => ' ';
}

/// Georgian short duration units
class KaShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds წმ';
  @override
  String minutes(int minutes) => '$minutes წთ';
  @override
  String hours(int hours) => '$hours სთ';
  @override
  String days(int days) => '$days დღ';
  @override
  String weeks(int weeks) => '$weeks კვ';
  @override
  String delimiter() => ' ';
}
