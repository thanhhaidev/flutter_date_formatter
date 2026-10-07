import 'package:flutter_date_formatter/src/models/models.dart';

/// Estonian Locale
class EtLocale extends DateFormatterLocale {
  @override
  String code() => 'et';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => EtRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => EtShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => EtCalendarDateTime();

  @override
  DurationUnits durationUnits() => EtDurationUnits();

  @override
  DurationUnits shortDurationUnits() => EtShortDurationUnits();
}

/// Estonian relative date time
class EtRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'tagasi';
  @override
  String suffixFromNow() => 'pärast';
  @override
  String lessThanOneMinute(int seconds) => 'hetk';
  @override
  String aboutAMinute(int minutes) => 'üks minut';
  @override
  String minutes(int minutes) => '$minutes minutit';
  @override
  String aboutAnHour(int minutes) => 'umbes tunni';
  @override
  String hours(int hours) => '$hours tunni';
  @override
  String aDay(int hours) => 'üks päev';
  @override
  String days(int days) => '$days päeva';
  @override
  String aboutAMonth(int days) => 'umbes kuu';
  @override
  String months(int months) => '$months kuud';
  @override
  String aboutAYear(int year) => 'umbes aasta';
  @override
  String years(int years) => '$years aastat';
  @override
  String wordSeparator() => ' ';
}

/// Estonian short relative date time
class EtShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'nüüd';
  @override
  String aboutAMinute(int minutes) => '1m';
  @override
  String minutes(int minutes) => '${minutes}m';
  @override
  String aboutAnHour(int minutes) => '~1t';
  @override
  String hours(int hours) => '${hours}t';
  @override
  String aDay(int hours) => '~1p';
  @override
  String days(int days) => '${days}p';
  @override
  String aboutAMonth(int days) => '~1k';
  @override
  String months(int months) => '${months}k';
  @override
  String aboutAYear(int year) => '~1a';
  @override
  String years(int years) => '${years}a';
  @override
  String wordSeparator() => ' ';
}

/// Estonian calendar date time
class EtCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Täna, $time';
  @override
  String nextDay(String time) => 'Homme, $time';
  @override
  String lastDay(String time) => 'Eile, $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'Järgmine $weekday $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'Eelmine $weekday $time';
}

/// Estonian duration units
class EtDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      seconds == 1 ? '1 sekund' : '$seconds sekundit';
  @override
  String minutes(int minutes) => minutes == 1 ? '1 minut' : '$minutes minutit';
  @override
  String hours(int hours) => hours == 1 ? '1 tund' : '$hours tundi';
  @override
  String days(int days) => days == 1 ? '1 päev' : '$days päeva';
  @override
  String weeks(int weeks) => weeks == 1 ? '1 nädal' : '$weeks nädalat';
  @override
  String delimiter() => ' ';
}

/// Estonian short duration units
class EtShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds s';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String hours(int hours) => '$hours t';
  @override
  String days(int days) => '$days p';
  @override
  String weeks(int weeks) => '$weeks näd';
  @override
  String delimiter() => ' ';
}
