import 'package:flutter_date_formatter/src/models/models.dart';

/// Belarusian locale.
class BeLocale extends DateFormatterLocale {
  @override
  String code() => 'be';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => BeRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => BeShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => BeCalendarDateTime();

  @override
  DurationUnits durationUnits() => BeDurationUnits();

  @override
  DurationUnits shortDurationUnits() => BeShortDurationUnits();
}

/// Belarusian relative date time
class BeRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'праз';
  @override
  String suffixAgo() => 'таму';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'некалькі секунд';
  @override
  String aboutAMinute(int minutes) => 'хвіліну';
  @override
  String minutes(int minutes) => '$minutes ${_convert(minutes, 'minutes')}';
  @override
  String aboutAnHour(int minutes) => 'гадзіну';
  @override
  String hours(int hours) => '$hours ${_convert(hours, 'hours')}';
  @override
  String aDay(int hours) => 'дзень';
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
          return 'хвіліну';
        case 'hours':
          return 'гадзіну';
        case 'days':
          return 'дзень';
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
          return 'хвіліны';
        case 'hours':
          return 'гадзіны';
        case 'days':
          return 'дня';
        case 'months':
          return 'месяца';
        case 'years':
          return 'гады';
        default:
          return '';
      }
    }
    switch (type) {
      case 'minutes':
        return 'хвілін';
      case 'hours':
        return 'гадзін';
      case 'days':
        return 'дзён';
      case 'months':
        return 'месяцаў';
      case 'years':
        return 'гадоў';
      default:
        return '';
    }
  }
}

/// Belarusian short relative date time
class BeShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'толькі што';
  @override
  String aboutAMinute(int minutes) => '~1 мін.';
  @override
  String minutes(int minutes) => '$minutes мін.';
  @override
  String aboutAnHour(int minutes) => '~1 гад.';
  @override
  String hours(int hours) => '$hours гад.';
  @override
  String aDay(int hours) => '~1 дзн.';
  @override
  String days(int days) => '$days дзн.';
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

/// Belarusian calendar date time
class BeCalendarDateTime implements CalendarDateTime {
  /// Weekday names in the accusative case, from Monday to Sunday.
  static const List<String> _weekdays = [
    'панядзелак',
    'аўторак',
    'сераду',
    'чацвер',
    'пятніцу',
    'суботу',
    'нядзелю',
  ];

  @override
  String sameDay(String time) => 'Сёння ў $time';
  @override
  String nextDay(String time) => 'Заўтра ў $time';
  @override
  String lastDay(String time) => 'Учора ў $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'У ${_weekdays[date.weekday - 1]} ў $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) {
    final last = switch (date.weekday) {
      DateTime.monday || DateTime.tuesday || DateTime.thursday => 'мінулы',
      _ => 'мінулую',
    };
    return 'У $last ${_weekdays[date.weekday - 1]} ў $time';
  }
}

/// Belarusian duration units
class BeDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      _plural(seconds, 'секунда', 'секунды', 'секунд');
  @override
  String minutes(int minutes) =>
      _plural(minutes, 'хвіліна', 'хвіліны', 'хвілін');
  @override
  String hours(int hours) => _plural(hours, 'гадзіна', 'гадзіны', 'гадзін');
  @override
  String days(int days) => _plural(days, 'дзень', 'дні', 'дзён');
  @override
  String weeks(int weeks) => _plural(weeks, 'тыдзень', 'тыдні', 'тыдняў');
  @override
  String delimiter() => ' ';
}

/// Belarusian short duration units
class BeShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds сек.';
  @override
  String minutes(int minutes) => '$minutes хв.';
  @override
  String hours(int hours) => '$hours гадз.';
  @override
  String days(int days) => '$days дн.';
  @override
  String weeks(int weeks) => '$weeks тыдз.';
  @override
  String delimiter() => ' ';
}

/// CLDR plural rule for Belarusian (one, few, many).
String _plural(int n, String one, String few, String many) {
  final mod10 = n % 10;
  final mod100 = n % 100;
  if (mod10 == 1 && mod100 != 11) return '$n $one';
  if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) {
    return '$n $few';
  }
  return '$n $many';
}
