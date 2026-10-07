import 'package:flutter_date_formatter/src/models/models.dart';

/// Czech locale
class CsLocale extends DateFormatterLocale {
  @override
  String code() => 'cs';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => CsRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => CsShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => CsCalendarDateTime();

  @override
  DurationUnits durationUnits() => CsDurationUnits();

  @override
  DurationUnits shortDurationUnits() => CsShortDurationUnits();
}

/// Czech relative date time.
///
/// Czech inflects units differently per direction (instrumental after
/// "před" in the past, accusative after "za" in the future), so this
/// class implements [DirectionalRelativeDateTime]. A plain instance returns
/// the past forms.
class CsRelativeDateTime implements DirectionalRelativeDateTime {
  /// Creates a Czech relative date time for the past, or for the future
  /// when [isFuture] is `true`.
  CsRelativeDateTime({bool isFuture = false}) : _isFuture = isFuture;

  final bool _isFuture;

  @override
  RelativeDateTime forDirection({required bool isFuture}) =>
      CsRelativeDateTime(isFuture: isFuture);

  @override
  String prefixAgo() => 'před';

  @override
  String prefixFromNow() => 'za';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => _isFuture ? 'chvíli' : 'chvílí';
  @override
  String aboutAMinute(int minutes) => _isFuture ? 'minutu' : 'minutou';
  @override
  String minutes(int minutes) => _isFuture
      ? _pluralize(minutes, 'minutu', 'minuty', 'minut')
      : _pluralize(minutes, 'minutou', 'minutami', 'minutami');
  @override
  String aboutAnHour(int minutes) => _isFuture ? 'hodinu' : 'hodinou';
  @override
  String hours(int hours) => _isFuture
      ? _pluralize(hours, 'hodinu', 'hodiny', 'hodin')
      : _pluralize(hours, 'hodinou', 'hodinami', 'hodinami');
  @override
  String aDay(int hours) => _isFuture ? 'den' : 'dnem';
  @override
  String days(int days) => _isFuture
      ? _pluralize(days, 'den', 'dny', 'dní')
      : _pluralize(days, 'dnem', 'dny', 'dny');
  @override
  String aboutAMonth(int days) => _isFuture ? 'měsíc' : 'měsícem';
  @override
  String months(int months) => _isFuture
      ? _pluralize(months, 'měsíc', 'měsíce', 'měsíců')
      : _pluralize(months, 'měsícem', 'měsíci', 'měsíci');
  @override
  String aboutAYear(int year) => _isFuture ? 'rok' : 'rokem';
  @override
  String years(int years) => _isFuture
      ? _pluralize(years, 'rok', 'roky', 'let')
      : _pluralize(years, 'rokem', 'lety', 'lety');
  @override
  String wordSeparator() => ' ';
}

/// Czech short relative date time
class CsShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'teď';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '~1 hod';
  @override
  String hours(int hours) => '$hours hod';
  @override
  String aDay(int hours) => '~1 den';
  @override
  String days(int days) => _pluralize(days, 'den', 'dny', 'dní');
  @override
  String aboutAMonth(int days) => '~1 měsíc';
  @override
  String months(int months) => _pluralize(months, 'měsíc', 'měsíce', 'měsíců');
  @override
  String aboutAYear(int year) => '~1 rok';
  @override
  String years(int years) => _pluralize(years, 'rok', 'roky', 'roků');
  @override
  String wordSeparator() => ' ';
}

String _pluralize(int n, String form1, String form2, String form3) {
  // Rules as per https://www.gnu.org/software/gettext/manual/html_node/Plural-forms.html
  if (n == 1) return '$n $form1';
  if (n >= 2 && n <= 4) return '$n $form2';
  return '$n $form3';
}

/// Czech calendar date time
class CsCalendarDateTime implements CalendarDateTime {
  /// "On weekday" phrases (accusative), from Monday to Sunday.
  static const List<String> _nextWeekdays = [
    'V pondělí',
    'V úterý',
    'Ve středu',
    'Ve čtvrtek',
    'V pátek',
    'V sobotu',
    'V neděli',
  ];

  /// "Last weekday" phrases (accusative), from Monday to Sunday.
  static const List<String> _lastWeekdays = [
    'Minulé pondělí',
    'Minulé úterý',
    'Minulou středu',
    'Minulý čtvrtek',
    'Minulý pátek',
    'Minulou sobotu',
    'Minulou neděli',
  ];

  @override
  String sameDay(String time) => 'Dnes v $time';
  @override
  String nextDay(String time) => 'Zítra v $time';
  @override
  String lastDay(String time) => 'Včera v $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_nextWeekdays[date.weekday - 1]} v $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '${_lastWeekdays[date.weekday - 1]} v $time';
}

/// Czech duration units
class CsDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      _pluralize(seconds, 'sekunda', 'sekundy', 'sekund');
  @override
  String minutes(int minutes) =>
      _pluralize(minutes, 'minuta', 'minuty', 'minut');
  @override
  String hours(int hours) => _pluralize(hours, 'hodina', 'hodiny', 'hodin');
  @override
  String days(int days) => _pluralize(days, 'den', 'dny', 'dní');
  @override
  String weeks(int weeks) => _pluralize(weeks, 'týden', 'týdny', 'týdnů');
  @override
  String delimiter() => ' ';
}

/// Czech short duration units
class CsShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds s';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String hours(int hours) => '$hours h';
  @override
  String days(int days) => '$days d';
  @override
  String weeks(int weeks) => '$weeks týd.';
  @override
  String delimiter() => ' ';
}
