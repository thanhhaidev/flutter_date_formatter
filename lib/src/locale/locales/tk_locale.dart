import 'package:flutter_date_formatter/src/models/models.dart';

/// Turkmen Locale
class TkLocale extends DateFormatterLocale {
  @override
  String code() => 'tk';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n-${_ordinalSuffix(n)}';

  @override
  RelativeDateTime relativeDateTime() => TkRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => TkRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => TkCalendarDateTime();

  @override
  DurationUnits durationUnits() => TkDurationUnits();

  @override
  DurationUnits shortDurationUnits() => TkShortDurationUnits();
}

/// Turkmen relative date time
class TkRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'öň';
  @override
  String suffixFromNow() => 'galdy';
  @override
  String lessThanOneMinute(int seconds) => 'biraz';
  @override
  String aboutAMinute(int minutes) => 'bir minut';
  @override
  String minutes(int minutes) => '$minutes minut';
  @override
  String aboutAnHour(int minutes) => 'bir sagat';
  @override
  String hours(int hours) => '$hours sagat';
  @override
  String aDay(int hours) => 'bir gün';
  @override
  String days(int days) => '$days gün';
  @override
  String aboutAMonth(int days) => 'bir aý';
  @override
  String months(int months) => '$months aý';
  @override
  String aboutAYear(int year) => 'bir ýyl';
  @override
  String years(int years) => '$years ýyl';
  @override
  String wordSeparator() => ' ';
}

/// Turkmen calendar date time
class TkCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Şu gün sagat $time';
  @override
  String nextDay(String time) => 'Ertir sagat $time';
  @override
  String lastDay(String time) => 'Düýn sagat $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      isSameWeek
          ? '${_capitalize(_weekdays[date.weekday - 1])} sagat $time'
          : 'Indiki ${_weekdays[date.weekday - 1]} sagat $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      isSameWeek
          ? '${_capitalize(_weekdays[date.weekday - 1])} sagat $time'
          : 'Geçen ${_weekdays[date.weekday - 1]} sagat $time';
}

/// Turkmen duration units
class TkDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds sekunt';
  @override
  String minutes(int minutes) => '$minutes minut';
  @override
  String hours(int hours) => '$hours sagat';
  @override
  String days(int days) => '$days gün';
  @override
  String weeks(int weeks) => '$weeks hepde';
  @override
  String delimiter() => ' ';
}

/// Turkmen short duration units (the long forms; no common abbreviations)
class TkShortDurationUnits extends TkDurationUnits {}

/// Turkmen weekday names, Monday first (`intl` has no `tk` data).
const _weekdays = [
  'duşenbe',
  'sişenbe',
  'çarşenbe',
  'penşenbe',
  'anna',
  'şenbe',
  'ýekşenbe',
];

String _capitalize(String text) =>
    text.isEmpty ? text : '${text[0].toUpperCase()}${text.substring(1)}';

/// Turkmen ordinal suffix, following the vowel harmony of the number's last
/// spoken word: back vowels take "njy", front vowels "nji" (6-njy, 7-nji).
String _ordinalSuffix(int n) {
  // Last non-zero part of the number decides the word that is read last:
  // units, then tens, then hundreds ("ýüz") or thousands ("müň").
  const backUnits = {6, 9}; // alty, dokuz
  const backTens = {10, 30, 40, 60, 90}; // on, otuz, kyrk, altmyş, togsan
  final number = n.abs();
  if (number % 10 != 0) return backUnits.contains(number % 10) ? 'njy' : 'nji';
  if (number % 100 != 0) return backTens.contains(number % 100) ? 'njy' : 'nji';
  return 'nji';
}
