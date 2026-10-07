import 'package:flutter_date_formatter/src/models/models.dart';

/// Italian Locale
class ItLocale extends DateFormatterLocale {
  @override
  String code() => 'it';

  @override
  String ordinal(int n) => 'º';

  @override
  String ordinalNumber(int n) => '$nº';

  @override
  RelativeDateTime relativeDateTime() => ItRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => ItShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => ItCalendarDateTime();

  @override
  DurationUnits durationUnits() => ItDurationUnits();

  @override
  DurationUnits shortDurationUnits() => ItShortDurationUnits();
}

/// Italian relative date time
class ItRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'tra';
  @override
  String suffixAgo() => 'fa';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'meno di un minuto';
  @override
  String aboutAMinute(int minutes) => 'circa un minuto';
  @override
  String minutes(int minutes) => '$minutes minuti';
  @override
  String aboutAnHour(int minutes) => "circa un'ora";
  @override
  String hours(int hours) => '$hours ore';
  @override
  String aDay(int hours) => 'circa un giorno';
  @override
  String days(int days) => '$days giorni';
  @override
  String aboutAMonth(int days) => 'circa un mese';
  @override
  String months(int months) => '$months mesi';
  @override
  String aboutAYear(int year) => 'circa un anno';
  @override
  String years(int years) => '$years anni';
  @override
  String wordSeparator() => ' ';
}

/// Italian short relative date time
class ItShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'ora';
  @override
  String aboutAMinute(int minutes) => '1 m';
  @override
  String minutes(int minutes) => '$minutes m';
  @override
  String aboutAnHour(int minutes) => '~1 o';
  @override
  String hours(int hours) => '$hours o';
  @override
  String aDay(int hours) => '~1 g';
  @override
  String days(int days) => '$days g';
  @override
  String aboutAMonth(int days) => '~1 m';
  @override
  String months(int months) => '$months m';
  @override
  String aboutAYear(int year) => '~1 a';
  @override
  String years(int years) => '$years a';
  @override
  String wordSeparator() => ' ';
}

/// Italian calendar date time
class ItCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Oggi ${_at(time)}';
  @override
  String nextDay(String time) => 'Domani ${_at(time)}';
  @override
  String lastDay(String time) => 'Ieri ${_at(time)}';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_capitalize(weekday)} ${_at(time)}';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      date.weekday == DateTime.sunday
          ? 'La scorsa $weekday ${_at(time)}'
          : 'Lo scorso $weekday ${_at(time)}';
}

/// Italian duration units
class ItDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => _plural(seconds, 'secondo', 'secondi');
  @override
  String minutes(int minutes) => _plural(minutes, 'minuto', 'minuti');
  @override
  String hours(int hours) => _plural(hours, 'ora', 'ore');
  @override
  String days(int days) => _plural(days, 'giorno', 'giorni');
  @override
  String weeks(int weeks) => _plural(weeks, 'settimana', 'settimane');
  @override
  String delimiter() => ' ';
}

/// Italian short duration units
class ItShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds s';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String hours(int hours) => '$hours h';
  @override
  String days(int days) => '$days g';
  @override
  String weeks(int weeks) => '$weeks sett.';
  @override
  String delimiter() => ' ';
}

/// Returns [time] after "alle", elided to "all'" for one o'clock.
String _at(String time) {
  final hour = int.tryParse(RegExp(r'^\d+').stringMatch(time) ?? '');
  return hour == 1 ? "all'$time" : 'alle $time';
}

/// Picks the CLDR plural form (one / many / other) for Italian.
String _plural(int n, String one, String other) {
  if (n == 1) return '1 $one';
  if (n != 0 && n % 1000000 == 0) return '$n di $other';
  return '$n $other';
}

/// Returns [text] with its first letter in upper case.
String _capitalize(String text) =>
    text.isEmpty ? text : '${text[0].toUpperCase()}${text.substring(1)}';
