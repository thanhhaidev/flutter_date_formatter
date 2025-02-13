import 'package:flutter_date_formatter/src/locale/locale.dart';
import 'package:flutter_date_formatter/src/models/models.dart';
import 'package:flutter_date_formatter/src/utils/utils.dart';
import 'package:intl/intl.dart';

/// A class that formats a [DateTime] object to a string.
class FlutterDateFormatter {
  /// Creates a new instance of [FlutterDateFormatter].
  FlutterDateFormatter([String? pattern, String? locale]) {
    if (locale != null && SupportedLocalesUtils.isLocaleSupported(locale)) {
      _locale = SupportedLocalesUtils.getLocale(locale);
    } else {
      _locale = EnLocale();
    }

    if (pattern != null) {
      _pattern = pattern;
    }
  }

  /// The locale in which we operate, e.g. 'en_US', or 'pt'.
  late Locale _locale;
  late final DateTime _dateTime;
  String? _pattern;

  /// Formats the given [datetime] according to the pattern provided.
  String format(DateTime datetime) {
    _dateTime = datetime;
    final pattern = _pattern ?? '';
    if (pattern.isEmpty) {
      throw Exception(
        'The provided pattern for datetime `$_dateTime` '
        'cannot be blank',
      );
    } else {
      final escapedPattern = ReplaceUtils.replaceEscapePattern(pattern);
      final localeOrdinal = _locale.ordinal(_dateTime.day);
      final newPattern = ReplaceUtils.replaceLocaleOrdinalDatePattern(
        escapedPattern,
        localeOrdinal,
      );
      return DateFormat(newPattern, _locale.code()).format(_dateTime);
    }
  }

  /// Formats provided [datetime] to a fuzzy time like 'a moment ago'
  ///
  /// - If [clock] is passed this will be the point of reference for calculating
  ///   the elapsed time. Defaults to DateTime.now()
  /// - If [allowFromNow] is passed, format will use the From prefix, ie. a date
  ///   5 minutes from now in 'en' locale will display as "5 minutes from now"
  static String formatRelativeDateTime(
    DateTime datetime, {
    String? locale,
    DateTime? clock,
    bool allowFromNow = false,
    bool short = false,
  }) {
    late Locale locale0;
    if (locale != null && SupportedLocalesUtils.isLocaleSupported(locale)) {
      locale0 = SupportedLocalesUtils.getLocale(locale);
    } else {
      locale0 = EnLocale();
    }

    return RelativeDateTimeUtils.format(
      datetime,
      clock ?? DateTime.now(),
      locale0,
      allowFromNow: allowFromNow,
      short: short,
    );
  }
}

void main(List<String> args) {
  int number = 2;
  String ordinal = EnLocale().ordinal(number);
  print(ordinal); // Output: 1st
}
