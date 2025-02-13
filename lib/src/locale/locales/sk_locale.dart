import 'package:flutter_date_formatter/src/models/models.dart';

/// Slovak Locale
class SkLocale extends Locale {
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
}

/// Slovak relative date time
class SkRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'pred';
  @override
  String prefixFromNow() => 'o';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => 'od teraz';
  @override
  String lessThanOneMinute(int seconds) => 'chvíľou';
  @override
  String aboutAMinute(int minutes) => 'minútou';
  @override
  String minutes(int minutes) =>
      _pluralize(minutes, 'minútou', 'minútami', 'minútami');
  @override
  String aboutAnHour(int minutes) => 'hodinou';
  @override
  String hours(int hours) =>
      _pluralize(hours, 'hodinou', 'hodinami', 'hodinami');
  @override
  String aDay(int hours) => 'dňom';
  @override
  String days(int days) => _pluralize(days, 'dňom', 'dňami', 'dňami');
  @override
  String aboutAMonth(int days) => 'mesiacom';
  @override
  String months(int months) =>
      _pluralize(months, 'mesiacom', 'mesiacmi', 'mesiacmi');
  @override
  String aboutAYear(int year) => 'rokom';
  @override
  String years(int years) => _pluralize(years, 'rokom', 'rokmi', 'rokmi');
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

String _pluralize(int n, String form1, String form2, String form3) {
  // Rules as per https://www.gnu.org/software/gettext/manual/html_node/Plural-forms.html
  if (n == 1) return '$n $form1';
  if (n >= 2 && n <= 4) return '$n $form2';
  return '$n $form3';
}
