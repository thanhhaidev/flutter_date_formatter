import 'package:flutter_date_formatter/src/models/models.dart';

/// Amharic locale
class AmLocale extends DateFormatterLocale {
  @override
  String code() => 'am';

  @override
  String ordinal(int n) => 'ኛ';

  @override
  String ordinalNumber(int n) => '$nኛ';

  @override
  RelativeDateTime relativeDateTime() => AmRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => AmShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => AmCalendarDateTime();

  @override
  DurationUnits durationUnits() => AmDurationUnits();

  @override
  DurationUnits shortDurationUnits() => AmShortDurationUnits();
}

/// Amharic relative date time.
///
/// The past is `<unit> በፊት` (e.g. "5 ደቂቃዎች በፊት"). The future is the
/// circumposition `በ<unit> ውስጥ` (e.g. "በ5 ደቂቃዎች ውስጥ", CLDR
/// `relativeTime-type-future`), whose prefix attaches to the unit without a
/// space, so this class implements [DirectionalRelativeDateTime] and the
/// future instance joins the parts without a separator. A plain instance
/// returns the past forms.
class AmRelativeDateTime implements DirectionalRelativeDateTime {
  /// Creates an Amharic relative date time for the past, or for the future
  /// when [isFuture] is `true`.
  AmRelativeDateTime({bool isFuture = false}) : _isFuture = isFuture;

  final bool _isFuture;

  @override
  RelativeDateTime forDirection({required bool isFuture}) =>
      AmRelativeDateTime(isFuture: isFuture);

  @override
  String aDay(int hours) => 'አንድ ቀን';

  @override
  String aboutAMinute(int minutes) => 'አንድ ደቂቃ';

  @override
  String aboutAMonth(int days) => 'አንድ ወር ገደማ';

  @override
  String aboutAYear(int year) => 'አንድ ዓመት ገደማ';

  @override
  String aboutAnHour(int minutes) => 'አንድ ሰዓት ገደማ';

  @override
  String days(int days) => days == 1 ? '$days ቀን' : '$days ቀናት';

  @override
  String hours(int hours) => hours == 1 ? '$hours ሰአት' : '$hours ሰአታት';

  @override
  String lessThanOneMinute(int seconds) => 'አንድ አፍታ';

  @override
  String minutes(int minutes) =>
      minutes == 1 ? '$minutes ደቂቃ' : '$minutes ደቂቃዎች';

  @override
  String months(int months) => months == 1 ? '$months ወር' : '$months ወራት';

  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => 'በ';

  @override
  String suffixAgo() => 'በፊት';

  // The future parts are joined without a separator (see [wordSeparator]),
  // so the space before "ውስጥ" is part of the suffix.
  @override
  String suffixFromNow() => ' ውስጥ';

  @override
  String wordSeparator() => _isFuture ? '' : ' ';

  @override
  String years(int years) => years == 1 ? '$years አመት' : '$years አመታት';
}

/// Amharic short relative date time
class AmShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'አሁን';
  @override
  String aboutAMinute(int minutes) => '1ደ';
  @override
  String minutes(int minutes) => '$minutesደ';
  @override
  String aboutAnHour(int minutes) => '~1ሰ';
  @override
  String hours(int hours) => '$hoursሰ';
  @override
  String aDay(int hours) => '~1ቀ';
  @override
  String days(int days) => '$daysቀ';
  @override
  String aboutAMonth(int days) => '~1ወር';
  @override
  String months(int months) => '$monthsወር';
  @override
  String aboutAYear(int year) => '~1ዓ';
  @override
  String years(int years) => '$yearsዓ';
  @override
  String wordSeparator() => ' ';
}

/// Amharic calendar date time
class AmCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'ዛሬ $time';
  @override
  String nextDay(String time) => 'ነገ $time';
  @override
  String lastDay(String time) => 'ትናንት $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekday $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'ባለፈው $weekday $time';
}

/// Amharic duration units
class AmDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => _plural(seconds, 'ሰከንድ', 'ሰከንዶች');
  @override
  String minutes(int minutes) => _plural(minutes, 'ደቂቃ', 'ደቂቃዎች');
  @override
  String hours(int hours) => _plural(hours, 'ሰዓት', 'ሰዓቶች');
  @override
  String days(int days) => _plural(days, 'ቀን', 'ቀናት');
  @override
  String weeks(int weeks) => _plural(weeks, 'ሳምንት', 'ሳምንታት');
  @override
  String delimiter() => ' ';
}

/// Amharic short duration units
class AmShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds ሰከ';
  @override
  String minutes(int minutes) => '$minutes ደቂ';
  @override
  String hours(int hours) => '$hours ሰ';
  @override
  String days(int days) => '$days ቀ';
  @override
  String weeks(int weeks) => '$weeks ሳምንት';
  @override
  String delimiter() => ' ';
}

/// CLDR plural rule for Amharic: 0 and 1 take the singular.
String _plural(int n, String one, String other) =>
    n <= 1 ? '$n $one' : '$n $other';
