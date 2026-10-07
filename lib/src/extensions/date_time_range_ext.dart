import 'package:flutter_date_formatter/src/enums/unit.dart';
import 'package:flutter_date_formatter/src/extensions/date_time_ext.dart';

/// Extension methods for comparing and iterating [DateTime] objects.
extension DateTimeRangeExtensions on DateTime {
  /// Returns this DateTime limited to the range from [min] to [max]
  /// (inclusive).
  ///
  /// Throws an [ArgumentError] if [min] is after [max].
  DateTime clamp(DateTime min, DateTime max) {
    if (min.isAfter(max)) {
      throw ArgumentError('min ($min) is after max ($max)');
    }
    if (isBefore(min)) return min;
    if (isAfter(max)) return max;
    return this;
  }

  /// Returns the dates from this DateTime to [end] (inclusive), [step]
  /// [unit]s apart.
  ///
  /// Days, weeks, months and years are calendar steps, so the wall-clock
  /// time is kept across daylight saving time transitions, and a month step
  /// from January 31 gives the last day of shorter months. The result is
  /// empty when [end] is before this DateTime.
  ///
  /// Throws an [ArgumentError] if [step] is not positive.
  Iterable<DateTime> rangeTo(
    DateTime end, {
    Unit unit = Unit.day,
    int step = 1,
  }) sync* {
    if (step < 1) {
      throw ArgumentError.value(step, 'step', 'Must be positive');
    }
    for (var index = 0;; index++) {
      final date = _addUnits(unit, index * step);
      if (date.isAfter(end)) return;
      yield date;
    }
  }

  DateTime _addUnits(Unit unit, int amount) => switch (unit) {
        Unit.microsecond => addMicroseconds(amount),
        Unit.millisecond => addMilliseconds(amount),
        Unit.second => addSeconds(amount),
        Unit.minute => addMinutes(amount),
        Unit.hour => addHours(amount),
        Unit.day => addDays(amount),
        Unit.week => addWeeks(amount),
        Unit.month => addMonths(amount),
        Unit.year => addYears(amount),
      };
}

/// Extension methods for collections of [DateTime] objects.
extension DateTimeIterableExtensions on Iterable<DateTime> {
  /// Returns the earliest date, or `null` if the collection is empty.
  DateTime? get earliest =>
      isEmpty ? null : reduce((a, b) => b.isBefore(a) ? b : a);

  /// Returns the latest date, or `null` if the collection is empty.
  DateTime? get latest =>
      isEmpty ? null : reduce((a, b) => b.isAfter(a) ? b : a);
}
