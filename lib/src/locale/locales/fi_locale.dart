import 'package:flutter_date_formatter/src/models/models.dart';

/// Finnish Locale
class FiLocale extends DateFormatterLocale {
  @override
  String code() => 'fi';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '$n.';

  @override
  RelativeDateTime relativeDateTime() => FiRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => FiShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => FiCalendarDateTime();

  @override
  DurationUnits durationUnits() => FiDurationUnits();

  @override
  DurationUnits shortDurationUnits() => FiShortDurationUnits();
}

/// Finnish relative date time
class FiRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'sitten';
  @override
  String suffixFromNow() => 'kuluttua';
  @override
  String lessThanOneMinute(int seconds) => 'hetki';
  @override
  String aboutAMinute(int minutes) => 'noin minuutti';
  @override
  String minutes(int minutes) => '$minutes minuuttia';
  @override
  String aboutAnHour(int minutes) => 'noin tunti';
  @override
  String hours(int hours) => '$hours tuntia';
  @override
  String aDay(int hours) => 'vuorokausi';
  @override
  String days(int days) => '$days päivää';
  @override
  String aboutAMonth(int days) => 'noin kuukausi';
  @override
  String months(int months) => '$months kuukautta';
  @override
  String aboutAYear(int year) => 'noin vuosi';
  @override
  String years(int years) => '$years vuotta';
  @override
  String wordSeparator() => ' ';
}

/// Finnish short relative date time
class FiShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'nyt';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min:ia';
  @override
  String aboutAnHour(int minutes) => '~1 t';
  @override
  String hours(int hours) => '$hours t';
  @override
  String aDay(int hours) => '~pvä';
  @override
  String days(int days) => '$days pvää';
  @override
  String aboutAMonth(int days) => '~kk';
  @override
  String months(int months) => '$months kk:ta';
  @override
  String aboutAYear(int year) => '~1 v';
  @override
  String years(int years) => '${years}v:ta';
  @override
  String wordSeparator() => ' ';
}

/// Finnish calendar date time
class FiCalendarDateTime implements CalendarDateTime {
  /// Weekday names in the essive case ("on Monday"), Monday to Sunday.
  static const List<String> _weekdays = [
    'maanantaina',
    'tiistaina',
    'keskiviikkona',
    'torstaina',
    'perjantaina',
    'lauantaina',
    'sunnuntaina',
  ];

  @override
  String sameDay(String time) => 'Tänään klo $time';
  @override
  String nextDay(String time) => 'Huomenna klo $time';
  @override
  String lastDay(String time) => 'Eilen klo $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) {
    final day = _weekdays[date.weekday - 1];
    return '${day[0].toUpperCase()}${day.substring(1)} klo $time';
  }

  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'Viime ${_weekdays[date.weekday - 1]} klo $time';
}

/// Finnish duration units
class FiDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      seconds == 1 ? '1 sekunti' : '$seconds sekuntia';
  @override
  String minutes(int minutes) =>
      minutes == 1 ? '1 minuutti' : '$minutes minuuttia';
  @override
  String hours(int hours) => hours == 1 ? '1 tunti' : '$hours tuntia';
  @override
  String days(int days) => days == 1 ? '1 päivä' : '$days päivää';
  @override
  String weeks(int weeks) => weeks == 1 ? '1 viikko' : '$weeks viikkoa';
  @override
  String delimiter() => ' ';
}

/// Finnish short duration units
class FiShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds s';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String hours(int hours) => '$hours t';
  @override
  String days(int days) => '$days pv';
  @override
  String weeks(int weeks) => '$weeks vk';
  @override
  String delimiter() => ' ';
}
