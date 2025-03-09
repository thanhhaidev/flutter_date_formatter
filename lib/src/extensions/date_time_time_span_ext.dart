import 'package:flutter_date_formatter/src/models/time_span.dart';

/// Extension methods for `DateTime` objects.
extension DateTimeTimeSpanExtensions on DateTime {
  /// Checks if the `DateTime` is within the `TimeSpan`.
  bool isWithin(DateTime start, DateTime end) =>
      TimeSpan(start, end).contains(this);

  /// Checks if the `DateTime` is within the `TimeSpan`.
  bool isWithinTimeSpan(TimeSpan timeSpan) => timeSpan.contains(this);
}
