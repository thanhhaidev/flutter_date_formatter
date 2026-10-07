import 'package:flutter_date_formatter/src/models/models.dart';
import 'package:intl/intl.dart';

/// Myanmar Locale
class MyLocale extends DateFormatterLocale {
  @override
  String code() => 'my';

  @override
  String ordinal(int n) => '.';

  @override
  String ordinalNumber(int n) => '${_format(n)}.';

  @override
  RelativeDateTime relativeDateTime() => MyRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => MyShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => MyCalendarDateTime();

  @override
  DurationUnits durationUnits() => MyDurationUnits();

  @override
  DurationUnits shortDurationUnits() => MyShortDurationUnits();
}

/// Myanmar relative date time
class MyRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'လွန်ခဲ့သော';

  @override
  String prefixFromNow() => 'လာမည့်';

  @override
  String suffixAgo() => 'က';

  @override
  String suffixFromNow() => 'မှာ';

  @override
  String lessThanOneMinute(int seconds) => 'စက္ကန့်အနည်းငယ်';

  @override
  String aboutAMinute(int minutes) => '၁ မိနစ်ခန့်';

  @override
  String minutes(int minutes) => '${_format(minutes)} မိနစ်';

  @override
  String aboutAnHour(int minutes) => '၁ နာရီခန့်';

  @override
  String hours(int hours) => '${_format(hours)} နာရီ';

  @override
  String aDay(int hours) => '၁ ရက်';

  @override
  String days(int days) => '${_format(days)} ရက်';

  @override
  String aboutAMonth(int days) => '၁ လခန့်';

  @override
  String months(int months) => '${_format(months)} လ';

  @override
  String aboutAYear(int year) => '၁ နှစ်ခန့်';

  @override
  String years(int years) => '${_format(years)} နှစ်';

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

  // Neutral "now": the short form has no prefix/suffix, so the text must
  // read correctly for both past and future ("စောနက" means "a while ago").
  @override
  String lessThanOneMinute(int seconds) => 'ယခု';

  @override
  String aboutAMinute(int minutes) => '၁မိနစ်';

  @override
  String minutes(int minutes) => '${_format(minutes)}မိနစ်';

  @override
  String aboutAnHour(int minutes) => '၁နာရီ';

  @override
  String hours(int hours) => '${_format(hours)}နာရီ';

  @override
  String aDay(int hours) => '၁ရက်';

  @override
  String days(int days) => '${_format(days)}ရက်';

  @override
  String aboutAMonth(int days) => '၁လ';

  @override
  String months(int months) => '${_format(months)}လ';

  @override
  String aboutAYear(int year) => '၁နှစ်';

  @override
  String years(int years) => '${_format(years)}နှစ်';
  @override
  String wordSeparator() => ' ';
}

/// Formats [n] with Myanmar digits, keeping the full number (no compact form).
String _format(int n) => NumberFormat('#', 'my').format(n);

/// Myanmar calendar date time
class MyCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'ယနေ့ $time မှာ';

  @override
  String nextDay(String time) => 'မနက်ဖြန် $time မှာ';

  @override
  String lastDay(String time) => 'မနေ့က $time မှာ';

  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekday $time မှာ';

  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      'ပြီးခဲ့သော $weekday $time မှာ';
}

/// Myanmar duration units
class MyDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '${_format(seconds)} စက္ကန့်';

  @override
  String minutes(int minutes) => '${_format(minutes)} မိနစ်';

  @override
  String hours(int hours) => '${_format(hours)} နာရီ';

  @override
  String days(int days) => '${_format(days)} ရက်';

  @override
  String weeks(int weeks) => '${_format(weeks)} ပတ်';

  @override
  String delimiter() => ' ';
}

/// Myanmar short duration units
class MyShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '${_format(seconds)}စက္ကန့်';

  @override
  String minutes(int minutes) => '${_format(minutes)}မိနစ်';

  @override
  String hours(int hours) => '${_format(hours)}နာရီ';

  @override
  String days(int days) => '${_format(days)}ရက်';

  @override
  String weeks(int weeks) => '${_format(weeks)}ပတ်';

  @override
  String delimiter() => ' ';
}
