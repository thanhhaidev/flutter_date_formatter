import 'package:flutter_date_formatter/src/extensions/date_time_ext.dart';

/// A class representing a time span between two `DateTime` objects.
/// It provides methods to calculate the start time, end time, duration,
/// and middle point, as well as operations for merging, intersecting,
/// and finding the difference between time spans.
class TimeSpan {
  /// Creates a `TimeSpan` between two `DateTime` objects.
  ///
  /// The `start` and `end` parameters define the beginning and end of the
  /// time span. The duration is automatically calculated as the difference
  /// between the two times.
  TimeSpan(DateTime start, DateTime end) {
    _startTime = start;
    _duration = end.difference(start);
  }

  /// Creates a `TimeSpan` starting from a given `DateTime` with a specified
  /// duration.
  ///
  /// The `start` parameter is the starting time of the time span,
  /// and `duration` is the length of the time span.
  /// The end time is automatically calculated by adding the duration
  /// to the start time.
  TimeSpan.fromStart(DateTime start, Duration duration)
      : _startTime = start,
        _duration = duration;

  /// Creates a `TimeSpan` ending at a given `DateTime`
  /// with a specified duration.
  ///
  /// The `end` parameter is the ending time of the time span,
  /// and `duration` is the length of the time span.
  /// The start time is calculated by subtracting the duration from
  /// the end time.
  TimeSpan.fromEnd(DateTime end, Duration duration)
      : _startTime = end,
        _duration = -duration;

  /// Creates a `TimeSpan` with a given center and duration.
  ///
  /// The `center` parameter represents the middle point of the time span,
  ///  and `duration` defines the length of the time span.
  /// The start time is calculated by subtracting half of the duration from
  /// the center time.
  TimeSpan.fromCenter(DateTime center, Duration duration) {
    _startTime = center.subtract(duration ~/ 2);
    _duration = duration;
  }
  late final DateTime _startTime;
  late final Duration _duration;

  /// Returns the start time of the `TimeSpan`.
  DateTime get start =>
      _duration.isNegative ? _startTime.add(_duration) : _startTime;

  /// Returns the end time of the `TimeSpan`.
  DateTime get end =>
      _duration.isNegative ? _startTime : _startTime.add(_duration);

  /// Returns the total duration of the `TimeSpan`.
  Duration get totalDuration => end.difference(start);

  /// Returns the middle time of the `TimeSpan`.
  DateTime get middle => start.add(totalDuration ~/ 2);

  /// Returns a new `TimeSpan` with a modified start time.
  TimeSpan withStart(DateTime newStart) => TimeSpan(newStart, end);

  /// Returns a new `TimeSpan` with a modified end time.
  TimeSpan withEnd(DateTime newEnd) => TimeSpan(start, newEnd);

  /// Returns a new `TimeSpan` with a modified duration,
  /// starting from the start time.
  TimeSpan withDurationFromStart(Duration newDuration) =>
      TimeSpan.fromStart(start, newDuration);

  /// Returns a new `TimeSpan` with a modified duration,
  /// starting from the end time.
  TimeSpan withDurationFromEnd(Duration newDuration) =>
      TimeSpan.fromEnd(end, newDuration);

  /// Returns a new `TimeSpan` with a modified duration,
  /// starting from the center time.
  TimeSpan withDurationFromCenter(Duration newDuration) =>
      TimeSpan.fromCenter(middle, newDuration);

  /// Checks if a given `DateTime` is within the time span.
  ///
  /// Returns `true` if the date is between the start and end of the time span
  /// (inclusive).
  bool contains(DateTime date) =>
      date.isSameOrAfter(start) && date.isSameOrBefore(end);

  /// Checks if this `TimeSpan` contains another `TimeSpan`.
  ///
  /// Returns `true` if both the start and end of the other `TimeSpan` are
  /// within this time span.
  bool containsTimeSpan(TimeSpan other) =>
      contains(other.start) && contains(other.end);

  /// Checks if this `TimeSpan` intersects with another `TimeSpan`.
  ///
  /// Returns `true` if the other `TimeSpan` is partially or fully within
  /// this time span.
  bool intersects(TimeSpan other) =>
      contains(other.start) || contains(other.end);

  /// Checks if this `TimeSpan` is equal to another `TimeSpan`.
  ///
  /// Returns `true` if both the start and end of this `TimeSpan` are the same
  /// as another `TimeSpan`.
  bool isSame(TimeSpan other) =>
      start.isSame(other.start) && end.isSame(other.end);

  /// Checks if this `TimeSpan` is before another `TimeSpan`.
  ///
  /// Returns `true` if the end time of this `TimeSpan` is before the start
  /// time of another `TimeSpan`.
  bool isBefore(TimeSpan other) => end.isBefore(other.start);

  /// Checks if this `TimeSpan` is before or the same as another `TimeSpan`.
  ///
  /// Returns `true` if the end time of this `TimeSpan` is before or the same
  /// as the start time of another `TimeSpan`.
  bool isBeforeOrSame(TimeSpan other) =>
      end.isBefore(other.start) || end.isSame(other.start);

  /// Checks if this `TimeSpan` is after another `TimeSpan`.
  ///
  /// Returns `true` if the start time of this `TimeSpan` is after the end
  /// time of another `TimeSpan`.
  bool isAfter(TimeSpan other) => start.isAfter(other.end);

  /// Checks if this `TimeSpan` is after or the same as another `TimeSpan`.
  ///
  /// Returns `true` if the start time of this `TimeSpan` is after or the same
  /// as the end time of another `TimeSpan`.
  bool isAfterOrSame(TimeSpan other) =>
      start.isAfter(other.end) || start.isSame(other.end);

  /// Merges this `TimeSpan` with another `TimeSpan` if they intersect.
  ///
  /// Returns a new `TimeSpan` that represents the union of the two time spans.
  /// Throws a `RangeError` if the time spans don't intersect.
  TimeSpan merge(TimeSpan other) {
    if (intersects(other)) {
      if (end.isAfter(other.start) || end.isSame(other.start)) {
        return TimeSpan(start, other.end);
      } else if (other.end.isAfter(start) || other.end.isSame(start)) {
        return TimeSpan(other.start, end);
      } else {
        throw RangeError('Merge error: this: $this; other: $other');
      }
    } else {
      throw RangeError("TimeSpans don't intersect");
    }
  }

  /// Returns the intersection of this `TimeSpan` and another `TimeSpan`.
  ///
  /// If the two time spans overlap, a new `TimeSpan` representing
  /// the intersection is returned. Otherwise, `null` is returned.
  TimeSpan? getIntersection(TimeSpan other) {
    if (end.isBefore(other.start) || other.end.isBefore(start)) {
      // No overlap
      return null;
    }

    final intersectionStart = start.isAfter(other.start) ? start : other.start;
    final intersectionEnd = end.isBefore(other.end) ? end : other.end;

    return TimeSpan(intersectionStart, intersectionEnd);
  }

  /// Returns the difference between this `TimeSpan` and another `TimeSpan`.
  ///
  /// If the two time spans are equal, `null` is returned.
  /// Otherwise, the method returns the non-overlapping parts of
  /// this `TimeSpan` compared to the other `TimeSpan`.
  TimeSpan? getDifference(TimeSpan other) {
    if (other.isSame(this)) {
      return null;
    } else if (isBeforeOrSame(other)) {
      if (end.isBefore(other.start)) {
        return this;
      } else {
        return TimeSpan(start, other.start);
      }
    } else if (isAfterOrSame(other)) {
      if (other.end.isBefore(start)) {
        return this;
      } else {
        return TimeSpan(other.end, end);
      }
    } else {
      throw RangeError('Difference error: this: $this; other: $other');
    }
  }

  /// Returns the symmetric difference between this `TimeSpan`
  /// and another `TimeSpan`.
  ///
  /// The symmetric difference consists of the parts of both time spans
  /// that do not overlap.
  /// This method returns a list of `TimeSpan` objects representing the
  /// non-overlapping sections.
  List<TimeSpan> symmetricDifference(TimeSpan other) {
    final first = start.isBefore(other.start) ? this : other;
    final second = start.isBefore(other.start) ? other : this;

    if (first.end.isBefore(other.start) || second.end.isBefore(first.start)) {
      // No overlap, return both TimeSpans
      return [first, second];
    }

    final result = <TimeSpan>[];

    if (first.start.isBefore(second.start)) {
      result.add(TimeSpan(first.start, second.start));
    } else if (second.start.isBefore(first.start)) {
      result.add(TimeSpan(second.start, first.start));
    }

    if (first.end.isAfter(second.end)) {
      result.add(TimeSpan(second.end, first.end));
    } else if (second.end.isAfter(first.end)) {
      result.add(TimeSpan(first.end, second.end));
    }

    return result;
  }
}
