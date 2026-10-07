import 'package:flutter_date_formatter/src/models/models.dart';

/// Arabic Locale
class ArLocale extends DateFormatterLocale {
  @override
  String code() => 'ar';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n';

  @override
  RelativeDateTime relativeDateTime() => ArRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => ArShortRelativeDateTime();

  @override
  CalendarDateTime calendarDateTime() => ArCalendarDateTime();

  @override
  DurationUnits durationUnits() => ArDurationUnits();

  @override
  DurationUnits shortDurationUnits() => ArShortDurationUnits();
}

/// Arabic relative date time
class ArRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => 'منذ';
  @override
  String prefixFromNow() => 'بعد';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) {
    if (seconds < 1) {
      return 'لحظات';
    } else if (seconds == 1) {
      return 'ثانية واحدة';
    } else if (seconds == 2) {
      return 'ثانيتين';
    } else if (seconds > 2 && seconds < 11) {
      return '$seconds ثواني';
    } else {
      return '$seconds ثانية';
    }
  }

  @override
  String aboutAMinute(int minutes) => 'دقيقة تقريباً';

  @override
  String minutes(int minutes) {
    if (minutes == 2) {
      return 'دقيقتين';
    } else if (minutes > 2 && minutes < 11) {
      return '$minutes دقائق';
    } else {
      return '$minutes دقيقة';
    }
  }

  @override
  String aboutAnHour(int minutes) => 'ساعة تقريباً';
  @override
  String hours(int hours) {
    if (hours == 2) {
      return 'ساعتين';
    } else if (hours > 2 && hours < 11) {
      return '$hours ساعات';
    } else {
      return '$hours ساعة';
    }
  }

  @override
  String aDay(int hours) => 'يوم';
  @override
  String days(int days) {
    if (days == 2) {
      return 'يومين';
    } else if (days > 2 && days < 11) {
      return '$days ايام';
    } else {
      return '$days يوم';
    }
  }

  @override
  String aboutAMonth(int days) => 'شهر تقريباً';
  @override
  String months(int months) {
    if (months == 2) {
      return 'شهرين';
    } else if (months > 2 && months < 11) {
      return '$months اشهر';
    } else if (months > 10) {
      return '$months شهر';
    }
    return '$months شهور';
  }

  @override
  String aboutAYear(int year) => 'سنة تقريباً';
  @override
  String years(int years) {
    if (years == 2) {
      return 'سنتين';
    } else if (years > 2 && years < 11) {
      return '$years سنوات';
    } else {
      return '$years سنة';
    }
  }

  @override
  String wordSeparator() => ' ';
}

/// Arabic short relative date time
class ArShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => seconds < 1 ? 'الآن' : '$seconds ثا';
  @override
  String aboutAMinute(int minutes) => '~1 د';
  @override
  String minutes(int minutes) => '$minutes د';
  @override
  String aboutAnHour(int minutes) => '~1 س';
  @override
  String hours(int hours) => '$hours س';
  @override
  String aDay(int hours) => '~1 ي';
  @override
  String days(int days) => '$days ي';
  @override
  String aboutAMonth(int days) => '~1 ش';
  @override
  String months(int months) => '$months ش';
  @override
  String aboutAYear(int year) => '~1 سنة';
  @override
  String years(int years) => '$years سنة';
  @override
  String wordSeparator() => ' ';
}

/// Arabic calendar date time
class ArCalendarDateTime implements CalendarDateTime {
  @override
  String sameDay(String time) => 'اليوم عند الساعة $time';
  @override
  String nextDay(String time) => 'غدًا عند الساعة $time';
  @override
  String lastDay(String time) => 'أمس عند الساعة $time';
  @override
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekday عند الساعة $time';
  @override
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  }) =>
      '$weekday الماضي عند الساعة $time';
}

/// Arabic duration units
class ArDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => _plural(
        seconds,
        one: 'ثانية واحدة',
        two: 'ثانيتان',
        few: 'ثوان',
        many: 'ثانية',
        other: 'ثانية',
      );
  @override
  String minutes(int minutes) => _plural(
        minutes,
        one: 'دقيقة واحدة',
        two: 'دقيقتان',
        few: 'دقائق',
        many: 'دقيقة',
        other: 'دقيقة',
      );
  @override
  String hours(int hours) => _plural(
        hours,
        one: 'ساعة واحدة',
        two: 'ساعتان',
        few: 'ساعات',
        many: 'ساعة',
        other: 'ساعة',
      );
  @override
  String days(int days) => _plural(
        days,
        one: 'يوم واحد',
        two: 'يومان',
        few: 'أيام',
        many: 'يومًا',
        other: 'يوم',
      );
  @override
  String weeks(int weeks) => _plural(
        weeks,
        one: 'أسبوع واحد',
        two: 'أسبوعان',
        few: 'أسابيع',
        many: 'أسبوعًا',
        other: 'أسبوع',
      );
  @override
  String delimiter() => ' و';
}

/// Arabic short duration units
class ArShortDurationUnits implements DurationUnits {
  @override
  String seconds(int seconds) => '$seconds ث';
  @override
  String minutes(int minutes) => '$minutes د';
  @override
  String hours(int hours) => '$hours س';
  @override
  String days(int days) => '$days ي';
  @override
  String weeks(int weeks) => ArDurationUnits().weeks(weeks);
  @override
  String delimiter() => ' ';
}

/// CLDR plural rule for Arabic (zero, one, two, few, many, other).
///
/// The singular and dual forms already express the count, as in moment.js.
String _plural(
  int n, {
  required String one,
  required String two,
  required String few,
  required String many,
  required String other,
}) {
  if (n == 1) return one;
  if (n == 2) return two;
  final mod100 = n % 100;
  if (mod100 >= 3 && mod100 <= 10) return '$n $few';
  if (mod100 >= 11) return '$n $many';
  return '$n $other';
}
