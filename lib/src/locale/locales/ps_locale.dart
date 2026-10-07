import 'package:flutter_date_formatter/src/models/models.dart';
import 'package:intl/intl.dart';

/// Pashto Locale
class PsLocale extends DateFormatterLocale {
  @override
  String code() => 'ps';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '${_format(n)}م';

  @override
  RelativeDateTime relativeDateTime() => PsRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => PsRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => PsCalendarDateTime();

  @override
  DurationUnits durationUnits() => PsDurationUnits();

  @override
  DurationUnits shortDurationUnits() => PsShortDurationUnits();
}

/// Pashto relative date time.
///
/// The past is `<unit> مخکې` (e.g. "۵ دقیقې مخکې"). The future is the
/// circumposition `په <unit> کې` (e.g. "په ۵ دقیقو کې"), which puts the
/// unit in the oblique case, so this class implements
/// [DirectionalRelativeDateTime]. A plain instance returns the past forms.
class PsRelativeDateTime implements DirectionalRelativeDateTime {
  /// Creates a Pashto relative date time for the past, or for the future
  /// when [isFuture] is `true`.
  PsRelativeDateTime({bool isFuture = false}) : _isFuture = isFuture;

  final bool _isFuture;

  @override
  RelativeDateTime forDirection({required bool isFuture}) =>
      PsRelativeDateTime(isFuture: isFuture);

  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'په';
  @override
  String suffixAgo() => 'مخکې';
  @override
  String suffixFromNow() => 'کې';
  @override
  String lessThanOneMinute(int seconds) => _isFuture ? 'یوې شیبې' : 'یوه شیبه';
  @override
  String aboutAMinute(int minutes) => _isFuture ? 'یوې دقیقې' : 'یوه دقیقه';
  @override
  String minutes(int minutes) =>
      '${_format(minutes)} ${_isFuture ? 'دقیقو' : 'دقیقې'}';
  @override
  String aboutAnHour(int minutes) => 'شاوخوا یو ساعت';
  @override
  String hours(int hours) =>
      '${_format(hours)} ${_isFuture ? 'ساعتونو' : 'ساعته'}';
  @override
  String aDay(int hours) => _isFuture ? 'یوې ورځې' : 'یوه ورځ';
  @override
  String days(int days) => '${_format(days)} ${_isFuture ? 'ورځو' : 'ورځې'}';
  @override
  String aboutAMonth(int days) =>
      _isFuture ? 'شاوخوا یوې میاشتې' : 'شاوخوا یوه میاشت';
  @override
  String months(int months) =>
      '${_format(months)} ${_isFuture ? 'میاشتو' : 'میاشتې'}';
  @override
  String aboutAYear(int year) => 'شاوخوا یو کال';
  @override
  String years(int years) =>
      '${_format(years)} ${_isFuture ? 'کلونو' : 'کاله'}';
  @override
  String wordSeparator() => ' ';
}

/// Formats [n] with Pashto digits, keeping the full number (no compact form).
String _format(int n) => NumberFormat('#', 'ps').format(n);

/// Pashto calendar date time
class PsCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'نن په $time';
  @override
  String nextDay(String time) => 'سبا په $time';
  @override
  String lastDay(String time) => 'پرون په $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekday په $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'تېره $weekday په $time';
}

/// Pashto duration units
class PsDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      '${_format(seconds)} ${seconds == 1 ? 'ثانیه' : 'ثانیې'}';
  @override
  String minutes(int minutes) =>
      '${_format(minutes)} ${minutes == 1 ? 'دقیقه' : 'دقیقې'}';
  @override
  String hours(int hours) =>
      '${_format(hours)} ${hours == 1 ? 'ساعت' : 'ساعته'}';
  @override
  String days(int days) => '${_format(days)} ${days == 1 ? 'ورځ' : 'ورځې'}';
  @override
  String weeks(int weeks) => '${_format(weeks)} اونۍ';
  @override
  String delimiter() => ' ';
}

/// Pashto short duration units (Pashto has no common unit abbreviations)
class PsShortDurationUnits extends PsDurationUnits {}
