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
  /// - If [short] is passed, format will use the short version of the relative
  ///  time, ie. "5m" for 5 minutes
  /// - If [withPrefixAndSuffix] is passed, format will include the prefix and
  ///  suffix, ie. "5 minutes ago" or "5 minutes from now"
  static String formatRelativeDateTime(
    DateTime datetime, {
    String? locale,
    DateTime? clock,
    bool allowFromNow = false,
    bool short = false,
    bool withPrefixAndSuffix = true,
  }) {
    return RelativeDateTimeUtils.format(
      datetime,
      clock ?? DateTime.now(),
      SupportedLocalesUtils.getLocale(locale),
      allowFromNow: allowFromNow,
      short: short,
      withPrefixAndSuffix: withPrefixAndSuffix,
    );
  }

  /// Returns the ordinal number for the given [n] in the specified [locale].
  static String ordinal(int n, {String? locale}) {
    return SupportedLocalesUtils.getLocale(locale).ordinalNumber(n);
  }
}
