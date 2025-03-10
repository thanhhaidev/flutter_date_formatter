import 'package:flutter_date_formatter/src/models/models.dart';

/// Kurdish Locale
class KuLocale extends Locale {
  @override
  String code() => 'ku';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '${n}th';

  @override
  RelativeDateTime relativeDateTime() => KuRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => KuShortRelativeDateTime();
}

/// Kurdish relative date time
class KuRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => 'لە ئێستاوە';
  @override
  String lessThanOneMinute(int seconds) => 'چەند چرکەیەک لەمەوپێش';
  @override
  String aboutAMinute(int minutes) => 'خولەکێک لەمەوپێش';
  @override
  String minutes(int minutes) {
    if (minutes == 1) {
      return 'خولەکێک لەمەوپێش';
    }

    return '$minutes خولەک لەمەوپێش';
  }

  @override
  String aboutAnHour(int minutes) => 'کاژێرێک لەمەوپێش';
  @override
  String hours(int hours) {
    if (hours == 1) {
      return 'کاژێرێک لەمەوپێش';
    }

    return '$hours کاژێر لەمەوپێش';
  }

  @override
  String aDay(int hours) => 'ڕۆژێک لەمەوپێش';
  @override
  String days(int days) {
    if (days == 1) {
      return 'ڕۆژێک لەمەوپێش';
    }

    return '$days ڕۆژ لەمەوپێش';
  }

  @override
  String aboutAMonth(int days) => 'مانگێک لەمەوپێش';
  @override
  String months(int months) {
    if (months == 1) {
      return 'مانگێک لەمەوپێش';
    }
    return '$months مانگ لەمەوپێش';
  }

  @override
  String aboutAYear(int year) => 'ساڵێک لەمەوپێش';
  @override
  String years(int years) {
    if (years == 1) {
      return 'ساڵێک لەمەوپێش';
    }

    return '$years ساڵ لەمەوپێش';
  }

  @override
  String wordSeparator() => ' ';
}

/// Kurdish short relative date time
class KuShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => 'لە ئێستاوە';
  @override
  String lessThanOneMinute(int seconds) => 'ئێستا';
  @override
  String aboutAMinute(int minutes) => '1 خولەک';
  @override
  String minutes(int minutes) => '$minutes خولەک';
  @override
  String aboutAnHour(int minutes) => '~1 کاژێر';
  @override
  String hours(int hours) => '$hours کاژێر';
  @override
  String aDay(int hours) => '~1 ڕۆژ';
  @override
  String days(int days) => '$days ڕۆژ';
  @override
  String aboutAMonth(int days) => '~1 مانگ';
  @override
  String months(int months) => '$months مانگ';
  @override
  String aboutAYear(int year) => '~1 ساڵ';
  @override
  String years(int years) => '$years ساڵ';
  @override
  String wordSeparator() => ' ';
}
