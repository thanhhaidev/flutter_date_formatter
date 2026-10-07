import 'package:flutter_date_formatter/src/models/models.dart';

/// Russian Locale
class RuLocale extends DateFormatterLocale {
  @override
  String code() => 'ru';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n';

  @override
  RelativeDateTime relativeDateTime() => RuRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => RuShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => RuCalendarDateTime();

  @override
  DurationUnits durationUnits() => RuDurationUnits();

  @override
  DurationUnits shortDurationUnits() => RuShortDurationUnits();
}

/// Russian relative date time
class RuRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'через';
  @override
  String suffixAgo() => 'назад';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'несколько секунд';
  @override
  String aboutAMinute(int minutes) => 'минуту';
  @override
  String minutes(int minutes) => '$minutes ${_convert(minutes, 'minutes')}';
  @override
  String aboutAnHour(int minutes) => 'час';
  @override
  String hours(int hours) => '$hours ${_convert(hours, 'hours')}';
  @override
  String aDay(int hours) => 'день';
  @override
  String days(int days) => '$days ${_convert(days, 'days')}';
  @override
  String aboutAMonth(int days) => 'месяц';
  @override
  String months(int months) => '$months ${_convert(months, 'months')}';
  @override
  String aboutAYear(int year) => 'год';
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
          return 'минуту';
        case 'hours':
          return 'час';
        case 'days':
          return 'день';
        case 'months':
          return 'месяц';
        case 'years':
          return 'год';
        default:
          return '';
      }
    } else if (<int>[2, 3, 4].contains(mod) &&
        !<int>[12, 13, 14].contains(modH)) {
      switch (type) {
        case 'minutes':
          return 'минуты';
        case 'hours':
          return 'часа';
        case 'days':
          return 'дня';
        case 'months':
          return 'месяца';
        case 'years':
          return 'года';
        default:
          return '';
      }
    }
    switch (type) {
      case 'minutes':
        return 'минут';
      case 'hours':
        return 'часов';
      case 'days':
        return 'дней';
      case 'months':
        return 'месяцев';
      case 'years':
        return 'лет';
      default:
        return '';
    }
  }
}

/// Russian short relative date time
class RuShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'только что';
  @override
  String aboutAMinute(int minutes) => '1 мин.';
  @override
  String minutes(int minutes) => '$minutes мин.';
  @override
  String aboutAnHour(int minutes) => '~1 ч.';
  @override
  String hours(int hours) => '$hours ч.';
  @override
  String aDay(int hours) => '~1 д.';
  @override
  String days(int days) => '$days д.';
  @override
  String aboutAMonth(int days) => '~1 мес.';
  @override
  String months(int months) => '$months мес.';
  @override
  String aboutAYear(int year) => '~1 г.';
  @override
  String years(int years) => '$years г.';
  @override
  String wordSeparator() => ' ';
}

/// Russian calendar date time
class RuCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Сегодня, в $time';
  @override
  String nextDay(String time) => 'Завтра, в $time';
  @override
  String lastDay(String time) => 'Вчера, в $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) {
    if (isSameWeek) return '${_inWeekday(date)}, в $time';
    final day = _weekdaysAccusative[date.weekday - 1];
    final next = switch (date.weekday) {
      DateTime.sunday => 'следующее',
      DateTime.wednesday || DateTime.friday || DateTime.saturday => 'следующую',
      _ => 'следующий',
    };
    return 'В $next $day, в $time';
  }

  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) {
    if (isSameWeek) return '${_inWeekday(date)}, в $time';
    final day = _weekdaysAccusative[date.weekday - 1];
    final last = switch (date.weekday) {
      DateTime.sunday => 'прошлое',
      DateTime.wednesday || DateTime.friday || DateTime.saturday => 'прошлую',
      _ => 'прошлый',
    };
    return 'В $last $day, в $time';
  }

  /// "В среду", "Во вторник".
  String _inWeekday(DateTime date) {
    final day = _weekdaysAccusative[date.weekday - 1];
    return '${date.weekday == DateTime.tuesday ? 'Во' : 'В'} $day';
  }
}

/// Russian duration units
class RuDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      _plural(seconds, 'секунда', 'секунды', 'секунд');
  @override
  String minutes(int minutes) => _plural(minutes, 'минута', 'минуты', 'минут');
  @override
  String hours(int hours) => _plural(hours, 'час', 'часа', 'часов');
  @override
  String days(int days) => _plural(days, 'день', 'дня', 'дней');
  @override
  String weeks(int weeks) => _plural(weeks, 'неделя', 'недели', 'недель');
  @override
  String delimiter() => ' ';
}

/// Russian short duration units
class RuShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds сек.';
  @override
  String minutes(int minutes) => '$minutes мин';
  @override
  String hours(int hours) => '$hours ч';
  @override
  String days(int days) => '$days дн.';
  @override
  String weeks(int weeks) => '$weeks нед.';
  @override
  String delimiter() => ' ';
}

/// Russian weekday names in the accusative case, Monday first.
const _weekdaysAccusative = [
  'понедельник',
  'вторник',
  'среду',
  'четверг',
  'пятницу',
  'субботу',
  'воскресенье',
];

/// CLDR plural selection for Russian integers, e.g. "5 минут".
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
