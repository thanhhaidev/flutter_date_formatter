import 'package:flutter_date_formatter/flutter_date_formatter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test/test.dart';

final DateTime fixedClock = DateTime(2024, 6, 15, 12);

const Duration seconds10 = Duration(seconds: 10);
const Duration seconds60 = Duration(seconds: 60);
const Duration minutes5 = Duration(minutes: 5);
const Duration hour1 = Duration(minutes: 60);
const Duration hours5 = Duration(hours: 5);
const Duration day1 = Duration(hours: 30);
const Duration days5 = Duration(days: 5);
const Duration month1 = Duration(days: 40);
const Duration months3 = Duration(days: 92);
const Duration months5 = Duration(days: 152);
const Duration year1 = Duration(days: 400);
const Duration years5 = Duration(days: 365 * 5 + 3);

const List<Duration> allDurations = [
  seconds10,
  seconds60,
  minutes5,
  hour1,
  hours5,
  day1,
  days5,
  month1,
  months5,
  year1,
  years5,
];

String past(String locale, Duration d, {bool short = false}) =>
    FlutterDateFormatter.formatRelativeDateTime(
      fixedClock.subtract(d),
      locale: locale,
      clock: fixedClock,
      short: short,
    );

String future(String locale, Duration d, {bool short = false}) =>
    FlutterDateFormatter.formatRelativeDateTime(
      fixedClock.add(d),
      locale: locale,
      clock: fixedClock,
      short: short,
    );

/// No double spaces, no leading/trailing whitespace, no invisible marks.
void expectClean(String value) {
  expect(value, isNot(contains('  ')), reason: 'double space in "$value"');
  expect(value, equals(value.trim()), reason: 'untrimmed "$value"');
  for (final mark in ['​', '‌', '‍', '‎', '‏']) {
    expect(value, isNot(contains(mark)), reason: 'invisible mark in "$value"');
  }
}

void main() {
  setUp(() async => initializeDateFormatting());

  group('Urdu (ur)', () {
    test('months uses the plural مہینے', () {
      expect(past('ur', months3), '۳ مہینے پہلے');
      expect(past('ur', months5), '۵ مہینے پہلے');
      expect(future('ur', months5), '۵ مہینے بعد');
      // A number is never followed by the singular مہینہ.
      final numberThenSingular = RegExp('[۰-۹]+ مہینہ');
      for (final d in allDurations) {
        expect(past('ur', d), isNot(matches(numberThenSingular)));
        expect(future('ur', d), isNot(matches(numberThenSingular)));
      }
    });

    test('other plural units', () {
      expect(past('ur', hours5), '۵ گھنٹے پہلے');
      expect(past('ur', days5), '۵ دن پہلے');
      expect(past('ur', minutes5), '۵ منٹ پہلے');
      expect(past('ur', years5), '۵ برس پہلے');
      expect(past('ur', month1), 'ایک مہینہ پہلے');
    });

    test('short form uses Urdu (extended Arabic-Indic) digits', () {
      expect(past('ur', months5, short: true), '۵ ماہ');
      expect(future('ur', months5, short: true), '۵ ماہ');
      expect(past('ur', seconds60, short: true), '۱ منٹ');
      expect(past('ur', hour1, short: true), '~۱ گھ');
      expect(future('ur', year1, short: true), '~۱ س');
      for (final d in allDurations) {
        // U+0661 is the Arabic (not Urdu) digit one.
        expect(past('ur', d, short: true), isNot(contains('١')));
      }
    });
  });

  group('Pashto (ps)', () {
    test('past keeps "<unit> مخکې"', () {
      expect(past('ps', seconds10), 'یوه شیبه مخکې');
      expect(past('ps', seconds60), 'یوه دقیقه مخکې');
      expect(past('ps', minutes5), '۵ دقیقې مخکې');
      expect(past('ps', hours5), '۵ ساعته مخکې');
      expect(past('ps', day1), 'یوه ورځ مخکې');
      expect(past('ps', days5), '۵ ورځې مخکې');
      expect(past('ps', month1), 'شاوخوا یوه میاشت مخکې');
      expect(past('ps', months5), '۵ میاشتې مخکې');
      expect(past('ps', years5), '۵ کاله مخکې');
    });

    test('future is "په <oblique unit> کې"', () {
      expect(future('ps', seconds10), 'په یوې شیبې کې');
      expect(future('ps', seconds60), 'په یوې دقیقې کې');
      expect(future('ps', minutes5), 'په ۵ دقیقو کې');
      expect(future('ps', hour1), 'په شاوخوا یو ساعت کې');
      expect(future('ps', hours5), 'په ۵ ساعتونو کې');
      expect(future('ps', day1), 'په یوې ورځې کې');
      expect(future('ps', days5), 'په ۵ ورځو کې');
      expect(future('ps', month1), 'په شاوخوا یوې میاشتې کې');
      expect(future('ps', months5), 'په ۵ میاشتو کې');
      expect(future('ps', year1), 'په شاوخوا یو کال کې');
      expect(future('ps', years5), 'په ۵ کلونو کې');
    });

    test('short form follows the same rules', () {
      expect(past('ps', minutes5, short: true), '۵ دقیقې مخکې');
      expect(future('ps', minutes5, short: true), 'په ۵ دقیقو کې');
    });

    test('no literal "from now" and clean output', () {
      for (final d in allDurations) {
        for (final short in [false, true]) {
          final f = future('ps', d, short: short);
          expect(f, isNot(contains('له اوس څخه')));
          expectClean(f);
          expectClean(past('ps', d, short: short));
        }
      }
    });
  });

  group('Norwegian Bokmål (nb)', () {
    test('future is "om <unit>" with no "fra nå"', () {
      expect(future('nb', minutes5), 'om 5 minutter');
      expect(future('nb', hours5), 'om 5 timer');
      expect(future('nb', days5), 'om 5 dager');
      expect(future('nb', seconds10), 'om ett øyeblikk');
      for (final d in allDurations) {
        expect(future('nb', d), isNot(contains('fra nå')));
        expect(future('nb', d), startsWith('om '));
      }
    });

    test('past is "<unit> siden"', () {
      expect(past('nb', minutes5), '5 minutter siden');
      expect(past('nb', hours5), '5 timer siden');
      expect(past('nb', months5), '5 måneder siden');
      expect(past('nb', years5), '5 år siden');
    });

    test('short form is neutral in both directions', () {
      expect(past('nb', minutes5, short: true), '5 min');
      expect(future('nb', minutes5, short: true), '5 min');
      expect(past('nb', seconds10, short: true), 'nå');
      expect(future('nb', seconds10, short: true), 'nå');
      for (final d in allDurations) {
        expect(future('nb', d, short: true), isNot(contains('siden')));
        expect(future('nb', d, short: true), isNot(contains('fra nå')));
      }
    });
  });

  group('Myanmar (my)', () {
    test('long form keeps direction markers', () {
      expect(past('my', minutes5), 'လွန်ခဲ့သော ၅ မိနစ် က');
      expect(future('my', minutes5), 'လာမည့် ၅ မိနစ် မှာ');
      expect(past('my', seconds10), 'လွန်ခဲ့သော စက္ကန့်အနည်းငယ် က');
      expect(future('my', seconds10), 'လာမည့် စက္ကန့်အနည်းငယ် မှာ');
    });

    test('short lessThanOneMinute is neutral "now"', () {
      expect(past('my', seconds10, short: true), 'ယခု');
      expect(future('my', seconds10, short: true), 'ယခု');
    });

    test('short form never says "a while ago" for the future', () {
      for (final d in allDurations) {
        expect(future('my', d, short: true), isNot(contains('စောနက')));
        expect(future('my', d, short: true), isNot(contains('လွန်ခဲ့')));
      }
      expect(past('my', minutes5, short: true), '၅မိနစ်');
      expect(future('my', minutes5, short: true), '၅မိနစ်');
    });
  });
}
