import 'package:flutter_date_formatter/src/models/models.dart';

/// Ukrainian Locale
class UkLocale extends DateFormatterLocale {
  @override
  String code() => 'uk';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n';

  @override
  RelativeDateTime relativeDateTime() => UkRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => UkShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => UkCalendarDateTime();

  @override
  DurationUnits durationUnits() => UkDurationUnits();

  @override
  DurationUnits shortDurationUnits() => UkShortDurationUnits();
}

/// Ukrainian relative date time
class UkRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'через';
  @override
  String suffixAgo() => 'тому';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'хвилину';
  @override
  String aboutAMinute(int minutes) => 'хвилину';
  @override
  String minutes(int minutes) => '$minutes ${_convert(minutes, 'minutes')}';
  @override
  String aboutAnHour(int minutes) => 'годину';
  @override
  String hours(int hours) => '$hours ${_convert(hours, 'hours')}';
  @override
  String aDay(int hours) => 'день';
  @override
  String days(int days) => '$days ${_convert(days, 'days')}';
  @override
  String aboutAMonth(int days) => 'місяць';
  @override
  String months(int months) => '$months ${_convert(months, 'months')}';
  @override
  String aboutAYear(int year) => 'рік';
  @override
  String years(int years) => '$years ${_convert(years, 'years')}';
  @override
  String wordSeparator() => ' ';

  String _convert(int number, String type) {
    final mod = number % 10;
    final modH = number % 100;

    if (mod == 1 && modH != 11) {
      switch (type) {
        case 'minutes':
          return 'хвилину';
        case 'hours':
          return 'годину';
        case 'days':
          return 'день';
        case 'months':
          return 'місяць';
        case 'years':
          return 'рік';
        default:
          return '';
      }
    } else if (<int>[2, 3, 4].contains(mod) &&
        !<int>[12, 13, 14].contains(modH)) {
      switch (type) {
        case 'minutes':
          return 'хвилини';
        case 'hours':
          return 'години';
        case 'days':
          return 'дні';
        case 'months':
          return 'місяця';
        case 'years':
          return 'роки';
        default:
          return '';
      }
    }
    switch (type) {
      case 'minutes':
        return 'хвилин';
      case 'hours':
        return 'годин';
      case 'days':
        return 'днів';
      case 'months':
        return 'місяців';
      case 'years':
        return 'років';
      default:
        return '';
    }
  }
}

/// Ukrainian short relative date time
class UkShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'тільки що';
  @override
  String aboutAMinute(int minutes) => '~1 хв.';
  @override
  String minutes(int minutes) => '$minutes хв.';
  @override
  String aboutAnHour(int minutes) => '~1 год.';
  @override
  String hours(int hours) => '$hours год.';
  @override
  String aDay(int hours) => '~1 д.';
  @override
  String days(int days) => '$days д.';
  @override
  String aboutAMonth(int days) => '~1 міс.';
  @override
  String months(int months) => '$months міс.';
  @override
  String aboutAYear(int year) => '~1 р.';
  @override
  String years(int years) => '$years р.';
  @override
  String wordSeparator() => ' ';
}

/// Ukrainian calendar date time
class UkCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Сьогодні ${_at(time)} $time';
  @override
  String nextDay(String time) => 'Завтра ${_at(time)} $time';
  @override
  String lastDay(String time) => 'Вчора ${_at(time)} $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'У ${_weekdaysAccusative[date.weekday - 1]} ${_at(time)} $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) {
    final day = _weekdaysGenitive[date.weekday - 1];
    switch (date.weekday) {
      case DateTime.monday:
      case DateTime.tuesday:
      case DateTime.thursday:
        return 'Минулого $day ${_at(time)} $time';
      default:
        return 'Минулої $day ${_at(time)} $time';
    }
  }

  /// "об 11:00" but "о 15:00".
  String _at(String time) => time.startsWith('11') ? 'об' : 'о';
}

/// Ukrainian duration units
class UkDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      _plural(seconds, 'секунда', 'секунди', 'секунд');
  @override
  String minutes(int minutes) =>
      _plural(minutes, 'хвилина', 'хвилини', 'хвилин');
  @override
  String hours(int hours) => _plural(hours, 'година', 'години', 'годин');
  @override
  String days(int days) => _plural(days, 'день', 'дні', 'днів');
  @override
  String weeks(int weeks) => _plural(weeks, 'тиждень', 'тижні', 'тижнів');
  @override
  String delimiter() => ' ';
}

/// Ukrainian short duration units
class UkShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds с';
  @override
  String minutes(int minutes) => '$minutes хв';
  @override
  String hours(int hours) => '$hours год';
  @override
  String days(int days) => '$days дн.';
  @override
  String weeks(int weeks) => '$weeks тиж.';
  @override
  String delimiter() => ' ';
}

/// Ukrainian weekday names in the accusative case, Monday first.
const _weekdaysAccusative = [
  'понеділок',
  'вівторок',
  'середу',
  'четвер',
  'пʼятницю',
  'суботу',
  'неділю',
];

/// Ukrainian weekday names in the genitive case, Monday first.
const _weekdaysGenitive = [
  'понеділка',
  'вівторка',
  'середи',
  'четверга',
  'пʼятниці',
  'суботи',
  'неділі',
];

/// CLDR plural selection for Ukrainian integers, e.g. "5 хвилин".
///
/// one: n % 10 == 1 && n % 100 != 11
/// few: n % 10 in 2..4 && n % 100 not in 12..14
/// many: everything else
String _plural(int n, String one, String few, String many) {
  final mod10 = n % 10;
  final mod100 = n % 100;
  if (mod10 == 1 && mod100 != 11) return '$n $one';
  if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) {
    return '$n $few';
  }
  return '$n $many';
}
