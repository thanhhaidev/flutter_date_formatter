import 'package:flutter_date_formatter/flutter_date_formatter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  setUp(() async {
    await initializeDateFormatting();
  });

  final clock = DateTime(2024, 6, 15, 12);

  String past(Duration d, String locale, {bool short = false}) =>
      FlutterDateFormatter.formatRelativeDateTime(
        clock.subtract(d),
        locale: locale,
        clock: clock,
        short: short,
      );

  String future(Duration d, String locale, {bool short = false}) =>
      FlutterDateFormatter.formatRelativeDateTime(
        clock.add(d),
        locale: locale,
        clock: clock,
        short: short,
      );

  const tenSeconds = Duration(seconds: 10);
  const oneMinute = Duration(seconds: 60);
  const twoMinutes = Duration(minutes: 2);
  const fiveMinutes = Duration(minutes: 5);
  const twentyOneMinutes = Duration(minutes: 21);
  const oneHour = Duration(minutes: 60);
  const twoHours = Duration(hours: 2);
  const fiveHours = Duration(hours: 5);
  const twentyOneHours = Duration(hours: 21);
  const oneDay = Duration(hours: 30);
  const fiveDays = Duration(days: 5);
  const twentyOneDays = Duration(days: 21);
  const oneMonth = Duration(days: 45);
  const twoMonths = Duration(days: 61);
  const oneYear = Duration(days: 400);
  const twoYears = Duration(days: 800);
  const fiveYears = Duration(days: 365 * 5 + 1);

  void expectNoDoubleSpaces(Iterable<String> values) {
    for (final value in values) {
      expect(value, isNot(contains('  ')), reason: value);
      expect(value, equals(value.trim()), reason: value);
    }
  }

  group('fr', () {
    test('ordinalNumber includes the number', () {
      expect(FlutterDateFormatter.ordinal(1, locale: 'fr'), '1er');
      expect(FlutterDateFormatter.ordinal(2, locale: 'fr'), '2e');
      expect(FlutterDateFormatter.ordinal(21, locale: 'fr'), '21e');
    });

    test('exact counts are not prefixed with "environ"', () {
      expect(past(fiveMinutes, 'fr'), 'il y a 5 minutes');
      expect(future(fiveMinutes, 'fr'), "d'ici 5 minutes");
      expect(past(fiveHours, 'fr'), 'il y a 5 heures');
      expect(past(fiveDays, 'fr'), 'il y a 5 jours');
      expect(future(fiveDays, 'fr'), "d'ici 5 jours");
      expect(past(twoMonths, 'fr'), 'il y a 2 mois');
      expect(future(twoMonths, 'fr'), "d'ici 2 mois");
    });

    test('approximate buckets keep "environ"', () {
      expect(past(oneHour, 'fr'), 'il y a environ une heure');
      expect(past(oneYear, 'fr'), 'il y a environ un an');
      expect(future(oneYear, 'fr'), "d'ici environ un an");
    });
  });

  group('hu', () {
    test('past uses a single "ezelőtt" suffix', () {
      expect(past(fiveMinutes, 'hu'), '5 perc ezelőtt');
      expect(past(tenSeconds, 'hu'), 'kevesebb, mint egy perc ezelőtt');
      expect(past(fiveDays, 'hu'), '5 nap ezelőtt');
      expect(past(twoYears, 'hu'), '2 év ezelőtt');
    });

    test('future uses a single "múlva" suffix', () {
      expect(future(fiveMinutes, 'hu'), '5 perc múlva');
      expect(future(fiveDays, 'hu'), '5 nap múlva');
      expect(future(twoYears, 'hu'), '2 év múlva');
      expect(future(oneHour, 'hu'), 'kb. 1 óra múlva');
    });

    test('short form has no affixes and correct spelling', () {
      expect(past(twoMonths, 'hu', short: true), '2 hónap');
      expect(future(twoMonths, 'hu', short: true), '2 hónap');
      expect(past(fiveMinutes, 'hu', short: true), '5 perc');
    });
  });

  group('ar', () {
    test('short years use a unit distinct from hours', () {
      expect(past(twoHours, 'ar', short: true), '2 س');
      expect(past(twoYears, 'ar', short: true), '2 سنة');
      expect(future(twoYears, 'ar', short: true), '2 سنة');
      expect(past(oneHour, 'ar', short: true), '~1 س');
      expect(past(oneYear, 'ar', short: true), '~1 سنة');
    });

    test('short aboutAMinute matches the other short units', () {
      expect(past(oneMinute, 'ar', short: true), '~1 د');
      expect(future(oneMinute, 'ar', short: true), '~1 د');
    });

    test('zero seconds never renders "0 ثانية"', () {
      final long = ArLocale().relativeDateTime();
      final short = ArLocale().shortRelativeDateTime();
      expect(long.lessThanOneMinute(0), 'لحظات');
      expect(long.lessThanOneMinute(1), 'ثانية واحدة');
      expect(short.lessThanOneMinute(0), 'الآن');
      expect(past(tenSeconds, 'ar'), 'منذ 10 ثواني');
      expect(future(tenSeconds, 'ar'), 'بعد 10 ثواني');
    });
  });

  group('ru', () {
    test('less than a minute says "a few seconds"', () {
      expect(past(tenSeconds, 'ru'), 'несколько секунд назад');
      expect(future(tenSeconds, 'ru'), 'через несколько секунд');
      expect(past(oneMinute, 'ru'), 'минуту назад');
      expect(future(oneMinute, 'ru'), 'через минуту');
    });
  });

  group('bs', () {
    test('aboutAMinute does not repeat the preposition', () {
      expect(past(oneMinute, 'bs'), 'prije minutu');
      expect(future(oneMinute, 'bs'), 'za minutu');
    });

    test('plural forms follow one / few / other', () {
      expect(past(twoHours, 'bs'), 'prije 2 sata');
      expect(future(twoHours, 'bs'), 'za 2 sata');
      expect(past(fiveHours, 'bs'), 'prije 5 sati');
      expect(past(twentyOneHours, 'bs'), 'prije 21 sat');
      expect(future(twentyOneMinutes, 'bs'), 'za 21 minutu');
      expect(past(twoMonths, 'bs'), 'prije 2 mjeseca');
      expect(past(twoYears, 'bs'), 'prije 2 godine');
      expect(future(fiveYears, 'bs'), 'za 5 godina');
      expect(past(twentyOneDays, 'bs'), 'prije 21 dan');
    });

    test('about* buckets have no "~" in full text', () {
      expect(past(oneHour, 'bs'), 'prije sat');
      expect(future(oneDay, 'bs'), 'za dan');
      expect(past(oneMonth, 'bs'), 'prije mjesec');
      expect(past(oneYear, 'bs'), 'prije godinu');
      expect(future(oneYear, 'bs'), 'za godinu');
    });

    test('teen numbers use the "other" form', () {
      final rdt = BsLocale().relativeDateTime();
      expect(rdt.years(11), '11 godina');
      expect(rdt.years(12), '12 godina');
      expect(rdt.years(22), '22 godine');
      expect(rdt.minutes(14), '14 minuta');
      expect(rdt.minutes(24), '24 minute');
    });
  });

  group('hr', () {
    test('plural forms use n % 10 (not n % 4)', () {
      final rdt = HrLocale().relativeDateTime();
      expect(rdt.minutes(8), '8 minuta');
      expect(rdt.minutes(4), '4 minute');
      expect(rdt.minutes(24), '24 minute');
      expect(rdt.minutes(14), '14 minuta');
      expect(rdt.hours(20), '20 sati');
      expect(rdt.hours(21), '21 sat');
      expect(rdt.months(8), '8 mjeseci');
      expect(rdt.years(16), '16 godina');
      expect(rdt.years(21), '21 godinu');
      expect(rdt.days(21), '21 dan');
      expect(rdt.days(11), '11 dana');
    });

    test('past and future', () {
      expect(past(twentyOneHours, 'hr'), 'prije 21 sat');
      expect(future(twoHours, 'hr'), 'za 2 sata');
      expect(future(fiveYears, 'hr'), 'za 5 godina');
    });
  });

  group('cs', () {
    test('past uses the instrumental after "před"', () {
      expect(past(tenSeconds, 'cs'), 'před chvílí');
      expect(past(oneMinute, 'cs'), 'před minutou');
      expect(past(fiveMinutes, 'cs'), 'před 5 minutami');
      expect(past(oneHour, 'cs'), 'před hodinou');
      expect(past(fiveDays, 'cs'), 'před 5 dny');
      expect(past(twoYears, 'cs'), 'před 2 lety');
      expect(past(fiveYears, 'cs'), 'před 5 lety');
    });

    test('future uses the accusative after "za"', () {
      expect(future(tenSeconds, 'cs'), 'za chvíli');
      expect(future(oneMinute, 'cs'), 'za minutu');
      expect(future(twoMinutes, 'cs'), 'za 2 minuty');
      expect(future(fiveMinutes, 'cs'), 'za 5 minut');
      expect(future(oneHour, 'cs'), 'za hodinu');
      expect(future(fiveHours, 'cs'), 'za 5 hodin');
      expect(future(oneDay, 'cs'), 'za den');
      expect(future(fiveDays, 'cs'), 'za 5 dní');
      expect(future(oneMonth, 'cs'), 'za měsíc');
      expect(future(twoMonths, 'cs'), 'za 2 měsíce');
      expect(future(oneYear, 'cs'), 'za rok');
      expect(future(twoYears, 'cs'), 'za 2 roky');
      expect(future(fiveYears, 'cs'), 'za 5 let');
    });

    test('without prefix/suffix still picks the direction case', () {
      expect(
        FlutterDateFormatter.formatRelativeDateTime(
          clock.add(fiveMinutes),
          locale: 'cs',
          clock: clock,
          withPrefixAndSuffix: false,
        ),
        '5 minut',
      );
    });
  });

  group('be', () {
    test('uses accusative forms after "праз" / before "таму"', () {
      expect(past(tenSeconds, 'be'), 'некалькі секунд таму');
      expect(future(tenSeconds, 'be'), 'праз некалькі секунд');
      expect(past(oneMinute, 'be'), 'хвіліну таму');
      expect(future(oneMinute, 'be'), 'праз хвіліну');
      expect(past(oneHour, 'be'), 'гадзіну таму');
      expect(future(oneHour, 'be'), 'праз гадзіну');
      expect(past(twentyOneHours, 'be'), '21 гадзіну таму');
      expect(future(twentyOneHours, 'be'), 'праз 21 гадзіну');
      expect(future(twoHours, 'be'), 'праз 2 гадзіны');
      expect(past(fiveHours, 'be'), '5 гадзін таму');
    });
  });

  group('gr / el', () {
    test('code is the ISO 639-1 Greek code', () {
      expect(GrLocale().code(), 'el');
    });

    test('spelling of "πριν" and future prefix "σε"', () {
      expect(GrLocale().relativeDateTime().minutes(5), '5 λεπτά');
      expect(past(fiveMinutes, 'gr'), '5 λεπτά πριν');
      expect(future(fiveMinutes, 'gr'), 'σε 5 λεπτά');
      expect(future(oneHour, 'gr'), 'σε περίπου μια ώρα');
      expect(past(twoYears, 'gr'), '2 χρόνια πριν');
    });
  });

  group('he', () {
    test('short form has no direction word in either direction', () {
      expect(future(tenSeconds, 'he', short: true), 'כעת');
      expect(past(tenSeconds, 'he', short: true), 'כעת');
      expect(future(fiveMinutes, 'he', short: true), '5 דקות');
      expect(past(fiveMinutes, 'he', short: true), '5 דקות');
    });

    test('long form keeps its prefixes', () {
      expect(past(fiveMinutes, 'he'), 'לפני 5 דקות');
      expect(future(fiveMinutes, 'he'), 'בעוד 5 דקות');
    });
  });

  group('az', () {
    test('ordinal suffixes follow vowel harmony', () {
      final expected = {
        0: '0-ıncı',
        1: '1-inci',
        2: '2-nci',
        3: '3-üncü',
        4: '4-üncü',
        5: '5-inci',
        6: '6-ncı',
        7: '7-nci',
        8: '8-inci',
        9: '9-uncu',
        10: '10-uncu',
        20: '20-nci',
        30: '30-uncu',
        40: '40-ıncı',
        50: '50-nci',
        60: '60-ıncı',
        100: '100-üncü',
        21: '21-inci',
        31: '31-inci',
      };
      for (final MapEntry(key: n, value: value) in expected.entries) {
        expect(FlutterDateFormatter.ordinal(n, locale: 'az'), value);
      }
    });

    test('ordinal() for the "do" pattern matches ordinalNumber()', () {
      final az = AzLocale();
      for (final n in [1, 2, 3, 6, 9, 10, 20, 31]) {
        expect('$n${az.ordinal(n)}', az.ordinalNumber(n));
      }
      expect(
        FlutterDateFormatter('do', 'az').format(DateTime(2024, 6, 3)),
        '3-üncü',
      );
    });

    test('relative wording', () {
      expect(past(tenSeconds, 'az'), 'bir neçə saniyə əvvəl');
      expect(future(tenSeconds, 'az'), 'bir neçə saniyə sonra');
      expect(future(fiveMinutes, 'az'), '5 dəqiqə sonra');
      expect(past(fiveMinutes, 'az'), '5 dəqiqə əvvəl');
    });
  });

  group('bn', () {
    test('uses Bengali digits for every unit', () {
      expect(past(fiveMinutes, 'bn'), '৫ মিনিট আগে');
      expect(past(fiveHours, 'bn'), '৫ ঘন্টা আগে');
      expect(past(fiveDays, 'bn'), '৫ দিন আগে');
      expect(future(fiveMinutes, 'bn'), '৫ মিনিট এখন থেকে');
      expect(future(fiveDays, 'bn'), '৫ দিন এখন থেকে');
      expect(past(twoYears, 'bn'), '২ বছর আগে');
    });

    test('large numbers are not compacted', () {
      expect(BnLocale().relativeDateTime().years(1500), '১৫০০ বছর');
      expect(BnLocale().shortRelativeDateTime().years(1500), '১৫০০বছর');
    });

    test('ordinalNumber returns a Bengali ordinal', () {
      final expected = {
        1: '১ম',
        2: '২য়',
        3: '৩য়',
        4: '৪র্থ',
        5: '৫ম',
        6: '৬ষ্ঠ',
        7: '৭ম',
        10: '১০ম',
        11: '১১তম',
        21: '২১তম',
        1000: '১০০০তম',
      };
      for (final MapEntry(key: n, value: value) in expected.entries) {
        expect(FlutterDateFormatter.ordinal(n, locale: 'bn'), value);
      }
    });

    test('short aboutAMinute has no trailing space', () {
      expect(past(oneMinute, 'bn', short: true), '১মিনিট');
      expect(future(oneMinute, 'bn', short: true), '১মিনিট');
    });
  });

  group('id', () {
    test('"do" pattern has no dot', () {
      expect(
        FlutterDateFormatter('do MMMM yyyy', 'id').format(DateTime(2024)),
        '1 Januari 2024',
      );
      expect(FlutterDateFormatter.ordinal(1, locale: 'id'), 'ke-1');
    });
  });

  group('fa', () {
    test('ordinalNumber matches the "do" suffix', () {
      expect(FlutterDateFormatter.ordinal(1, locale: 'fa'), '۱م');
      expect(FlutterDateFormatter.ordinal(21, locale: 'fa'), '۲۱م');
      expect(FlutterDateFormatter.ordinal(1000, locale: 'fa'), '۱۰۰۰م');
    });
  });

  group('es / ca', () {
    test('short hours use "h", not English "hr"', () {
      expect(past(twoHours, 'es', short: true), '2 h');
      expect(future(oneHour, 'es', short: true), '~1 h');
      expect(past(twoHours, 'ca', short: true), '2 h');
      expect(future(oneHour, 'ca', short: true), '~1 h');
    });
  });

  group('dv', () {
    test('ordinalNumber has no English "th" suffix', () {
      expect(DvLocale().ordinalNumber(1), '1');
      expect(DvLocale().ordinalNumber(21), '21');
    });
  });

  group('hi', () {
    test('years use "वर्ष" and the future uses "में"', () {
      expect(past(twoYears, 'hi'), '2 वर्ष पहले');
      expect(future(twoYears, 'hi'), '2 वर्ष में');
      expect(future(fiveMinutes, 'hi'), '5 मिनट में');
      expect(past(fiveMinutes, 'hi'), '5 मिनट पहले');
      expect(future(oneHour, 'hi'), 'करीब एक घंटे में');
      expect(past(oneHour, 'hi'), 'करीब एक घंटे पहले');
    });
  });

  group('de', () {
    test('short years use "J." instead of "Jr."', () {
      expect(past(twoYears, 'de', short: true), '2 J.');
      expect(future(oneYear, 'de', short: true), '~1 J.');
    });

    test('long form has no "~" in prose', () {
      expect(past(oneHour, 'de'), 'vor etwa einer Stunde');
      expect(future(oneHour, 'de'), 'in etwa einer Stunde');
      expect(past(oneDay, 'de'), 'vor einem Tag');
      expect(future(oneMonth, 'de'), 'in etwa einem Monat');
      expect(past(oneYear, 'de'), 'vor etwa einem Jahr');
    });
  });

  group('all owned locales', () {
    const locales = [
      'ar', 'az', 'be', 'bn', 'bs', 'ca', 'cs', 'de', 'dv', 'es', //
      'fa', 'fi', 'fr', 'gr', 'he', 'hi', 'hr', 'hu', 'id', 'ru',
    ];
    const durations = [
      tenSeconds,
      oneMinute,
      fiveMinutes,
      oneHour,
      fiveHours,
      oneDay,
      fiveDays,
      oneMonth,
      twoMonths,
      oneYear,
      twoYears,
    ];

    test('no double spaces or stray whitespace', () {
      for (final locale in locales) {
        for (final short in [false, true]) {
          expectNoDoubleSpaces([
            for (final d in durations) past(d, locale, short: short),
            for (final d in durations) future(d, locale, short: short),
          ]);
        }
      }
    });
  });
}
