import 'package:flutter_date_formatter/src/models/models.dart';
import 'package:intl/intl.dart';

/// Bengali locale
class BnLocale extends DateFormatterLocale {
  @override
  String code() => 'bn';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) {
    final number = _bnNumber(n);
    switch (n) {
      case 1:
      case 5:
      case 7:
      case 8:
      case 9:
      case 10:
        return '$numberম';
      case 2:
      case 3:
        return '$numberয়';
      case 4:
        return '$numberর্থ';
      case 6:
        return '$numberষ্ঠ';
      default:
        return '$numberতম';
    }
  }

  @override
  RelativeDateTime relativeDateTime() => BnRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => BnShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => BnCalendarDateTime();

  @override
  DurationUnits durationUnits() => BnDurationUnits();

  @override
  DurationUnits shortDurationUnits() => BnShortDurationUnits();
}

/// Bengali relative date time
class BnRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'আগে';
  @override
  String suffixFromNow() => 'এখন থেকে';
  @override
  String lessThanOneMinute(int seconds) => 'কিছুক্ষন';
  @override
  String aboutAMinute(int minutes) => 'প্রায় এক মিনিট';
  @override
  String minutes(int minutes) => '${_bnNumber(minutes)} মিনিট';
  @override
  String aboutAnHour(int minutes) => 'প্রায় এক ঘন্টা';
  @override
  String hours(int hours) => '${_bnNumber(hours)} ঘন্টা';
  @override
  String aDay(int hours) => 'এক দিন';
  @override
  String days(int days) => '${_bnNumber(days)} দিন';
  @override
  String aboutAMonth(int days) => 'প্রায় এক মাস';
  @override
  String months(int months) => '${_bnNumber(months)} মাস';
  @override
  String aboutAYear(int year) => 'প্রায় এক বছর';
  @override
  String years(int years) => '${_bnNumber(years)} বছর';
  @override
  String wordSeparator() => ' ';
}

/// Bengali short relative date time
class BnShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'এখন';
  @override
  String aboutAMinute(int minutes) => '১মিনিট';
  @override
  String minutes(int minutes) => '${_bnNumber(minutes)}মিনিট';
  @override
  String aboutAnHour(int minutes) => '~১ঘন্টা';
  @override
  String hours(int hours) => '${_bnNumber(hours)}ঘন্টা';
  @override
  String aDay(int hours) => '~১দি';
  @override
  String days(int days) => '${_bnNumber(days)}দি';
  @override
  String aboutAMonth(int days) => '~১মাস';
  @override
  String months(int months) => '${_bnNumber(months)}মাস';
  @override
  String aboutAYear(int year) => '~১বছর';
  @override
  String years(int years) => '${_bnNumber(years)}বছর';
  @override
  String wordSeparator() => ' ';
}

final NumberFormat _bnFormat = NumberFormat('#', 'bn');

/// Formats [n] with Bengali digits, without compact abbreviations.
String _bnNumber(int n) => _bnFormat.format(n);

/// Bengali calendar date time
class BnCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'আজ $time';
  @override
  String nextDay(String time) => 'আগামীকাল $time';
  @override
  String lastDay(String time) => 'গতকাল $time';
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
      'গত $weekday, $time';
}

/// Bengali duration units
class BnDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '${_bnNumber(seconds)} সেকেন্ড';
  @override
  String minutes(int minutes) => '${_bnNumber(minutes)} মিনিট';
  @override
  String hours(int hours) => '${_bnNumber(hours)} ঘন্টা';
  @override
  String days(int days) => '${_bnNumber(days)} দিন';
  @override
  String weeks(int weeks) => '${_bnNumber(weeks)} সপ্তাহ';
  @override
  String delimiter() => ' ';
}

/// Bengali short duration units
class BnShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '${_bnNumber(seconds)} সেকেন্ড';
  @override
  String minutes(int minutes) => '${_bnNumber(minutes)} মিনিট';
  @override
  String hours(int hours) => '${_bnNumber(hours)} ঘন্টা';
  @override
  String days(int days) => '${_bnNumber(days)} দিন';
  @override
  String weeks(int weeks) => '${_bnNumber(weeks)} সপ্তাহ';
  @override
  String delimiter() => ' ';
}
