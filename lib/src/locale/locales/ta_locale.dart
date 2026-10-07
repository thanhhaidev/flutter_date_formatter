import 'package:flutter_date_formatter/src/models/models.dart';

/// Tamil locale
class TaLocale extends DateFormatterLocale {
  @override
  String code() => 'ta';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => TaRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => TaRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => TaCalendarDateTime();

  @override
  DurationUnits durationUnits() => TaDurationUnits();

  @override
  DurationUnits shortDurationUnits() => TaShortDurationUnits();
}

/// Tamil relative date time
class TaRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'முன்னர்';
  @override
  String suffixFromNow() => 'கழித்து';
  @override
  String lessThanOneMinute(int seconds) => 'சில நொடிகள்';
  @override
  String aboutAMinute(int minutes) => 'ஒரு நிமிடம்';
  @override
  String minutes(int minutes) => '$minutes நிமிடங்கள்';
  @override
  String aboutAnHour(int minutes) => 'ஓர் மணி நேரம்';
  @override
  String hours(int hours) => '$hours மணி நேரங்கள்';
  @override
  String aDay(int hours) => 'ஓர் நாள்';
  @override
  String days(int days) => '$days நாட்கள்';
  @override
  String aboutAMonth(int days) => 'ஓர் மாதம்';
  @override
  String months(int months) => '$months மாதங்கள்';
  @override
  String aboutAYear(int year) => 'ஓராண்டு';
  @override
  String years(int years) => '$years ஆண்டுகள்';
  @override
  String wordSeparator() => ' ';
}

/// Tamil calendar date time
class TaCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'இன்று $time';
  @override
  String nextDay(String time) => 'நாளை $time';
  @override
  String lastDay(String time) => 'நேற்று $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekday, $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'கடந்த வாரம் $weekday, $time';
}

/// Tamil duration units
class TaDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      seconds == 1 ? '1 விநாடி' : '$seconds விநாடிகள்';
  @override
  String minutes(int minutes) =>
      minutes == 1 ? '1 நிமிடம்' : '$minutes நிமிடங்கள்';
  @override
  String hours(int hours) => '$hours மணி நேரம்';
  @override
  String days(int days) => days == 1 ? '1 நாள்' : '$days நாட்கள்';
  @override
  String weeks(int weeks) => weeks == 1 ? '1 வாரம்' : '$weeks வாரங்கள்';
  @override
  String delimiter() => ' ';
}

/// Tamil short duration units (the long forms; no common abbreviations)
class TaShortDurationUnits extends TaDurationUnits {}
