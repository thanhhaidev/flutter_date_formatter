import 'package:flutter_date_formatter/flutter_date_formatter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  setUp(() async {
    Intl.defaultLocale = 'en_US';
    await initializeDateFormatting();
  });

  group('DateTimeExtensions', () {
    final now = DateTime.now();
    final past = now.subtract(const Duration(days: 1));
    final future = now.add(const Duration(days: 1));

    test('isFuture', () {
      expect(future.isFuture, isTrue);
      expect(now.isFuture, isFalse);
      expect(past.isFuture, isFalse);
    });

    test('isPast', () {
      expect(past.isPast, isTrue);
      expect(future.isPast, isFalse);
    });

    test('isToday', () {
      expect(now.isToday, isTrue);
      expect(past.isToday, isFalse);
      expect(future.isToday, isFalse);
    });

    test('isYesterday', () {
      expect(past.isYesterday, isTrue);
      expect(now.isYesterday, isFalse);
      expect(future.isYesterday, isFalse);
    });

    test('isTomorrow', () {
      expect(future.isTomorrow, isTrue);
      expect(now.isTomorrow, isFalse);
      expect(past.isTomorrow, isFalse);
    });

    test('isLocal', () {
      expect(now.isLocal, isTrue);
      expect(now.toUtc().isLocal, isFalse);
    });

    test('isWeekend', () {
      final saturday = DateTime(2025, 3, 8);
      final sunday = DateTime(2025, 3, 9);
      final monday = DateTime(2025, 3, 10);

      expect(saturday.isWeekend, isTrue);
      expect(sunday.isWeekend, isTrue);
      expect(monday.isWeekend, isFalse);
    });

    test('dayOfWeek', () {
      final monday = DateTime(2025, 3, 10);
      final tuesday = DateTime(2025, 3, 11);

      expect(monday.dayOfWeek, 2);
      expect(tuesday.dayOfWeek, 3);
    });

    test('isLeapYear', () {
      final leapYear = DateTime(2024);
      final nonLeapYear = DateTime(2025);

      expect(leapYear.isLeapYear, isTrue);
      expect(nonLeapYear.isLeapYear, isFalse);
    });

    test('dayOfYear', () {
      final date = DateTime(2025, 3, 10);
      expect(date.dayOfYear, 69);
    });

    test('daysInMonth', () {
      final date = DateTime(2025, 2);
      expect(date.daysInMonth, 28);
    });

    test('weekOfYear', () {
      final date = DateTime(2025, 3, 10);
      expect(date.weekOfYear, 11);
    });

    test('quarterOfYear', () {
      final date = DateTime(2025, 3, 10);
      expect(date.quarterOfYear, 1);
    });

    test('startOfDay', () {
      final date = DateTime(2025, 3, 10, 15, 30);
      expect(date.startOfDay, DateTime(2025, 3, 10));
    });

    test('startOfWeek', () {
      final date = DateTime(2025, 3, 10);
      expect(date.startOfWeek, DateTime(2025, 3, 9));
    });

    test('startOfMonth', () {
      final date = DateTime(2025, 3, 10);
      expect(date.startOfMonth, DateTime(2025, 3));
    });

    test('startOfYear', () {
      final date = DateTime(2025, 3, 10);
      expect(date.startOfYear, DateTime(2025));
    });

    test('startOfQuarter', () {
      final date = DateTime(2025, 3, 10);
      expect(date.startOfQuarter, DateTime(2025));
    });

    test('endOfDay', () {
      final date = DateTime(2025, 3, 10, 15, 30);
      expect(date.endOfDay, DateTime(2025, 3, 10, 23, 59, 59, 999, 999));
    });

    test('endOfWeek', () {
      final date = DateTime(2025, 3, 10);
      expect(date.endOfWeek, DateTime(2025, 3, 15, 23, 59, 59, 999, 999));
    });

    test('endOfMonth', () {
      final date = DateTime(2025, 3, 10);
      expect(date.endOfMonth, DateTime(2025, 3, 31, 23, 59, 59, 999, 999));
    });

    test('endOfYear', () {
      final date = DateTime(2025, 3, 10);
      expect(date.endOfYear, DateTime(2025, 12, 31, 23, 59, 59, 999, 999));
    });

    test('endOfQuarter', () {
      final date = DateTime(2025, 3, 10);
      expect(date.endOfQuarter, DateTime(2025, 3, 31, 23, 59, 59, 999, 999));
    });

    test('indexOfClosestDay', () {
      final dates = [
        DateTime(2025, 3, 8),
        DateTime(2025, 3, 9),
        DateTime(2025, 3, 10),
      ];
      final date = DateTime(2025, 3, 9, 12);
      expect(date.indexOfClosestDay(dates), 1);
    });

    test('closestDayTo', () {
      final dates = [
        DateTime(2025, 3, 8),
        DateTime(2025, 3, 9),
        DateTime(2025, 3, 10),
      ];
      final date = DateTime(2025, 3, 9, 12);
      expect(date.closestDayTo(dates), DateTime(2025, 3, 9));
    });

    test('clone', () {
      final date = DateTime(2025, 3, 10);
      expect(date.clone(), date);
    });

    test('startOf', () {
      final date = DateTime(2025, 3, 10, 15, 30);
      expect(date.startOf(Unit.day), DateTime(2025, 3, 10));
    });

    test('endOf', () {
      final date = DateTime(2025, 3, 10, 15, 30);
      expect(date.endOf(Unit.day), DateTime(2025, 3, 10, 23, 59, 59, 999, 999));
    });

    test('subtractDate', () {
      final date = DateTime(2025, 3, 10);
      expect(date.subtractDate(days: 1), DateTime(2025, 3, 9));
    });

    test('subYears', () {
      final date = DateTime(2025, 3, 10);
      expect(date.subYears(1), DateTime(2024, 3, 10));
    });

    test('subMonths', () {
      final date = DateTime(2025, 3, 10);
      expect(date.subMonths(1), DateTime(2025, 2, 10));
    });

    test('subWeeks', () {
      final date = DateTime(2025, 3, 10);
      expect(date.subWeeks(1), DateTime(2025, 3, 3));
    });

    test('subDays', () {
      final date = DateTime(2025, 3, 10);
      expect(date.subDays(1), DateTime(2025, 3, 9));
    });

    test('subHours', () {
      final date = DateTime(2025, 3, 10, 12);
      expect(date.subHours(1), DateTime(2025, 3, 10, 11));
    });

    test('subMinutes', () {
      final date = DateTime(2025, 3, 10, 12, 30);
      expect(date.subMinutes(1), DateTime(2025, 3, 10, 12, 29));
    });

    test('subSeconds', () {
      final date = DateTime(2025, 3, 10, 12, 30, 30);
      expect(date.subSeconds(1), DateTime(2025, 3, 10, 12, 30, 29));
    });

    test('subMilliseconds', () {
      final date = DateTime(2025, 3, 10, 12, 30, 30, 500);
      expect(date.subMilliseconds(1), DateTime(2025, 3, 10, 12, 30, 30, 499));
    });

    test('subMicroseconds', () {
      final date = DateTime(2025, 3, 10, 12, 30, 30, 500, 500);
      expect(
        date.subMicroseconds(1),
        DateTime(2025, 3, 10, 12, 30, 30, 500, 499),
      );
    });

    test('addDate', () {
      final date = DateTime(2025, 3, 10);
      expect(date.addDate(days: 1), DateTime(2025, 3, 11));
    });

    test('addYears', () {
      final date = DateTime(2025, 3, 10);
      expect(date.addYears(1), DateTime(2026, 3, 10));
    });

    test('addMonths', () {
      final date = DateTime(2025, 3, 10);
      expect(date.addMonths(1), DateTime(2025, 4, 10));
    });

    test('addWeeks', () {
      final date = DateTime(2025, 3, 10);
      expect(date.addWeeks(1), DateTime(2025, 3, 17));
    });

    test('addDays', () {
      final date = DateTime(2025, 3, 10);
      expect(date.addDays(1), DateTime(2025, 3, 11));
    });

    test('addHours', () {
      final date = DateTime(2025, 3, 10, 12);
      expect(date.addHours(1), DateTime(2025, 3, 10, 13));
    });

    test('addMinutes', () {
      final date = DateTime(2025, 3, 10, 12, 30);
      expect(date.addMinutes(1), DateTime(2025, 3, 10, 12, 31));
    });

    test('addSeconds', () {
      final date = DateTime(2025, 3, 10, 12, 30, 30);
      expect(date.addSeconds(1), DateTime(2025, 3, 10, 12, 30, 31));
    });

    test('addMilliseconds', () {
      final date = DateTime(2025, 3, 10, 12, 30, 30, 500);
      expect(date.addMilliseconds(1), DateTime(2025, 3, 10, 12, 30, 30, 501));
    });

    test('addMicroseconds', () {
      final date = DateTime(2025, 3, 10, 12, 30, 30, 500, 500);
      expect(
        date.addMicroseconds(1),
        DateTime(2025, 3, 10, 12, 30, 30, 500, 501),
      );
    });

    test('diff', () {
      final date1 = DateTime(2025, 3, 10);
      final date2 = DateTime(2025, 3, 11);
      expect(date1.diff(date2, unit: Unit.day), -1);
    });

    test('diffInYears', () {
      final date1 = DateTime(2025, 3, 10);
      final date2 = DateTime(2026, 3, 10);
      expect(date1.diffInYears(date2), -1);
    });

    test('diffInMonths', () {
      final date1 = DateTime(2025, 3, 10);
      final date2 = DateTime(2025, 4, 10);
      expect(date1.diffInMonths(date2), -1);
    });

    test('diffInWeeks', () {
      final date1 = DateTime(2025, 3, 10);
      final date2 = DateTime(2025, 3, 17);
      expect(date1.diffInWeeks(date2), -1);
    });

    test('diffInDays', () {
      final date1 = DateTime(2025, 3, 10);
      final date2 = DateTime(2025, 3, 11);
      expect(date1.diffInDays(date2), -1);
    });

    test('diffInHours', () {
      final date1 = DateTime(2025, 3, 10, 12);
      final date2 = DateTime(2025, 3, 10, 13);
      expect(date1.diffInHours(date2), -1);
    });

    test('diffInMinutes', () {
      final date1 = DateTime(2025, 3, 10, 12, 30);
      final date2 = DateTime(2025, 3, 10, 12, 31);
      expect(date1.diffInMinutes(date2), -1);
    });

    test('diffInSeconds', () {
      final date1 = DateTime(2025, 3, 10, 12, 30, 30);
      final date2 = DateTime(2025, 3, 10, 12, 30, 31);
      expect(date1.diffInSeconds(date2), -1);
    });

    test('diffInMilliseconds', () {
      final date1 = DateTime(2025, 3, 10, 12, 30, 30, 500);
      final date2 = DateTime(2025, 3, 10, 12, 30, 30, 501);
      expect(date1.diffInMilliseconds(date2), -1);
    });

    test('isBeforeDate', () {
      final date1 = DateTime(2025, 3, 10);
      final date2 = DateTime(2025, 3, 11);
      expect(date1.isBeforeDate(date2), isTrue);
    });

    test('isAfterDate', () {
      final date1 = DateTime(2025, 3, 11);
      final date2 = DateTime(2025, 3, 10);
      expect(date1.isAfterDate(date2), isTrue);
    });

    test('isSame', () {
      final date1 = DateTime(2025, 3, 10);
      final date2 = DateTime(2025, 3, 10);
      expect(date1.isSame(date2), isTrue);
    });

    test('isSameDay', () {
      final date1 = DateTime(2025, 3, 10);
      final date2 = DateTime(2025, 3, 10);
      expect(date1.isSameDay(date2), isTrue);
    });

    test('isSameWeek', () {
      final date1 = DateTime(2025, 3, 10);
      final date2 = DateTime(2025, 3, 11);
      expect(date1.isSameWeek(date2), isTrue);
    });

    test('isSameMonth', () {
      final date1 = DateTime(2025, 3, 10);
      final date2 = DateTime(2025, 3, 11);
      expect(date1.isSameMonth(date2), isTrue);
    });

    test('isSameYear', () {
      final date1 = DateTime(2025, 3, 10);
      final date2 = DateTime(2025, 3, 11);
      expect(date1.isSameYear(date2), isTrue);
    });

    test('isSameMinute', () {
      final date1 = DateTime(2025, 3, 10, 12, 30);
      final date2 = DateTime(2025, 3, 10, 12, 30);
      expect(date1.isSameMinute(date2), isTrue);
    });

    test('isSameHour', () {
      final date1 = DateTime(2025, 3, 10, 12);
      final date2 = DateTime(2025, 3, 10, 12);
      expect(date1.isSameHour(date2), isTrue);
    });

    test('isSameSecond', () {
      final date1 = DateTime(2025, 3, 10, 12, 30, 30);
      final date2 = DateTime(2025, 3, 10, 12, 30, 30);
      expect(date1.isSameSecond(date2), isTrue);
    });

    test('isSameOrBefore', () {
      final date1 = DateTime(2025, 3, 10);
      final date2 = DateTime(2025, 3, 11);
      expect(date1.isSameOrBefore(date2), isTrue);
    });

    test('isSameOrAfter', () {
      final date1 = DateTime(2025, 3, 11);
      final date2 = DateTime(2025, 3, 10);
      expect(date1.isSameOrAfter(date2), isTrue);
    });

    test('isBetween', () {
      final date = DateTime(2025, 3, 10);
      final start = DateTime(2025, 3, 9);
      final end = DateTime(2025, 3, 11);
      expect(date.isBetween(start, end), isTrue);
    });
  });

  group('DateTimeFormatExtensions', () {
    test('format should return ISO8601 string when no pattern is provided', () {
      // Given
      final date = DateTime(2025, 3, 10, 15, 30);

      // When
      final formatted = date.format();

      // Then
      expect(formatted, '2025-03-10T15:30:00.000');
    });

    test('format should return formatted date based on provided pattern', () {
      // Given
      final date = DateTime(2025, 3, 10, 15, 30);
      const pattern = 'yyyy/MM/dd HH:mm';

      // When
      final formatted = date.format(pattern: pattern);

      // Then
      expect(formatted, '2025/03/10 15:30');
    });

    test('formatRelative should return relative time', () {
      // Given
      final now = DateTime.now();
      final past = DateTime.now().subMinutes(5);

      // When
      final formatted = past.formatRelative(clock: now);

      // Then
      expect(formatted, '5 minutes ago');
    });

    test('formatFrom should return relative time from specified clock', () {
      // Given
      final clock = DateTime.now().addDays(5);
      final past = DateTime.now();

      // When
      final formatted = past.formatFrom(clock: clock);

      // Then
      expect(formatted, '5 days ago');
    });

    test('formatFromNow should return relative time from the current time', () {
      // Given
      final past = DateTime.now().subYears(2);

      // When
      final formatted = past.formatFromNow();

      // Then
      expect(formatted, '2 years ago');
    });

    test('formatTo should return relative time to specified clock', () {
      // Given
      final now = DateTime.now().addDays(2);
      final past = DateTime.now().subDays(2);

      // When
      final formatted = past.formatTo(clock: now);

      // Then
      expect(formatted, 'in 4 days');
    });

    test('formatToNow should return relative time to current time', () {
      // Given
      final past = DateTime.now().subMonths(5);

      // When
      final formatted = past.formatToNow();

      // Then
      expect(formatted, 'in 5 months');
    });

    test('formatRelative should return relative time without prefix and suffix',
        () {
      // Given
      final now = DateTime.now();
      final past = DateTime.now().subMinutes(2);

      // When
      final formatted =
          past.formatRelative(clock: now, withPrefixAndSuffix: false);

      // Then
      expect(formatted, '2 minutes');
    });

    test('formatRelative should return short relative time', () {
      // Given
      final now = DateTime.now();
      final past = DateTime.now().subDays(6);

      // When
      final formatted = past.formatRelative(clock: now, short: true);

      // Then
      expect(formatted, '6d');
    });

    test('formatRelative should return relative time in a different locale',
        () {
      // Given
      final now = DateTime.now().addDays(2);
      final past = DateTime.now().subDays(1);

      // When
      final formatted = past.formatRelative(clock: now, locale: 'vi');

      // Then
      expect(formatted, '3 ngày trước');
    });

    test('formatOrdinalNumber should return the correct ordinal for a day', () {
      // Given
      final date = DateTime(2025, 3, 10);
      final date2 = DateTime(2025, 3, 11);
      final date3 = DateTime(2025, 3, 21);
      final date4 = DateTime(2025, 3, 22);
      final date5 = DateTime(2025, 3, 23);

      // When
      final formatted = date.formatOrdinalNumber();
      final formatted2 = date2.formatOrdinalNumber();
      final formatted3 = date3.formatOrdinalNumber();
      final formatted4 = date4.formatOrdinalNumber();
      final formatted5 = date5.formatOrdinalNumber();

      // Then
      expect(formatted, '10th');
      expect(formatted2, '11th');
      expect(formatted3, '21st');
      expect(formatted4, '22nd');
      expect(formatted5, '23rd');
    });
  });

  group('DateTimeTimeSpanExtensions', () {
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 1));
    final end = now.add(const Duration(days: 1));
    final timeSpan = TimeSpan(start, end);

    test('isWithin', () {
      expect(now.isWithin(start, end), isTrue);
      expect(start.isWithin(start, end), isTrue);
      expect(end.isWithin(start, end), isTrue);
      expect(
        now.subtract(const Duration(days: 2)).isWithin(start, end),
        isFalse,
      );
      expect(
        now.add(const Duration(days: 2)).isWithin(start, end),
        isFalse,
      );
    });

    test('isWithinTimeSpan', () {
      expect(now.isWithinTimeSpan(timeSpan), isTrue);
      expect(start.isWithinTimeSpan(timeSpan), isTrue);
      expect(end.isWithinTimeSpan(timeSpan), isTrue);
      expect(
        now.subtract(const Duration(days: 2)).isWithinTimeSpan(timeSpan),
        isFalse,
      );
      expect(
        now.add(const Duration(days: 2)).isWithinTimeSpan(timeSpan),
        isFalse,
      );
    });
  });
}
