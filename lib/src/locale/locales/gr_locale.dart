import 'package:flutter_date_formatter/src/models/models.dart';

/// Greek Locale
class GrLocale extends DateFormatterLocale {
  @override
  String code() => 'el';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n';

  @override
  RelativeDateTime relativeDateTime() => GrRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => GrShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => GrCalendarDateTime();

  @override
  DurationUnits durationUnits() => GrDurationUnits();

  @override
  DurationUnits shortDurationUnits() => GrShortDurationUnits();
}

/// Greek relative date time
class GrRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'σε';
  @override
  String suffixAgo() => 'πριν';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'μια στιγμή';
  @override
  String aboutAMinute(int minutes) => 'ένα λεπτό';
  @override
  String minutes(int minutes) => '$minutes λεπτά';
  @override
  String aboutAnHour(int minutes) => 'περίπου μια ώρα';
  @override
  String hours(int hours) => '$hours ώρες';
  @override
  String aDay(int hours) => 'μια μέρα';
  @override
  String days(int days) => '$days μέρες';
  @override
  String aboutAMonth(int days) => 'περίπου ένα μήνα';
  @override
  String months(int months) => '$months μήνες';
  @override
  String aboutAYear(int year) => 'περίπου ένα χρόνο';
  @override
  String years(int years) => '$years χρόνια';
  @override
  String wordSeparator() => ' ';
}

/// Greek short relative date time
class GrShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'τώρα';
  @override
  String aboutAMinute(int minutes) => '1 λπτ';
  @override
  String minutes(int minutes) => '$minutes λπτ';
  @override
  String aboutAnHour(int minutes) => '~1 ώρ';
  @override
  String hours(int hours) => '$hours ώρες';
  @override
  String aDay(int hours) => '~1 μρ';
  @override
  String days(int days) => '$days μρς';
  @override
  String aboutAMonth(int days) => '~1 μν';
  @override
  String months(int months) => '$months μνς';
  @override
  String aboutAYear(int year) => '~1 χρ';
  @override
  String years(int years) => '$years χρ';
  @override
  String wordSeparator() => ' ';
}

/// Greek calendar date time
class GrCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'Σήμερα ${_at(time)} $time';
  @override
  String nextDay(String time) => 'Αύριο ${_at(time)} $time';
  @override
  String lastDay(String time) => 'Χθες ${_at(time)} $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekday ${_at(time)} $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) {
    // Σάββατο is neuter; the other weekdays are feminine.
    final last = date.weekday == DateTime.saturday
        ? 'Το προηγούμενο'
        : 'Την προηγούμενη';
    return '$last $weekday ${_at(time)} $time';
  }
}

/// Greek duration units
class GrDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) =>
      seconds == 1 ? '1 δευτερόλεπτο' : '$seconds δευτερόλεπτα';
  @override
  String minutes(int minutes) => minutes == 1 ? '1 λεπτό' : '$minutes λεπτά';
  @override
  String hours(int hours) => hours == 1 ? '1 ώρα' : '$hours ώρες';
  @override
  String days(int days) => days == 1 ? '1 μέρα' : '$days μέρες';
  @override
  String weeks(int weeks) => weeks == 1 ? '1 εβδομάδα' : '$weeks εβδομάδες';
  @override
  String delimiter() => ' ';
}

/// Greek short duration units
class GrShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds δευτ.';
  @override
  String minutes(int minutes) => '$minutes λ.';
  @override
  String hours(int hours) => '$hours ώ.';
  @override
  String days(int days) => '$days ημ.';
  @override
  String weeks(int weeks) => '$weeks εβδ.';
  @override
  String delimiter() => ' ';
}

/// "στη" before one o'clock ("στη 1:00"), otherwise "στις".
String _at(String time) {
  final hour = RegExp(r'\d+').firstMatch(time)?.group(0);
  return hour != null && int.parse(hour) == 1 ? 'στη' : 'στις';
}
