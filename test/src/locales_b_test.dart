import 'package:flutter_date_formatter/flutter_date_formatter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test/test.dart';

final DateTime clock = DateTime(2024, 6, 15, 12);

const Duration seconds10 = Duration(seconds: 10);
const Duration seconds60 = Duration(seconds: 60);
const Duration minutes3 = Duration(minutes: 3);
const Duration minutes5 = Duration(minutes: 5);
const Duration minutes11 = Duration(minutes: 11);
const Duration minutes22 = Duration(minutes: 22);
const Duration hour1 = Duration(minutes: 60);
const Duration hours3 = Duration(hours: 3);
const Duration hours5 = Duration(hours: 5);
const Duration hours21 = Duration(hours: 21);
const Duration hours22 = Duration(hours: 22);
const Duration day1 = Duration(hours: 30);
const Duration days2 = Duration(days: 2);
const Duration days5 = Duration(days: 5);
const Duration days11 = Duration(days: 11);
const Duration days21 = Duration(days: 21);
const Duration month1 = Duration(days: 40);
const Duration months3 = Duration(days: 92);
const Duration months5 = Duration(days: 152);
const Duration year1 = Duration(days: 400);
const Duration years2 = Duration(days: 365 * 2 + 3);
const Duration years5 = Duration(days: 365 * 5 + 3);
const Duration years11 = Duration(days: 365 * 11 + 3);
const Duration years21 = Duration(days: 365 * 21 + 6);
const Duration years22 = Duration(days: 365 * 22 + 6);

String past(
  String locale,
  Duration d, {
  bool short = false,
  bool withPrefixAndSuffix = true,
}) =>
    FlutterDateFormatter.formatRelativeDateTime(
      clock.subtract(d),
      locale: locale,
      clock: clock,
      short: short,
      withPrefixAndSuffix: withPrefixAndSuffix,
    );

String future(
  String locale,
  Duration d, {
  bool short = false,
  bool withPrefixAndSuffix = true,
}) =>
    FlutterDateFormatter.formatRelativeDateTime(
      clock.add(d),
      locale: locale,
      clock: clock,
      short: short,
      withPrefixAndSuffix: withPrefixAndSuffix,
    );

/// Generic sanity checks that apply to every locale in this file.
void expectClean(String value) {
  expect(value, isNot(contains('  ')), reason: 'double space in "$value"');
  expect(value, equals(value.trim()), reason: 'untrimmed "$value"');
  expect(value, isNot(contains('​')), reason: 'ZWSP in "$value"');
}

const List<Duration> allDurations = [
  seconds10,
  seconds60,
  minutes5,
  minutes22,
  hour1,
  hours5,
  day1,
  days5,
  month1,
  months5,
  year1,
  years11,
];

void main() {
  setUp(() async {
    await initializeDateFormatting();
  });

  group('no double spaces / untrimmed output', () {
    for (final locale in [
      'ko',
      'ku',
      'lv',
      'mn',
      'my',
      'nl',
      'pl',
      'ps',
      'ro',
      'rw',
      'sr',
      'sv',
      'th',
      'ur',
      'zh',
      'zh_CN',
    ]) {
      test(locale, () {
        for (final d in allDurations) {
          for (final short in [false, true]) {
            expectClean(past(locale, d, short: short));
            expectClean(future(locale, d, short: short));
            expectClean(
              past(locale, d, short: short, withPrefixAndSuffix: false),
            );
          }
        }
      });
    }
  });

  group('Myanmar (my)', () {
    test('past', () {
      expect(past('my', minutes11), 'လွန်ခဲ့သော ၁၁ မိနစ် က');
      expect(past('my', minutes5), 'လွန်ခဲ့သော ၅ မိနစ် က');
      expect(past('my', seconds10), 'လွန်ခဲ့သော စက္ကန့်အနည်းငယ် က');
      expect(past('my', years2), 'လွန်ခဲ့သော ၂ နှစ် က');
    });

    test('future has no past marker and no double space', () {
      expect(future('my', minutes11), 'လာမည့် ၁၁ မိနစ် မှာ');
      expect(future('my', minutes5), 'လာမည့် ၅ မိနစ် မှာ');
      expect(future('my', seconds10), 'လာမည့် စက္ကန့်အနည်းငယ် မှာ');
      expect(future('my', hour1), 'လာမည့် ၁ နာရီခန့် မှာ');
      for (final d in allDurations) {
        expect(future('my', d), isNot(contains('လွန်ခဲ့သော')));
      }
    });

    test('withPrefixAndSuffix: false is neutral', () {
      expect(past('my', minutes11, withPrefixAndSuffix: false), '၁၁ မိနစ်');
      expect(future('my', days5, withPrefixAndSuffix: false), '၅ ရက်');
    });

    test('ordinal keeps the full number', () {
      expect(FlutterDateFormatter.ordinal(1, locale: 'my'), '၁.');
      expect(FlutterDateFormatter.ordinal(1500, locale: 'my'), '၁၅၀၀.');
    });
  });

  group('Pashto (ps)', () {
    test('aboutAMonth has no trailing space', () {
      expect(past('ps', month1), 'شاوخوا یوه میاشت مخکې');
      expect(future('ps', month1), 'په شاوخوا یوې میاشتې کې');
      expect(
        past('ps', month1, withPrefixAndSuffix: false),
        'شاوخوا یوه میاشت',
      );
    });

    test('aboutAMinute has no zero-width spaces', () {
      expect(past('ps', seconds60), 'یوه دقیقه مخکې');
    });

    test('ordinal', () {
      expect(FlutterDateFormatter.ordinal(1, locale: 'ps'), '۱م');
      expect(FlutterDateFormatter.ordinal(1500, locale: 'ps'), '۱۵۰۰م');
    });
  });

  group('Serbian (sr)', () {
    test('aboutAMinute does not repeat the preposition', () {
      expect(past('sr', seconds60), 'пре минут');
      expect(future('sr', seconds60), 'за минут');
      expect(past('sr', seconds60, withPrefixAndSuffix: false), 'минут');
    });

    test('about-forms use words instead of ~1', () {
      expect(past('sr', hour1), 'пре сат');
      expect(future('sr', day1), 'за дан');
      expect(past('sr', month1), 'пре месец');
      expect(future('sr', year1), 'за годину');
    });

    test('plural forms (one / few / other)', () {
      expect(past('sr', hours21), 'пре 21 сат');
      expect(future('sr', hours22), 'за 22 сата');
      expect(past('sr', hours3), 'пре 3 сата');
      expect(future('sr', hours5), 'за 5 сати');
      expect(past('sr', days21), 'пре 21 дан');
      expect(future('sr', days11), 'за 11 дана');
      expect(past('sr', months3), 'пре 3 месеца');
      expect(future('sr', months5), 'за 5 месеци');
      expect(past('sr', years2), 'пре 2 године');
      expect(future('sr', years5), 'за 5 година');
      expect(past('sr', years11), 'пре 11 година');
      expect(future('sr', years21), 'за 21 годину');
      expect(past('sr', years22), 'пре 22 године');
    });
  });

  group('Latvian (lv)', () {
    test('11 uses the plural form', () {
      expect(past('lv', minutes11), 'pirms 11 minūtēm');
      expect(future('lv', minutes11), 'pēc 11 minūtēm');
      expect(past('lv', days11), 'pirms 11 dienām');
      expect(past('lv', years11), 'pirms 11 gadiem');
      expect(future('lv', years11), 'pēc 11 gadiem');
    });

    test('21 still uses the singular form', () {
      expect(past('lv', hours21), 'pirms 21 stundas');
      expect(future('lv', days21), 'pēc 21 dienas');
      expect(past('lv', years21), 'pirms 21 gada');
      expect(past('lv', years22), 'pirms 22 gadiem');
    });
  });

  group('Swedish (sv)', () {
    test('ordinal number', () {
      expect(FlutterDateFormatter.ordinal(1, locale: 'sv'), '1:a');
      expect(FlutterDateFormatter.ordinal(2, locale: 'sv'), '2:a');
      expect(FlutterDateFormatter.ordinal(3, locale: 'sv'), '3:e');
      expect(FlutterDateFormatter.ordinal(11, locale: 'sv'), '11:e');
      expect(FlutterDateFormatter.ordinal(12, locale: 'sv'), '12:e');
      expect(FlutterDateFormatter.ordinal(21, locale: 'sv'), '21:a');
      expect(FlutterDateFormatter.ordinal(22, locale: 'sv'), '22:a');
      expect(FlutterDateFormatter.ordinal(111, locale: 'sv'), '111:e');
      expect(FlutterDateFormatter.ordinal(112, locale: 'sv'), '112:e');
    });

    test('do pattern', () {
      expect(
        FlutterDateFormatter('do', 'sv').format(DateTime(2024, 6, 11)),
        '11e',
      );
      expect(
        FlutterDateFormatter('do', 'sv').format(DateTime(2024, 6, 12)),
        '12e',
      );
      expect(
        FlutterDateFormatter('do', 'sv').format(DateTime(2024, 6, 21)),
        '21a',
      );
    });
  });

  group('Kinyarwanda (rw)', () {
    test('years has a space', () {
      expect(past('rw', years11), 'hashize imyaka 11');
      expect(future('rw', years11), 'mu imyaka 11');
      expect(past('rw', years11, withPrefixAndSuffix: false), 'imyaka 11');
    });
  });

  group('Norwegian Nynorsk (nn)', () {
    test('past and future', () {
      expect(past('nn', hours5), '5 timar sidan');
      expect(future('nn', hours5), 'om 5 timar');
      expect(future('nn', days5), 'om 5 dagar');
    });
  });

  group('Amharic (am)', () {
    test('past and future', () {
      expect(past('am', minutes5), '5 ደቂቃዎች በፊት');
      expect(future('am', minutes5), 'በ5 ደቂቃዎች ውስጥ');
      expect(future('am', day1), 'በአንድ ቀን ውስጥ');
      expect(past('am', hour1), 'አንድ ሰዓት ገደማ በፊት');
      expect(future('am', seconds10), 'በአንድ አፍታ ውስጥ');
      expect(future('am', days5, withPrefixAndSuffix: false), '5 ቀናት');
    });
  });

  group('Kurdish (ku)', () {
    test('past', () {
      expect(past('ku', minutes5), '5 خولەک لەمەوپێش');
      expect(past('ku', seconds10), 'چەند چرکەیەک لەمەوپێش');
      expect(past('ku', hours3), '3 کاژێر لەمەوپێش');
      expect(past('ku', years11), '11 ساڵ لەمەوپێش');
    });

    test('future does not contain "ago"', () {
      expect(future('ku', minutes5), 'پاش 5 خولەک');
      expect(future('ku', seconds10), 'پاش چەند چرکەیەک');
      expect(future('ku', day1), 'پاش ڕۆژێک');
      for (final d in allDurations) {
        expect(future('ku', d), isNot(contains('لەمەوپێش')));
        expect(future('ku', d, short: true), isNot(contains('لەمەوپێش')));
      }
    });

    test('withPrefixAndSuffix: false is neutral', () {
      expect(past('ku', minutes5, withPrefixAndSuffix: false), '5 خولەک');
      expect(future('ku', year1, withPrefixAndSuffix: false), 'ساڵێک');
    });

    test('short form does not say "now from now"', () {
      expect(future('ku', seconds10, short: true), 'ئێستا');
      expect(future('ku', minutes5, short: true), '5 خولەک');
    });
  });

  group('Thai (th)', () {
    test('less than a minute is a duration', () {
      expect(past('th', seconds10), 'เมื่อ ไม่กี่วินาที ที่แล้ว');
      expect(future('th', seconds10), 'ในอีก ไม่กี่วินาที');
      expect(past('th', seconds10, withPrefixAndSuffix: false), 'ไม่กี่วินาที');
    });

    test('future uses ในอีก without a redundant suffix', () {
      expect(future('th', minutes5), 'ในอีก 5 นาที');
      expect(past('th', minutes5), 'เมื่อ 5 นาที ที่แล้ว');
      expect(future('th', years2), 'ในอีก 2 ปี');
      for (final d in allDurations) {
        expect(future('th', d), isNot(contains('จากนี้')));
        expect(future('th', d), isNot(contains('เมื่อ')));
      }
    });
  });

  group('Korean (ko)', () {
    test('less than a minute is a duration', () {
      expect(past('ko', seconds10), '몇 초 전');
      expect(future('ko', seconds10), '몇 초 후');
    });

    test('future has no redundant prefix', () {
      expect(future('ko', minutes5), '5분 후');
      expect(past('ko', minutes5), '5분 전');
      expect(future('ko', day1), '하루 후');
    });
  });

  group('Chinese (zh, zh_CN)', () {
    test('zh_CN short form is Simplified', () {
      expect(past('zh_CN', minutes5, short: true), '5 分钟前');
      expect(past('zh_CN', hours3, short: true), '3 小时前');
      expect(past('zh_CN', months3, short: true), '3 个月前');
      expect(past('zh_CN', seconds10, short: true), '几秒前');
    });

    test('zh_CN future uses 后', () {
      expect(future('zh_CN', years11), '11 年后');
      expect(future('zh_CN', minutes5), '5 分钟后');
      expect(future('zh_CN', minutes5, short: true), '5 分钟后');
      expect(past('zh_CN', years11), '11 年前');
    });

    test('zh is Simplified (matches intl zh date data) and uses 后', () {
      expect(future('zh', years11), '11 年后');
      expect(past('zh', seconds10), '几秒前');
      expect(past('zh', minutes5), '5 分钟前');
      expect(future('zh', hours3), '3 小时后');
      expect(past('zh', months3), '3 个月前');
      expect(past('zh', months3, short: true), '3 个月前');
      for (final d in allDurations) {
        expect(future('zh', d), isNot(contains('内')));
      }
    });

    test('ZhTwLocale keeps Traditional Chinese', () {
      final tw = ZhTwLocale();
      expect(
        RelativeDateTimeUtils.format(clock.subtract(minutes5), clock, tw),
        '5 分鐘前',
      );
      expect(
        RelativeDateTimeUtils.format(clock.add(hours3), clock, tw),
        '3 小時後',
      );
      expect(
        RelativeDateTimeUtils.format(clock.subtract(seconds10), clock, tw),
        '幾秒前',
      );
    });
  });

  group('Polish (pl)', () {
    test('future uses "za" prefix', () {
      expect(future('pl', minutes5), 'za 5 minut');
      expect(future('pl', seconds10), 'za chwilę');
      expect(future('pl', hour1), 'za około godziny');
      expect(future('pl', days2), 'za 2 dni');
      expect(future('pl', minutes22), 'za 22 minuty');
      expect(future('pl', years2), 'za 2 lata');
      for (final d in allDurations) {
        expect(future('pl', d), isNot(contains('od tego momentu')));
      }
    });

    test('past', () {
      expect(past('pl', minutes5), '5 minut temu');
      expect(past('pl', minutes3), '3 minuty temu');
      expect(past('pl', hours21), '21 godzin temu');
      expect(past('pl', hours22), '22 godziny temu');
      expect(past('pl', years5), '5 lat temu');
      expect(past('pl', years22), '22 lata temu');
    });

    test('short form is compact', () {
      expect(past('pl', minutes5, short: true), '5 min');
      expect(past('pl', hours3, short: true), '3 godz.');
      expect(future('pl', days5, short: true), '5 d.');
      expect(past('pl', months3, short: true), '3 mies.');
      expect(past('pl', years2, short: true), '2 lata');
    });
  });

  group('Slovak (sk)', () {
    final sk = SkLocale();
    String skPast(Duration d, {bool withPrefixAndSuffix = true}) =>
        RelativeDateTimeUtils.format(
          clock.subtract(d),
          clock,
          sk,
          withPrefixAndSuffix: withPrefixAndSuffix,
        );
    String skFuture(Duration d, {bool short = false}) =>
        RelativeDateTimeUtils.format(clock.add(d), clock, sk, short: short);

    test('past uses "pred" + instrumental', () {
      expect(skPast(seconds10), 'pred chvíľou');
      expect(skPast(seconds60), 'pred minútou');
      expect(skPast(minutes3), 'pred 3 minútami');
      expect(skPast(minutes5), 'pred 5 minútami');
      expect(skPast(hour1), 'pred hodinou');
      expect(skPast(day1), 'pred dňom');
      expect(skPast(days5), 'pred 5 dňami');
      expect(skPast(month1), 'pred mesiacom');
      expect(skPast(months3), 'pred 3 mesiacmi');
      expect(skPast(year1), 'pred rokom');
      expect(skPast(years11), 'pred 11 rokmi');
    });

    test('future uses "o" + accusative without "od teraz"', () {
      expect(skFuture(seconds10), 'o chvíľu');
      expect(skFuture(seconds60), 'o minútu');
      expect(skFuture(minutes3), 'o 3 minúty');
      expect(skFuture(minutes5), 'o 5 minút');
      expect(skFuture(minutes22), 'o 22 minút');
      expect(skFuture(hour1), 'o hodinu');
      expect(skFuture(hours3), 'o 3 hodiny');
      expect(skFuture(hours5), 'o 5 hodín');
      expect(skFuture(day1), 'o deň');
      expect(skFuture(days2), 'o 2 dni');
      expect(skFuture(days5), 'o 5 dní');
      expect(skFuture(month1), 'o mesiac');
      expect(skFuture(months3), 'o 3 mesiace');
      expect(skFuture(months5), 'o 5 mesiacov');
      expect(skFuture(year1), 'o rok');
      expect(skFuture(years2), 'o 2 roky');
      expect(skFuture(years5), 'o 5 rokov');
      for (final d in allDurations) {
        expect(skFuture(d), isNot(contains('od teraz')));
        expectClean(skFuture(d));
        expectClean(skPast(d));
      }
    });

    test('short form', () {
      expect(skFuture(days5, short: true), '5 dní');
      expect(skFuture(years2, short: true), '2 roky');
    });
  });

  group('Romanian (ro)', () {
    test('"de" is inserted for numbers >= 20', () {
      expect(future('ro', minutes22), 'peste 22 de minute');
      expect(past('ro', minutes22), 'acum 22 de minute');
      expect(past('ro', hours21), 'acum 21 de ore');
      expect(future('ro', days21), 'peste 21 de zile');
      expect(past('ro', years21), 'acum 21 de ani');
    });

    test('no "de" below 20', () {
      expect(past('ro', minutes11), 'acum 11 minute');
      expect(future('ro', hours5), 'peste 5 ore');
      expect(past('ro', years11), 'acum 11 ani');
    });

    test('diacritics and singular forms', () {
      expect(past('ro', month1), 'acum o lună');
      expect(future('ro', month1), 'peste o lună');
      expect(past('ro', month1, short: true), '~1 lună');
      expect(past('ro', year1, short: true), '~1 an');
      expect(past('ro', hours22, short: true), '22 de ore');
      expect(past('ro', minutes22, short: true), '22 min');
    });
  });

  group('Dutch (nl)', () {
    test('years use "jaar" after a numeral', () {
      expect(past('nl', years11), '11 jaar geleden');
      expect(future('nl', years5), 'over 5 jaar');
    });
  });

  group('ordinals without English "th"', () {
    test('Mongolian', () {
      expect(FlutterDateFormatter.ordinal(1, locale: 'mn'), '1-р');
      expect(FlutterDateFormatter.ordinal(21, locale: 'mn'), '21-р');
    });

    test('Urdu', () {
      expect(FlutterDateFormatter.ordinal(1, locale: 'ur'), 'پہلا');
      expect(FlutterDateFormatter.ordinal(2, locale: 'ur'), 'دوسرا');
      expect(FlutterDateFormatter.ordinal(3, locale: 'ur'), 'تیسرا');
      expect(FlutterDateFormatter.ordinal(4, locale: 'ur'), 'چوتھا');
      expect(FlutterDateFormatter.ordinal(5, locale: 'ur'), '5واں');
      expect(FlutterDateFormatter.ordinal(6, locale: 'ur'), 'چھٹا');
      expect(FlutterDateFormatter.ordinal(21, locale: 'ur'), '21واں');
    });

    test('no locale in this group returns an English suffix', () {
      for (final locale in ['mn', 'ur', 'ps', 'my']) {
        for (final n in [1, 2, 3, 11, 21, 1500]) {
          expect(
            FlutterDateFormatter.ordinal(n, locale: locale),
            isNot(endsWith('th')),
          );
        }
      }
    });
  });
}
