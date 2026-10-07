import 'package:flutter_date_formatter/flutter_date_formatter.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';

/// Replaces the narrow no-break space that newer `intl` data puts before
/// AM/PM, so expectations work with every supported `intl` version.
String _normalize(String text) => text.replaceAll('\u202f', ' ');

void main() {
  // Monday, March 10, 2025, 12:00.
  final clock = DateTime(2025, 3, 10, 12);

  setUp(() => Intl.defaultLocale = 'en_US');
  tearDown(() {
    Intl.defaultLocale = null;
    DateFormatterConfig.reset();
  });

  group('DateFormatterConfig', () {
    test('clock replaces DateTime.now()', () {
      DateFormatterConfig.configure(clock: () => clock);

      expect(DateFormatterConfig.now(), clock);
      expect(DateTime(2025, 3, 10, 8).isToday, isTrue);
      expect(DateTime(2025, 3, 9).isYesterday, isTrue);
      expect(DateTime(2025, 3, 11).isTomorrow, isTrue);
      expect(DateTime(2025, 3, 11).isFuture, isTrue);
      expect(clock.subMinutes(5).formatFromNow(), '5 minutes ago');
      expect(
        _normalize(clock.subDays(1).formatCalendar()),
        'Yesterday at 12:00 PM',
      );
    });

    test('default locale is used when a call passes none', () {
      DateFormatterConfig.configure(locale: 'vi');

      expect(clock.subDays(3).formatFrom(clock: clock), '3 ngày trước');
      expect(clock.format(pattern: 'yMd'), '10/3/2025');
      expect(clock.format(pattern: 'MMMM', locale: 'en'), 'March');
    });

    test('startOfWeek overrides the locale data', () {
      final wednesday = DateTime(2025, 3, 12);
      expect(wednesday.startOfWeek, DateTime(2025, 3, 9)); // en_US: Sunday

      DateFormatterConfig.configure(startOfWeek: StartOfWeek.monday);
      expect(wednesday.startOfWeek, DateTime(2025, 3, 10));
    });

    test('configure keeps unspecified settings and reset clears them', () {
      DateFormatterConfig.configure(locale: 'vi', clock: () => clock);
      DateFormatterConfig.configure(startOfWeek: StartOfWeek.saturday);
      expect(DateFormatterConfig.locale, 'vi');
      expect(DateFormatterConfig.now(), clock);

      DateFormatterConfig.reset();
      expect(DateFormatterConfig.locale, isNull);
      expect(DateFormatterConfig.startOfWeek, isNull);
      expect(DateFormatterConfig.now(), isNot(clock));
    });
  });

  group('formatCalendar', () {
    String calendar(DateTime date, {String? locale}) =>
        _normalize(date.formatCalendar(clock: clock, locale: locale));

    test('formats each range in English', () {
      expect(calendar(DateTime(2025, 3, 10, 15)), 'Today at 3:00 PM');
      expect(calendar(DateTime(2025, 3, 10, 1)), 'Today at 1:00 AM');
      expect(calendar(DateTime(2025, 3, 11, 9)), 'Tomorrow at 9:00 AM');
      expect(calendar(DateTime(2025, 3, 9, 23, 59)), 'Yesterday at 11:59 PM');
      expect(calendar(DateTime(2025, 3, 13, 15)), 'Thursday at 3:00 PM');
      expect(calendar(DateTime(2025, 3, 5, 15)), 'Last Wednesday at 3:00 PM');
      expect(calendar(DateTime(2025, 3, 3, 15)), '3/3/2025');
      expect(calendar(DateTime(2025, 3, 17, 15)), '3/17/2025');
    });

    test('uses the locale strings and intl formats', () {
      expect(
        calendar(DateTime(2025, 3, 10, 15), locale: 'vi'),
        'Hôm nay lúc 15:00',
      );
      expect(
        calendar(DateTime(2025, 3, 5, 15), locale: 'vi'),
        'Thứ Tư tuần trước lúc 15:00',
      );
      expect(
        calendar(DateTime(2025, 3, 10, 15), locale: 'en_GB'),
        'Today at 15:00',
      );
    });

    test('falls back to English words for unknown locales', () {
      expect(
        calendar(DateTime(2025, 3, 5, 15), locale: 'xx'),
        'Last Wednesday at 3:00 PM',
      );
    });

    test('accepts custom time and date patterns', () {
      expect(
        DateTime(2025, 3, 10, 15, 30)
            .formatCalendar(clock: clock, timePattern: 'HH:mm'),
        'Today at 15:30',
      );
      expect(
        DateTime(2025, 2).formatCalendar(
          clock: clock,
          datePattern: 'do MMMM yyyy',
        ),
        '1st February 2025',
      );
    });

    test('compares calendar days, not 24-hour periods', () {
      final lateNight = DateTime(2025, 3, 10, 23, 30);
      expect(
        _normalize(
          DateTime(2025, 3, 11, 0, 30).formatCalendar(clock: lateNight),
        ),
        'Tomorrow at 12:30 AM',
      );
    });
  });

  group('formatCalendar week awareness', () {
    final friday = DateTime(2025, 3, 14, 12);
    final wednesday = DateTime(2025, 3, 12, 12);

    String calendar(DateTime date, DateTime now, String locale) => _normalize(
          date.formatCalendar(
            clock: now,
            locale: locale,
            timePattern: 'HH:mm',
          ),
        );

    test('English drops "Last" within the same week', () {
      // en_US weeks run Sunday to Saturday.
      expect(
        calendar(DateTime(2025, 3, 12, 15), friday, 'en'),
        'Wednesday at 15:00',
      );
      expect(
        calendar(DateTime(2025, 3, 8, 15), friday, 'en'),
        'Last Saturday at 15:00',
      );
    });

    test('Vietnamese says this week or last/next week', () {
      expect(
        calendar(DateTime(2025, 3, 12, 15), friday, 'vi'),
        'Thứ Tư lúc 15:00',
      );
      expect(
        calendar(DateTime(2025, 3, 9, 15), friday, 'vi'),
        'Chủ Nhật tuần trước lúc 15:00',
      );
      expect(
        calendar(DateTime(2025, 3, 17, 15), wednesday, 'vi'),
        'Thứ Hai tuần tới lúc 15:00',
      );
    });

    test('Russian picks the same-week or next/last-week form', () {
      expect(
        calendar(DateTime(2025, 3, 12, 15), friday, 'ru'),
        'В среду, в 15:00',
      );
      expect(
        calendar(DateTime(2025, 3, 9, 15), friday, 'ru'),
        'В прошлое воскресенье, в 15:00',
      );
      expect(
        calendar(DateTime(2025, 3, 15, 15), wednesday, 'ru'),
        'В субботу, в 15:00',
      );
      expect(
        calendar(DateTime(2025, 3, 17, 15), wednesday, 'ru'),
        'В следующий понедельник, в 15:00',
      );
      expect(
        calendar(DateTime(2025, 3, 11, 15), DateTime(2025, 3, 16), 'ru'),
        'Во вторник, в 15:00',
      );
    });

    test('Chinese, Japanese and Korean mark the other week', () {
      DateFormatterConfig.configure(startOfWeek: StartOfWeek.monday);
      expect(calendar(DateTime(2025, 3, 12, 15), friday, 'zh'), '本周三15:00');
      expect(calendar(DateTime(2025, 3, 8, 15), friday, 'zh'), '上周六15:00');
      expect(calendar(DateTime(2025, 3, 17, 15), wednesday, 'zh'), '下周一15:00');
      expect(calendar(DateTime(2025, 3, 12, 15), friday, 'ja'), '水曜日 15:00');
      expect(calendar(DateTime(2025, 3, 8, 15), friday, 'ja'), '先週土曜日 15:00');
      expect(
        calendar(DateTime(2025, 3, 17, 15), wednesday, 'ja'),
        '来週月曜日 15:00',
      );
      expect(calendar(DateTime(2025, 3, 12, 15), friday, 'ko'), '수요일 15:00');
      expect(calendar(DateTime(2025, 3, 8, 15), friday, 'ko'), '지난주 토요일 15:00');
      expect(
        calendar(DateTime(2025, 3, 17, 15), wednesday, 'ko'),
        '다음 주 월요일 15:00',
      );
    });

    test('German adds "Uhr" only to 24-hour times', () {
      final today = DateTime(2025, 3, 14, 15);
      expect(calendar(today, friday, 'de'), 'Heute um 15:00 Uhr');
      expect(
        _normalize(
          today.formatCalendar(
            clock: friday,
            locale: 'de',
            timePattern: 'h:mm a',
          ),
        ),
        'Heute um 3:00 PM',
      );
    });
  });

  group('Duration.humanize', () {
    const duration = Duration(days: 1, hours: 2, minutes: 5, seconds: 9);

    test('shows the two largest non-zero units by default', () {
      expect(duration.humanize(), '1 day 2 hours');
      expect(
        const Duration(hours: 2, seconds: 5).humanize(),
        '2 hours 5 seconds',
      );
      expect(const Duration(minutes: 1).humanize(), '1 minute');
      expect(Duration.zero.humanize(), '0 seconds');
      expect(const Duration(minutes: -5).humanize(), '5 minutes');
    });

    test('supports maxUnits, unit limits, short and delimiter', () {
      expect(
        duration.humanize(maxUnits: 4),
        '1 day 2 hours 5 minutes 9 seconds',
      );
      expect(duration.humanize(largestUnit: Unit.hour), '26 hours 5 minutes');
      expect(
        duration.humanize(maxUnits: 4, smallestUnit: Unit.minute),
        '1 day 2 hours 5 minutes',
      );
      expect(
        const Duration(days: 15).humanize(largestUnit: Unit.week),
        '2 weeks 1 day',
      );
      expect(duration.humanize(short: true, maxUnits: 3), '1d 2h 5m');
      expect(duration.humanize(delimiter: ', '), '1 day, 2 hours');
      expect(
        const Duration(seconds: 30).humanize(smallestUnit: Unit.minute),
        '0 minutes',
      );
    });

    test('uses the locale strings', () {
      expect(duration.humanize(locale: 'vi'), '1 ngày 2 giờ');
      expect(duration.humanize(locale: 'vi', short: true), '1n 2g');
      expect(
        const Duration(days: 7, minutes: 2, seconds: 3).humanize(
          locale: 'vi',
          short: true,
          maxUnits: 3,
          largestUnit: Unit.week,
        ),
        '1t 2ph 3s',
      );
      expect(duration.humanize(locale: 'xx'), '1 day 2 hours');
    });

    test('rejects invalid arguments', () {
      expect(() => duration.humanize(maxUnits: 0), throwsArgumentError);
      expect(
        () => duration.humanize(largestUnit: Unit.month),
        throwsArgumentError,
      );
      expect(
        () => duration.humanize(
          largestUnit: Unit.minute,
          smallestUnit: Unit.hour,
        ),
        throwsArgumentError,
      );
    });
  });

  group('parse', () {
    test('is the reverse of format', () {
      final formatter = FlutterDateFormatter('do MMMM yyyy', 'en');
      for (final day in [1, 2, 3, 4, 11, 12, 13, 21, 22, 23, 31]) {
        final date = DateTime(2025, 3, day);
        expect(formatter.parse(formatter.format(date)), date);
      }
    });

    test('supports literals, locales and utc', () {
      expect(
        FlutterDateFormatter('[Day] d, MMMM yyyy', 'en')
            .parse('Day 5, March 2025'),
        DateTime(2025, 3, 5),
      );
      expect(
        FlutterDateFormatter('d MMMM yyyy', 'fr').parse('5 mars 2025'),
        DateTime(2025, 3, 5),
      );
      expect(
        FlutterDateFormatter('yyyy-MM-dd HH:mm', 'en')
            .parse('2025-03-05 14:30', utc: true),
        DateTime.utc(2025, 3, 5, 14, 30),
      );
    });

    test('errors name the input, pattern, locale and an example', () {
      expect(
        () =>
            FlutterDateFormatter('do MMMM yyyy', 'vi').parse('21st March 2025'),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'message',
            allOf(
              contains('"21st March 2025"'),
              contains('"do MMMM yyyy"'),
              contains('"vi"'),
              contains('"21 tháng 3 2025"'),
            ),
          ),
        ),
      );
    });

    test('rejects a day with the wrong ordinal suffix', () {
      final formatter = FlutterDateFormatter('do MMMM yyyy', 'en');
      expect(() => formatter.parse('2st March 2025'), throwsFormatException);
      expect(formatter.tryParse('2st March 2025'), isNull);
    });

    test('strict errors give a short reason', () {
      expect(
        () => FlutterDateFormatter('dd/MM/yyyy', 'vi')
            .parse('30/02/2025', strict: true),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'message',
            'Could not parse "30/02/2025" with pattern "dd/MM/yyyy" in locale '
                '"vi": invalid day 30. A matching string looks like '
                '"21/03/2025".',
          ),
        ),
      );
    });

    test('strict mode rejects out-of-range values', () {
      final formatter = FlutterDateFormatter('yyyy-MM-dd', 'en');
      expect(formatter.parse('2025-02-30'), DateTime(2025, 3, 2));
      expect(
        () => formatter.parse('2025-02-30', strict: true),
        throwsFormatException,
      );
      expect(formatter.tryParse('not a date'), isNull);
    });

    test('parseAny accepts the first matching pattern', () {
      expect(
        FlutterDateFormatter.parseAny(
          '05/03/2025',
          patterns: ['yyyy-MM-dd', 'dd/MM/yyyy'],
        ),
        DateTime(2025, 3, 5),
      );
      expect(
        () => FlutterDateFormatter.parseAny('not a date', patterns: ['yyyy']),
        throwsFormatException,
      );
      expect(
        () => FlutterDateFormatter.parseAny('2025', patterns: []),
        throwsArgumentError,
      );
    });

    test('parseAnyDetailed exposes pattern diagnostics', () {
      final result = FlutterDateFormatter.parseAnyDetailed(
        '05/03/2025',
        patterns: ['yyyy-MM-dd', 'dd/MM/yyyy'],
      );
      expect(result.value, DateTime(2025, 3, 5));
      expect(result.attempts, hasLength(2));
      expect(result.attempts.first.matched, isFalse);
      expect(result.attempts.last.matched, isTrue);
    });
  });

  group('ranges and comparison', () {
    test('rangeTo steps by calendar units', () {
      expect(
        DateTime(2025, 3).rangeTo(DateTime(2025, 3, 4)).toList(),
        [
          DateTime(2025, 3),
          DateTime(2025, 3, 2),
          DateTime(2025, 3, 3),
          DateTime(2025, 3, 4),
        ],
      );
      expect(
        DateTime(2025, 1, 31)
            .rangeTo(DateTime(2025, 4, 30), unit: Unit.month)
            .toList(),
        [
          DateTime(2025, 1, 31),
          DateTime(2025, 2, 28),
          DateTime(2025, 3, 31),
          DateTime(2025, 4, 30),
        ],
      );
      expect(
        DateTime(2025, 3, 1, 9)
            .rangeTo(DateTime(2025, 3, 1, 12), unit: Unit.hour, step: 2)
            .toList(),
        [DateTime(2025, 3, 1, 9), DateTime(2025, 3, 1, 11)],
      );
      expect(DateTime(2025, 3, 2).rangeTo(DateTime(2025, 3)), isEmpty);
      expect(
        () => DateTime(2025).rangeTo(DateTime(2026), step: 0),
        throwsArgumentError,
      );
    });

    test('TimeSpan.iterate', () {
      final span = TimeSpan(DateTime(2025, 3, 3), DateTime(2025, 3, 17));
      expect(span.iterate(unit: Unit.week).toList(), [
        DateTime(2025, 3, 3),
        DateTime(2025, 3, 10),
        DateTime(2025, 3, 17),
      ]);
      expect(span.iterate().length, 15);
    });

    test('clamp, earliest and latest', () {
      final min = DateTime(2025, 3);
      final max = DateTime(2025, 3, 31);
      expect(DateTime(2025, 2, 15).clamp(min, max), min);
      expect(DateTime(2025, 4, 15).clamp(min, max), max);
      expect(DateTime(2025, 3, 15).clamp(min, max), DateTime(2025, 3, 15));
      expect(() => min.clamp(max, min), throwsArgumentError);

      final dates = [DateTime(2025, 3, 5), min, max];
      expect(dates.earliest, min);
      expect(dates.latest, max);
      expect(<DateTime>[].earliest, isNull);
    });
  });
}
