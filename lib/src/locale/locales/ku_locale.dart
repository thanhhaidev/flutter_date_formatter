import 'package:flutter_date_formatter/src/models/models.dart';

/// Kurdish Locale
class KuLocale extends DateFormatterLocale {
  @override
  String code() => 'ku';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n';

  @override
  RelativeDateTime relativeDateTime() => KuRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => KuShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => KuCalendarDateTime();

  @override
  DurationUnits durationUnits() => KuDurationUnits();

  @override
  DurationUnits shortDurationUnits() => KuShortDurationUnits();
}

/// Kurdish relative date time
class KuRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'پاش';
  @override
  String suffixAgo() => 'لەمەوپێش';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'چەند چرکەیەک';
  @override
  String aboutAMinute(int minutes) => 'خولەکێک';
  @override
  String minutes(int minutes) {
    if (minutes == 1) {
      return 'خولەکێک';
    }

    return '$minutes خولەک';
  }

  @override
  String aboutAnHour(int minutes) => 'کاژێرێک';
  @override
  String hours(int hours) {
    if (hours == 1) {
      return 'کاژێرێک';
    }

    return '$hours کاژێر';
  }

  @override
  String aDay(int hours) => 'ڕۆژێک';
  @override
  String days(int days) {
    if (days == 1) {
      return 'ڕۆژێک';
    }

    return '$days ڕۆژ';
  }

  @override
  String aboutAMonth(int days) => 'مانگێک';
  @override
  String months(int months) {
    if (months == 1) {
      return 'مانگێک';
    }
    return '$months مانگ';
  }

  @override
  String aboutAYear(int year) => 'ساڵێک';
  @override
  String years(int years) {
    if (years == 1) {
      return 'ساڵێک';
    }

    return '$years ساڵ';
  }

  @override
  String wordSeparator() => ' ';
}

/// Kurdish short relative date time
class KuShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'ئێستا';
  @override
  String aboutAMinute(int minutes) => '1 خولەک';
  @override
  String minutes(int minutes) => '$minutes خولەک';
  @override
  String aboutAnHour(int minutes) => '~1 کاژێر';
  @override
  String hours(int hours) => '$hours کاژێر';
  @override
  String aDay(int hours) => '~1 ڕۆژ';
  @override
  String days(int days) => '$days ڕۆژ';
  @override
  String aboutAMonth(int days) => '~1 مانگ';
  @override
  String months(int months) => '$months مانگ';
  @override
  String aboutAYear(int year) => '~1 ساڵ';
  @override
  String years(int years) => '$years ساڵ';
  @override
  String wordSeparator() => ' ';
}

/// Kurdish calendar date time
class KuCalendarDateTime implements CalendarDateTime {
  // Sorani weekday names, Monday first (intl has no Kurdish data).
  static const _weekdays = [
    'دووشەممە',
    'سێشەممە',
    'چوارشەممە',
    'پێنجشەممە',
    'هەینی',
    'شەممە',
    'یەکشەممە',
  ];

  @override
  String sameDay(String time) => 'ئەمڕۆ کاتژمێر $time';
  @override
  String nextDay(String time) => 'بەیانی کاتژمێر $time';
  @override
  String lastDay(String time) => 'دوێنێ کاتژمێر $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_weekdays[date.weekday - 1]} کاتژمێر $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_weekdays[date.weekday - 1]}ی ڕابردوو کاتژمێر $time';
}

/// Kurdish duration units
class KuDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds چرکە';
  @override
  String minutes(int minutes) => '$minutes خولەک';
  @override
  String hours(int hours) => '$hours کاتژمێر';
  @override
  String days(int days) => '$days ڕۆژ';
  @override
  String weeks(int weeks) => '$weeks هەفتە';
  @override
  String delimiter() => ' ';
}

/// Kurdish short duration units
class KuShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds چرکە';
  @override
  String minutes(int minutes) => '$minutes خولەک';
  @override
  String hours(int hours) => '$hours کاتژمێر';
  @override
  String days(int days) => '$days ڕۆژ';
  @override
  String weeks(int weeks) => '$weeks هەفتە';
  @override
  String delimiter() => ' ';
}
