import 'package:flutter_date_formatter/src/models/models.dart';

/// Greek Locale
class GrLocale extends Locale {
  @override
  String code() => 'gr';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n';

  @override
  RelativeDateTime relativeDateTime() => GrRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => GrShortRelativeDateTime();
}

/// Greek relative date time
class GrRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'πρίν';
  @override
  String suffixFromNow() => 'απο τώρα';
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
