import 'package:flutter_date_formatter/flutter_date_formatter.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';

/// Returns the local midnight right before a daylight saving time change in
/// [year], or `null` if the local time zone has no DST.
DateTime? _dayBeforeDstChange(int year) {
  for (var day = DateTime(year); day.year == year; day = day.addDays(1)) {
    if (day.timeZoneOffset != day.addDays(1).timeZoneOffset) return day;
  }
  return null;
}

void main() {
  final dstDay = _dayBeforeDstChange(2025);
  final noDst = dstDay == null ? 'local time zone has no DST' : null;

  setUp(() => Intl.defaultLocale = 'en_US');
  tearDown(() => Intl.defaultLocale = null);

  group('FlutterDateFormatter', () {
    test('an instance can format more than once', () {
      final formatter = FlutterDateFormatter('do MMMM yyyy', 'en');
      expect(formatter.format(DateTime(2025, 3)), '1st March 2025');
      expect(formatter.format(DateTime(2025, 3, 2)), '2nd March 2025');
    });

    test('throws a FormatException for a blank pattern', () {
      expect(
        () => FlutterDateFormatter('  ').format(DateTime(2025)),
        throwsFormatException,
      );
      expect(
        () => FlutterDateFormatter().format(DateTime(2025)),
        throwsFormatException,
      );
    });

    test('keeps the requested region for intl', () {
      final date = DateTime(2025, 3, 4);
      expect(date.format(pattern: 'yMd', locale: 'en_US'), '3/4/2025');
      expect(date.format(pattern: 'yMd', locale: 'en_GB'), '04/03/2025');
      expect(date.format(pattern: 'yMd', locale: 'en-GB'), '04/03/2025');
    });

    test('resolves the Greek code el and the legacy gr', () {
      final date = DateTime(2025, 3, 4);
      expect(date.format(pattern: 'MMMM', locale: 'el'), 'Μαρτίου');
      expect(date.format(pattern: 'MMMM', locale: 'gr'), 'Μαρτίου');
    });

    test('supports intl quotes and brackets for literal text', () {
      final date = DateTime(2025, 10, 7, 9, 35);
      String f(String pattern, [String locale = 'en']) =>
          date.format(pattern: pattern, locale: locale);
      expect(f("dd/MM/yyyy 'at' HH:mm"), '07/10/2025 at 09:35');
      expect(f("dd/MM/yyyy 'at' HH:mm", 'vi'), '07/10/2025 at 09:35');
      expect(f('dd/MM/yyyy [at] HH:mm'), '07/10/2025 at 09:35');
      expect(f("h 'o''clock' a"), "9 o'clock AM");
      expect(f("[It's] EEEE"), "It's Tuesday");
      expect(f("''yy"), "'25");
      expect(f("'do' do"), 'do 7th');
      expect(f('[do] do'), 'do 7th');
      expect(f("yyyy 'unclosed"), '2025 unclosed');
    });

    test('do inside an unclosed literal stays literal', () {
      expect(
        DateTime(2025, 3).format(pattern: 'yyyy [do', locale: 'en'),
        '2025 do',
      );
    });

    test('Turkmen ordinals follow vowel harmony', () {
      String tk(int n) => FlutterDateFormatter.ordinal(n, locale: 'tk');
      expect(tk(1), '1-nji');
      expect(tk(6), '6-njy');
      expect(tk(9), '9-njy');
      expect(tk(10), '10-njy');
      expect(tk(20), '20-nji');
      expect(tk(26), '26-njy');
      expect(tk(100), '100-nji');
    });

    test('ordinal works for relative-only locales', () {
      expect(FlutterDateFormatter.ordinal(1, locale: 'fr'), '1er');
      expect(
        FlutterDateFormatter.ordinal(1, locale: 'dv'),
        DvLocale().ordinalNumber(1),
      );
    });
  });

  group('SupportedLocalesUtils', () {
    test('resolves case-insensitive and BCP-47 tags', () {
      expect(SupportedLocalesUtils.getLocale('zh-cn'), isA<ZhCnLocale>());
      expect(SupportedLocalesUtils.getLocale('ZH_CN'), isA<ZhCnLocale>());
      expect(SupportedLocalesUtils.getLocale('ms_my'), isA<MsMyLocale>());
      expect(SupportedLocalesUtils.getLocale('vi-VN'), isA<ViLocale>());
      expect(SupportedLocalesUtils.getLocale('xx'), isA<EnLocale>());
    });

    test('uses the full Intl.defaultLocale tag', () {
      Intl.defaultLocale = 'zh_CN';
      expect(SupportedLocalesUtils.getLocale(null), isA<ZhCnLocale>());
      Intl.defaultLocale = 'tl_PH';
      expect(SupportedLocalesUtils.getLocale(null), isA<TlPhLocale>());
      expect(SupportedLocalesUtils.getRelativeLocale(null), isA<TlPhLocale>());
    });

    test('registers ms, sk and el, and drops the mn_MY typo', () {
      expect(SupportedLocalesUtils.getLocale('ms'), isA<MsMyLocale>());
      expect(SupportedLocalesUtils.getLocale('sk'), isA<SkLocale>());
      expect(SupportedLocalesUtils.getLocale('el'), isA<GrLocale>());
      expect(
        SupportedLocalesUtils.getSupportedLocales(),
        isNot(contains('mn_MY')),
      );
    });

    test('isLocaleSupported accepts region-qualified keys', () {
      expect(SupportedLocalesUtils.isLocaleSupported('zh_CN'), isTrue);
      expect(SupportedLocalesUtils.isLocaleSupported('ms_MY'), isTrue);
      expect(SupportedLocalesUtils.isLocaleSupported('de_DE'), isTrue);
      expect(SupportedLocalesUtils.isLocaleSupported('xx'), isFalse);
    });

    test('registerLocale also affects relative formatting', () {
      final date = DateTime(2025, 3, 10);
      // Warm up the relative lookup before registering.
      date.subDays(3).formatRelative(locale: 'xx_TEST', clock: date);
      SupportedLocalesUtils.registerLocale('xx_TEST', FrLocale());
      expect(
        date.subDays(3).formatRelative(locale: 'xx_TEST', clock: date),
        FlutterDateFormatter.formatRelativeDateTime(
          date.subDays(3),
          locale: 'fr',
          clock: date,
        ),
      );
    });
  });

  group('relative formatting', () {
    final clock = DateTime(2025, 3, 10, 12);

    test('equal dates are formatted as past', () {
      expect(clock.formatRelative(clock: clock), endsWith('ago'));
    });

    test('values just below a threshold use the next bucket', () {
      String rel(Duration d) =>
          clock.subtract(d).formatRelative(clock: clock, locale: 'en');
      expect(rel(const Duration(minutes: 44, seconds: 40)), 'an hour ago');
      expect(rel(const Duration(hours: 23, minutes: 40)), 'a day ago');
      expect(rel(const Duration(days: 29, hours: 14)), 'a month ago');
      expect(rel(const Duration(days: 355)), 'a year ago');
    });
  });

  group('DateTime extensions', () {
    test('week APIs work for region-qualified default locales', () {
      final date = DateTime(2025, 3, 12); // Wednesday
      for (final locale in ['de_DE', 'vi_VN', 'en-US', 'C', 'xx']) {
        Intl.defaultLocale = locale;
        expect(
          date.startOfWeek.weekday,
          anyOf(DateTime.monday, DateTime.sunday),
        );
        expect(date.dayOfWeek, inInclusiveRange(1, 7));
      }
      Intl.defaultLocale = 'de_DE';
      expect(date.startOfWeek, DateTime(2025, 3, 10));
    });

    test('weekOfYear follows ISO-8601 at year boundaries', () {
      expect(DateTime(2021).weekOfYear, 53); // Friday, week of 2020
      expect(DateTime(2024, 12, 30).weekOfYear, 1); // Monday, week 1 of 2025
      expect(DateTime(2025, 3, 15).weekOfYear, 11); // Saturday
      expect(DateTime(2026, 12, 31).weekOfYear, 53);
    });

    test('startOfQuarter and endOfQuarter do not overflow', () {
      expect(DateTime(2025, 5, 31).startOfQuarter, DateTime(2025, 4));
      expect(DateTime(2025, 8, 31).startOfQuarter, DateTime(2025, 7));
      expect(
        DateTime(2025, 7, 31).endOfQuarter,
        DateTime(2025, 9, 30, 23, 59, 59, 999, 999),
      );
    });

    test('clone keeps microseconds', () {
      final date = DateTime(2025, 1, 1, 0, 0, 0, 1, 2);
      expect(date.clone(), date);
      expect(date.clone().microsecond, 2);
    });

    test('monthDiff of equal dates is not negative zero', () {
      final date = DateTime(2025, 3, 10);
      expect(
        date.diff(date, unit: Unit.month, asFloat: true).isNegative,
        isFalse,
      );
    });

    test('indexOfClosestDay compares at microsecond resolution', () {
      final base = DateTime(2025);
      final dates = [
        base.add(const Duration(microseconds: 900)),
        base.subtract(const Duration(microseconds: 100)),
      ];
      expect(base.indexOfClosestDay(dates), 1);
      expect(base.indexOfClosestDay([]), -1);
    });

    test(
      'day arithmetic keeps the wall-clock time across DST',
      () {
        final noon = dstDay!.copyWith(hour: 12);
        expect(noon.addDays(1).hour, 12);
        expect(noon.addDays(1).subDays(1), noon);
        expect(noon.addWeeks(1).hour, 12);
        expect(noon.addDays(1).diff(noon, unit: Unit.day), 1);
        expect(noon.addDays(1).startOfDay, noon.addDays(1).copyWith(hour: 0));
      },
      skip: noDst,
    );

    test(
      'startOf and endOf week land on the right day across DST',
      () {
        Intl.defaultLocale = 'de_DE';
        final day = dstDay!.addDays(3);
        expect(day.startOfWeek.hour, 0);
        expect(day.endOfWeek.hour, 23);
        expect(day.endOfWeek.weekday, DateTime.sunday);
      },
      skip: noDst,
    );
  });

  group('TimeSpan', () {
    final a = DateTime(2025);
    final b = DateTime(2025, 1, 2);
    final c = DateTime(2025, 1, 3);
    final d = DateTime(2025, 1, 4);

    test('intersects when one span contains the other', () {
      expect(TimeSpan(b, c).intersects(TimeSpan(a, d)), isTrue);
      expect(TimeSpan(a, d).intersects(TimeSpan(b, c)), isTrue);
      expect(TimeSpan(a, b).intersects(TimeSpan(c, d)), isFalse);
    });

    test('merge returns the union in every order', () {
      expect(TimeSpan(a, d).merge(TimeSpan(b, c)), TimeSpan(a, d));
      expect(TimeSpan(b, c).merge(TimeSpan(a, d)), TimeSpan(a, d));
      expect(TimeSpan(b, d).merge(TimeSpan(a, c)), TimeSpan(a, d));
      expect(() => TimeSpan(a, b).merge(TimeSpan(c, d)), throwsRangeError);
    });

    test('getDifference and getDifferences', () {
      expect(TimeSpan(a, c).getDifference(TimeSpan(b, d)), TimeSpan(a, b));
      expect(TimeSpan(b, d).getDifference(TimeSpan(a, c)), TimeSpan(c, d));
      expect(TimeSpan(b, c).getDifference(TimeSpan(a, d)), isNull);
      expect(TimeSpan(a, b).getDifference(TimeSpan(c, d)), TimeSpan(a, b));
      expect(
        TimeSpan(a, d).getDifferences(TimeSpan(b, c)),
        [TimeSpan(a, b), TimeSpan(c, d)],
      );
      expect(
        () => TimeSpan(a, d).getDifference(TimeSpan(b, c)),
        throwsRangeError,
      );
    });

    test('symmetricDifference is order independent', () {
      expect(
        TimeSpan(c, d).symmetricDifference(TimeSpan(a, b)),
        [TimeSpan(a, b), TimeSpan(c, d)],
      );
      expect(
        TimeSpan(b, d).symmetricDifference(TimeSpan(a, c)),
        [TimeSpan(a, b), TimeSpan(c, d)],
      );
    });

    test('value semantics', () {
      expect(TimeSpan(a, b), TimeSpan(a, b));
      expect({TimeSpan(a, b), TimeSpan(a, b)}, hasLength(1));
      expect(TimeSpan(a, b).toString(), contains('2025-01-01'));
    });
  });
}
