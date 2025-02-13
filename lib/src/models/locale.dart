import 'package:flutter_date_formatter/src/models/relative_date_time.dart';

/// An abstract class representing a Locale in Dart.
abstract class Locale {
  /// Returns the locale code for this locale.
  String code();

  /// Returns a list of ordinal suffixes for this locale.
  ///
  /// Ordinal suffixes are used to format the ordinal number of a day
  /// (For example, "st", "nd", "rd", "th").
  String ordinal(int n);

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
}
