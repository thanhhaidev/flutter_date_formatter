import 'package:flutter_date_formatter/src/models/models.dart';

/// Belarusian locale.
class BeLocale extends Locale {
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
  String lessThanOneMinute(int seconds) => 'хвіліна';
  @override
  String aboutAMinute(int minutes) => 'хвіліна';
  @override
  String minutes(int minutes) => '$minutes ${_convert(minutes, 'minutes')}';
  @override
  String aboutAnHour(int minutes) => 'гадзіна';
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
          return 'гадзіна';
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
