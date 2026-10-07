import 'package:flutter_date_formatter/src/models/calendar_date_time.dart';
import 'package:flutter_date_formatter/src/models/duration_units.dart';
import 'package:flutter_date_formatter/src/models/relative_date_time.dart';

/// Deprecated alias of [DateFormatterLocale].
///
/// This name clashes with `Locale` from `dart:ui` in Flutter apps.
@Deprecated('Use DateFormatterLocale instead. Will be removed in 1.0.0.')
typedef Locale = DateFormatterLocale;

/// The locale rules (ordinals and relative date/time strings) used by
/// this package.
abstract class DateFormatterLocale {
  /// Returns the locale code for this locale.
  String code();

  /// Returns a list of ordinal suffixes for this locale.
  ///
  /// Ordinal suffixes are used to format the ordinal number of a day
  /// (For example, "st", "nd", "rd", "th").
  String ordinal(int n);

  /// Returns the ordinal number for the given number [n].
  String ordinalNumber(int n);

  /// Returns a [RelativeDateTime] instance for this locale.
  ///
  /// A [RelativeDateTime] instance encapsulates the rules for formatting
  /// relative date/time values (For example, "3 hours ago", "in 2 days") for
  /// a specific locale.
  RelativeDateTime relativeDateTime();

  /// Returns a [RelativeDateTime] instance for this locale that formats
  /// short relative date/time values.
  ///
  /// Short relative date/time values are used to format relative date/time
  /// values in a more concise manner.
  ///
  /// For example, "an hour" can be formatted as "~1h".
  RelativeDateTime shortRelativeDateTime();

  /// Returns the calendar strings ("Today at 3:00 PM") for this locale, or
  /// `null` to use English.
  CalendarDateTime? calendarDateTime() => null;

  /// Returns the unit strings for humanized durations ("2 hours 5 minutes")
  /// for this locale, or `null` to use English.
  DurationUnits? durationUnits() => null;

  /// Returns the short unit strings for humanized durations ("2h 5m") for
  /// this locale, or `null` to use English.
  DurationUnits? shortDurationUnits() => null;
}
