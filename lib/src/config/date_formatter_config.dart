import 'package:flutter_date_formatter/src/enums/start_of_week.dart';
import 'package:intl/intl.dart';

/// Package-wide settings: the default locale, the first day of the week and
/// the clock used as "now".
///
/// ```dart
/// DateFormatterConfig.configure(
///   locale: 'vi',
///   startOfWeek: StartOfWeek.monday,
///   clock: () => DateTime(2025, 3, 10, 12), // e.g. in tests
/// );
/// ```
class DateFormatterConfig {
  DateFormatterConfig._();

  static String? _locale;
  static StartOfWeek? _startOfWeek;
  static DateTime Function()? _clock;

  /// The default locale, used when a call does not pass one.
  ///
  /// When `null`, [Intl.defaultLocale] is used.
  static String? get locale => _locale;

  /// The first day of the week used by week APIs such as `startOfWeek`.
  ///
  /// When `null`, it comes from the locale data of [Intl.defaultLocale].
  static StartOfWeek? get startOfWeek => _startOfWeek;

  /// Updates the given settings and keeps the others.
  ///
  /// [clock] replaces `DateTime.now()` in every API that depends on the
  /// current time, such as `isToday`, `formatFromNow` or `formatCalendar`.
  static void configure({
    String? locale,
    StartOfWeek? startOfWeek,
    DateTime Function()? clock,
  }) {
    if (locale != null) _locale = locale;
    if (startOfWeek != null) _startOfWeek = startOfWeek;
    if (clock != null) _clock = clock;
  }

  /// Restores the default settings.
  static void reset() {
    _locale = null;
    _startOfWeek = null;
    _clock = null;
  }

  /// Returns the current time from the configured clock, or `DateTime.now()`.
  static DateTime now() => _clock?.call() ?? DateTime.now();

  /// Returns [locale], or the configured default locale, or
  /// [Intl.defaultLocale].
  static String? resolveLocale(String? locale) =>
      locale ?? _locale ?? Intl.defaultLocale;
}
