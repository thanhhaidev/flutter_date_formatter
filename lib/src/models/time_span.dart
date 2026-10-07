import 'package:flutter_date_formatter/src/enums/unit.dart';
import 'package:flutter_date_formatter/src/extensions/date_time_ext.dart';
import 'package:flutter_date_formatter/src/extensions/date_time_range_ext.dart';
import 'package:meta/meta.dart';

/// A class representing a time span between two `DateTime` objects.
/// It provides methods to calculate the start time, end time, duration,
/// and middle point, as well as operations for merging, intersecting,
/// and finding the difference between time spans.
@immutable
class TimeSpan {
  /// Creates a `TimeSpan` between two `DateTime` objects.
  ///
  /// The `start` and `end` parameters define the beginning and end of the
  /// time span. The duration is automatically calculated as the difference
  /// between the two times.
  TimeSpan(DateTime start, DateTime end)
      : _startTime = start,
        _duration = end.difference(start);

  /// Creates a `TimeSpan` starting from a given `DateTime` with a specified
  /// duration.
  ///
  /// The `start` parameter is the starting time of the time span,
  /// and `duration` is the length of the time span.
  /// The end time is automatically calculated by adding the duration
  /// to the start time.
  ///
  /// A negative duration is treated as signed, and the resulting span is
  /// normalized so that [start] is never after [end].
  const TimeSpan.fromStart(DateTime start, Duration duration)
      : _startTime = start,
        _duration = duration;

  /// Creates a `TimeSpan` ending at a given `DateTime`
  /// with a specified duration.
  ///
  /// The `end` parameter is the ending time of the time span,
  /// and `duration` is the length of the time span.
  /// The start time is calculated by subtracting the duration from
  /// the end time.
  ///
  /// A negative duration is treated as signed, and the resulting span is
  /// normalized so that [start] is never after [end].
  // Negating a Duration is not a constant expression.
  // ignore: prefer_const_constructors_in_immutables
  TimeSpan.fromEnd(DateTime end, Duration duration)
      : _startTime = end,
        _duration = -duration;

  /// Creates a `TimeSpan` with a given center and duration.
  ///
  /// The `center` parameter represents the middle point of the time span,
  ///  and `duration` defines the length of the time span.
  /// The start time is calculated by subtracting half of the duration from
  /// the center time.
  TimeSpan.fromCenter(DateTime center, Duration duration)
      : _startTime = center.subtract(duration ~/ 2),
        _duration = duration;

  final DateTime _startTime;
  final Duration _duration;

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
  /// Returns `true` if the two time spans share at least one instant
  /// (inclusive), including when one fully contains the other.
  bool intersects(TimeSpan other) =>
      !end.isBefore(other.start) && !other.end.isBefore(start);

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
  /// Returns a new `TimeSpan` that represents the union of the two time spans,
  /// from the earlier start to the later end.
  /// Throws a `RangeError` if the time spans don't intersect.
  TimeSpan merge(TimeSpan other) {
    if (!intersects(other)) {
      throw RangeError("TimeSpans don't intersect: this: $this; other: $other");
    }
    return TimeSpan(
      start.isBefore(other.start) ? start : other.start,
      end.isAfter(other.end) ? end : other.end,
    );
  }

  /// Returns the intersection of this `TimeSpan` and another `TimeSpan`.
  ///
  /// If the two time spans overlap, a new `TimeSpan` representing
  /// the intersection is returned. Otherwise, `null` is returned.
  TimeSpan? getIntersection(TimeSpan other) {
    if (!intersects(other)) {
      return null;
    }

    final intersectionStart = start.isAfter(other.start) ? start : other.start;
    final intersectionEnd = end.isBefore(other.end) ? end : other.end;

    return TimeSpan(intersectionStart, intersectionEnd);
  }

  /// Returns the parts of this `TimeSpan` that are not covered by [other].
  ///
  /// The result is empty when [other] covers this time span, holds a single
  /// item when they don't overlap or overlap on one side, and holds two items
  /// when [other] lies strictly inside this time span.
  List<TimeSpan> getDifferences(TimeSpan other) {
    if (other.containsTimeSpan(this)) {
      return [];
    }
    if (!intersects(other)) {
      return [this];
    }

    return [
      if (start.isBefore(other.start)) TimeSpan(start, other.start),
      if (other.end.isBefore(end)) TimeSpan(other.end, end),
    ];
  }

  /// Returns the difference between this `TimeSpan` and another `TimeSpan`.
  ///
  /// Returns `null` if [other] covers this time span, and the remaining part
  /// of this `TimeSpan` otherwise.
  /// Throws a `RangeError` if [other] lies strictly inside this time span,
  /// because the difference then has two parts; use [getDifferences] for that.
  TimeSpan? getDifference(TimeSpan other) {
    final differences = getDifferences(other);
    if (differences.length > 1) {
      throw RangeError(
        'Difference has two parts: this: $this; other: $other. '
        'Use getDifferences instead.',
      );
    }
    return differences.isEmpty ? null : differences.first;
  }

  /// Returns the symmetric difference between this `TimeSpan`
  /// and another `TimeSpan`.
  ///
  /// The symmetric difference consists of the parts of both time spans
  /// that do not overlap.
  /// This method returns a list of `TimeSpan` objects representing the
  /// non-overlapping sections, ordered by start time.
  List<TimeSpan> symmetricDifference(TimeSpan other) {
    final first = start.isBefore(other.start) ? this : other;
    final second = identical(first, this) ? other : this;

    if (first.end.isBefore(second.start)) {
      // No overlap, return both TimeSpans
      return [first, second];
    }

    final result = <TimeSpan>[];

    if (first.start.isBefore(second.start)) {
      result.add(TimeSpan(first.start, second.start));
    }

    if (first.end.isAfter(second.end)) {
      result.add(TimeSpan(second.end, first.end));
    } else if (second.end.isAfter(first.end)) {
      result.add(TimeSpan(first.end, second.end));
    }

    return result;
  }

  /// Returns the dates from [start] to [end] (inclusive), [step] [unit]s
  /// apart, e.g. every day of the time span.
  ///
  /// See [DateTimeRangeExtensions.rangeTo].
  Iterable<DateTime> iterate({Unit unit = Unit.day, int step = 1}) =>
      start.rangeTo(end, unit: unit, step: step);

  @override
  bool operator ==(Object other) =>
      other is TimeSpan && start == other.start && end == other.end;

  @override
  int get hashCode => Object.hash(start, end);

  @override
  String toString() =>
      'TimeSpan(${start.toIso8601String()} - ${end.toIso8601String()})';
}
