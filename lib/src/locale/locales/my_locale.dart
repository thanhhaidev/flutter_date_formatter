import 'package:flutter_date_formatter/src/models/models.dart';
import 'package:intl/intl.dart';

/// Myanmar Locale
class MyLocale extends Locale {
  @override
  String code() => 'my';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) =>
      '${NumberFormat.compact(locale: 'my').format(n)}.';

  @override
  RelativeDateTime relativeDateTime() => MyRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => MyShortRelativeDateTime();
}

/// Myanmar relative date time
class MyRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => 'ယခုမှစ၍ ';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => 'စောနက';

  @override
  String aboutAMinute(int minutes) => 'လွန်ခဲ့သော ၁ မိနစ်ခန့်';

  @override
  String minutes(int minutes) =>
      'လွန်ခဲ့သော ${NumberFormat.compact(locale: 'my').format(minutes)} မိနစ်';

  @override
  String aboutAnHour(int minutes) => 'လွန်ခဲ့သော ၁ နာရီခန့်';

  @override
  String hours(int hours) =>
      'လွန်ခဲ့သော ${NumberFormat.compact(locale: 'my').format(hours)} နာရီ';

  @override
  String aDay(int hours) => 'လွန်ခဲ့သော ၁ ရက်';

  @override
  String days(int days) =>
      'လွန်ခဲ့သော ${NumberFormat.compact(locale: 'my').format(days)} ရက်';

  @override
  String aboutAMonth(int days) => 'လွန်ခဲ့သော ၁ လခန့်';

  @override
  String months(int months) =>
      'လွန်ခဲ့သော ${NumberFormat.compact(locale: 'my').format(months)} လ';

  @override
  String aboutAYear(int year) => 'လွန်ခဲ့သော ၁ နှစ်ခန့်';

  @override
  String years(int years) =>
      'လွန်ခဲ့သော ${NumberFormat.compact(locale: 'my').format(years)} နှစ်';

  @override
  String wordSeparator() => ' ';
}

/// Myanmar short relative date time
class MyShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => 'စောနက';

  @override
  String aboutAMinute(int minutes) => '၁မိနစ်';

  @override
  String minutes(int minutes) =>
      '${NumberFormat.compact(locale: 'my').format(minutes)}မိနစ်';

  @override
  String aboutAnHour(int minutes) => '၁နာရီ';

  @override
  String hours(int hours) =>
      '${NumberFormat.compact(locale: 'my').format(hours)}နာရီ';

  @override
  String aDay(int hours) => '၁ရက်';

  @override
  String days(int days) =>
      '${NumberFormat.compact(locale: 'my').format(days)}ရက်';

  @override
  String aboutAMonth(int days) => '၁လ';

  @override
  String months(int months) =>
      '${NumberFormat.compact(locale: 'my').format(months)}လ';

  @override
  String aboutAYear(int year) => '၁နှစ်';

  @override
  String years(int years) =>
      '${NumberFormat.compact(locale: 'my').format(years)}နှစ်';
  @override
  String wordSeparator() => ' ';
}
