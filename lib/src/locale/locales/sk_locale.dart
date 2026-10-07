import 'package:flutter_date_formatter/src/models/models.dart';

/// Slovak Locale
class SkLocale extends DateFormatterLocale {
  @override
  String code() => 'sk';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => SkRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => SkShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => SkCalendarDateTime();

  @override
  DurationUnits durationUnits() => SkDurationUnits();

  @override
  DurationUnits shortDurationUnits() => SkShortDurationUnits();
}

/// Slovak relative date time.
///
/// Slovak inflects units differently per direction (instrumental after
/// "pred" in the past, accusative after "o" in the future), so this
/// class implements [DirectionalRelativeDateTime]. A plain instance returns
/// the past forms.
class SkRelativeDateTime implements DirectionalRelativeDateTime {
  /// Creates a Slovak relative date time for the past, or for the future
  /// when [isFuture] is `true`.
  SkRelativeDateTime({bool isFuture = false}) : _isFuture = isFuture;

  final bool _isFuture;

  @override
  RelativeDateTime forDirection({required bool isFuture}) =>
      SkRelativeDateTime(isFuture: isFuture);

  @override
  String prefixAgo() => 'pred';

  @override
  String prefixFromNow() => 'o';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => _isFuture ? 'chvíľu' : 'chvíľou';
  @override
  String aboutAMinute(int minutes) => _isFuture ? 'minútu' : 'minútou';
  @override
  String minutes(int minutes) => _isFuture
      ? _pluralize(minutes, 'minútu', 'minúty', 'minút')
      : _pluralize(minutes, 'minútou', 'minútami', 'minútami');
  @override
  String aboutAnHour(int minutes) => _isFuture ? 'hodinu' : 'hodinou';
  @override
  String hours(int hours) => _isFuture
      ? _pluralize(hours, 'hodinu', 'hodiny', 'hodín')
      : _pluralize(hours, 'hodinou', 'hodinami', 'hodinami');
  @override
  String aDay(int hours) => _isFuture ? 'deň' : 'dňom';
  @override
  String days(int days) => _isFuture
      ? _pluralize(days, 'deň', 'dni', 'dní')
      : _pluralize(days, 'dňom', 'dňami', 'dňami');
  @override
  String aboutAMonth(int days) => _isFuture ? 'mesiac' : 'mesiacom';
  @override
  String months(int months) => _isFuture
      ? _pluralize(months, 'mesiac', 'mesiace', 'mesiacov')
      : _pluralize(months, 'mesiacom', 'mesiacmi', 'mesiacmi');
  @override
  String aboutAYear(int year) => _isFuture ? 'rok' : 'rokom';
  @override
  String years(int years) => _isFuture
      ? _pluralize(years, 'rok', 'roky', 'rokov')
      : _pluralize(years, 'rokom', 'rokmi', 'rokmi');
  @override
  String wordSeparator() => ' ';
}

/// Slovak short relative date time
class SkShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'teraz';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '~1 hod';
  @override
  String hours(int hours) => '$hours hod';
  @override
  String aDay(int hours) => '~1 deň';
  @override
  String days(int days) => _pluralize(days, 'deň', 'dni', 'dní');
  @override
  String aboutAMonth(int days) => '~1 mesiac';
  @override
  String months(int months) =>
      _pluralize(months, 'mesiac', 'mesiace', 'mesiacov');
  @override
  String aboutAYear(int year) => '~1 rok';
  @override
  String years(int years) => _pluralize(years, 'rok', 'roky', 'rokov');
  @override
  String wordSeparator() => ' ';
}

/// CLDR plural selection for Slovak integers: one (1), few (2-4), other.
String _pluralize(int n, String one, String few, String other) {
  if (n == 1) return '$n $one';
  if (n >= 2 && n <= 4) return '$n $few';
  return '$n $other';
}

/// Slovak calendar date time
class SkCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Dnes o $time';
  @override
  String nextDay(String time) => 'Zajtra o $time';
  @override
  String lastDay(String time) => 'Včera o $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_capitalize(_nextWeekdays[date.weekday - 1])} o $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_capitalize(_lastWeekdays[date.weekday - 1])} o $time';
}

/// Slovak duration units
class SkDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      _pluralize(seconds, 'sekunda', 'sekundy', 'sekúnd');
  @override
  String minutes(int minutes) =>
      _pluralize(minutes, 'minúta', 'minúty', 'minút');
  @override
  String hours(int hours) => _pluralize(hours, 'hodina', 'hodiny', 'hodín');
  @override
  String days(int days) => _pluralize(days, 'deň', 'dni', 'dní');
  @override
  String weeks(int weeks) => _pluralize(weeks, 'týždeň', 'týždne', 'týždňov');
  @override
  String delimiter() => ' ';
}

/// Slovak short duration units
class SkShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds s';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String hours(int hours) => '$hours h';
  @override
  String days(int days) => '$days d';
  @override
  String weeks(int weeks) => '$weeks týž.';
  @override
  String delimiter() => ' ';
}

/// "On `weekday`" (accusative), Monday first.
const _nextWeekdays = [
  'v pondelok',
  'v utorok',
  'v stredu',
  'vo štvrtok',
  'v piatok',
  'v sobotu',
  'v nedeľu',
];

/// "Last `weekday`" (accusative), Monday first.
const _lastWeekdays = [
  'minulý pondelok',
  'minulý utorok',
  'minulú stredu',
  'minulý štvrtok',
  'minulý piatok',
  'minulú sobotu',
  'minulú nedeľu',
];

String _capitalize(String text) =>
    text.isEmpty ? text : '${text[0].toUpperCase()}${text.substring(1)}';
