import 'package:flutter_date_formatter/src/locale/locales/am_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/ar_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/az_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/be_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/bn_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/bs_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/ca_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/cs_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/da_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/de_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/dv_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/es_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/et_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/fa_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/fi_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/fr_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/gr_locale.dart';
import 'package:flutter_date_formatter/src/models/models.dart';
import 'package:test/test.dart';

// Fixed dates in the week of Monday, 10 March 2025.
final monday = DateTime(2025, 3, 10, 15);
final tuesday = DateTime(2025, 3, 11, 15);
final wednesday = DateTime(2025, 3, 12, 15);
final thursday = DateTime(2025, 3, 13, 15);
final friday = DateTime(2025, 3, 14, 15);
final saturday = DateTime(2025, 3, 15, 15);
final sunday = DateTime(2025, 3, 16, 15);

/// Asserts each count-to-text pair against [units].
void expectUnits(
  DurationUnits units, {
  Map<int, String> seconds = const {},
  Map<int, String> minutes = const {},
  Map<int, String> hours = const {},
  Map<int, String> days = const {},
  Map<int, String> weeks = const {},
}) {
  seconds.forEach((n, text) => expect(units.seconds(n), text));
  minutes.forEach((n, text) => expect(units.minutes(n), text));
  hours.forEach((n, text) => expect(units.hours(n), text));
  days.forEach((n, text) => expect(units.days(n), text));
  weeks.forEach((n, text) => expect(units.weeks(n), text));
}

void main() {
  group('am', () {
    final calendar = AmLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('ከሰዓት 3:00'), 'ዛሬ ከሰዓት 3:00');
      expect(calendar.nextDay('ከሰዓት 3:00'), 'ነገ ከሰዓት 3:00');
      expect(calendar.lastDay('ከሰዓት 3:00'), 'ትናንት ከሰዓት 3:00');
      expect(calendar.nextWeek(monday, 'ሰኞ', 'ከሰዓት 3:00'), 'ሰኞ ከሰዓት 3:00');
      expect(
        calendar.lastWeek(monday, 'ሰኞ', 'ከሰዓት 3:00'),
        'ባለፈው ሰኞ ከሰዓት 3:00',
      );
    });
    test('duration units', () {
      expectUnits(
        AmLocale().durationUnits(),
        seconds: {0: '0 ሰከንድ', 1: '1 ሰከንድ', 2: '2 ሰከንዶች'},
        minutes: {1: '1 ደቂቃ', 5: '5 ደቂቃዎች'},
        hours: {1: '1 ሰዓት', 21: '21 ሰዓቶች'},
        days: {1: '1 ቀን', 5: '5 ቀናት'},
        weeks: {1: '1 ሳምንት', 2: '2 ሳምንታት'},
      );
      expect(AmLocale().durationUnits().delimiter(), ' ');
      expectUnits(
        AmLocale().shortDurationUnits(),
        seconds: {5: '5 ሰከ'},
        minutes: {5: '5 ደቂ'},
        hours: {5: '5 ሰ'},
        days: {5: '5 ቀ'},
        weeks: {5: '5 ሳምንት'},
      );
    });
  });

  group('ar', () {
    final calendar = ArLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('3:00 م'), 'اليوم عند الساعة 3:00 م');
      expect(calendar.nextDay('3:00 م'), 'غدًا عند الساعة 3:00 م');
      expect(calendar.lastDay('3:00 م'), 'أمس عند الساعة 3:00 م');
      expect(
        calendar.nextWeek(monday, 'الاثنين', '3:00 م'),
        'الاثنين عند الساعة 3:00 م',
      );
      expect(
        calendar.lastWeek(monday, 'الاثنين', '3:00 م'),
        'الاثنين الماضي عند الساعة 3:00 م',
      );
    });
    test('duration units', () {
      expectUnits(
        ArLocale().durationUnits(),
        seconds: {
          0: '0 ثانية',
          1: 'ثانية واحدة',
          2: 'ثانيتان',
          5: '5 ثوان',
          11: '11 ثانية',
          21: '21 ثانية',
          101: '101 ثانية',
          102: '102 ثانية',
          103: '103 ثوان',
        },
        minutes: {1: 'دقيقة واحدة', 2: 'دقيقتان', 5: '5 دقائق'},
        hours: {1: 'ساعة واحدة', 2: 'ساعتان', 5: '5 ساعات', 21: '21 ساعة'},
        days: {
          1: 'يوم واحد',
          2: 'يومان',
          5: '5 أيام',
          21: '21 يومًا',
          100: '100 يوم',
        },
        weeks: {1: 'أسبوع واحد', 2: 'أسبوعان', 5: '5 أسابيع', 11: '11 أسبوعًا'},
      );
      expect(ArLocale().durationUnits().delimiter(), ' و');
      expectUnits(
        ArLocale().shortDurationUnits(),
        seconds: {5: '5 ث'},
        minutes: {5: '5 د'},
        hours: {5: '5 س'},
        days: {5: '5 ي'},
        weeks: {2: 'أسبوعان', 5: '5 أسابيع'},
      );
    });
  });

  group('az', () {
    final calendar = AzLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'Bugün saat 15:00');
      expect(calendar.nextDay('15:00'), 'Sabah saat 15:00');
      expect(calendar.lastDay('15:00'), 'Dünən saat 15:00');
      expect(
        calendar.nextWeek(monday, 'bazar ertəsi', '15:00'),
        'Gələn həftə bazar ertəsi saat 15:00',
      );
      expect(
        calendar.lastWeek(monday, 'bazar ertəsi', '15:00'),
        'Keçən həftə bazar ertəsi saat 15:00',
      );
    });
    test('duration units', () {
      expectUnits(
        AzLocale().durationUnits(),
        seconds: {1: '1 saniyə', 5: '5 saniyə'},
        minutes: {2: '2 dəqiqə'},
        hours: {21: '21 saat'},
        days: {1: '1 gün', 5: '5 gün'},
        weeks: {2: '2 həftə'},
      );
      expectUnits(
        AzLocale().shortDurationUnits(),
        seconds: {5: '5 san'},
        minutes: {5: '5 dəq'},
        hours: {5: '5 saat'},
        days: {5: '5 gün'},
        weeks: {5: '5 həftə'},
      );
    });
  });

  group('be', () {
    final calendar = BeLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'Сёння ў 15:00');
      expect(calendar.nextDay('15:00'), 'Заўтра ў 15:00');
      expect(calendar.lastDay('15:00'), 'Учора ў 15:00');
      expect(
        calendar.nextWeek(wednesday, 'серада', '15:00'),
        'У сераду ў 15:00',
      );
      expect(
        calendar.nextWeek(monday, 'панядзелак', '15:00'),
        'У панядзелак ў 15:00',
      );
      expect(
        calendar.lastWeek(monday, 'панядзелак', '15:00'),
        'У мінулы панядзелак ў 15:00',
      );
      expect(
        calendar.lastWeek(thursday, 'чацвер', '15:00'),
        'У мінулы чацвер ў 15:00',
      );
      expect(
        calendar.lastWeek(friday, 'пятніца', '15:00'),
        'У мінулую пятніцу ў 15:00',
      );
      expect(
        calendar.lastWeek(sunday, 'нядзеля', '15:00'),
        'У мінулую нядзелю ў 15:00',
      );
    });
    test('duration units', () {
      expectUnits(
        BeLocale().durationUnits(),
        seconds: {0: '0 секунд', 1: '1 секунда', 2: '2 секунды'},
        minutes: {
          1: '1 хвіліна',
          2: '2 хвіліны',
          5: '5 хвілін',
          11: '11 хвілін',
          21: '21 хвіліна',
          22: '22 хвіліны',
          25: '25 хвілін',
          101: '101 хвіліна',
        },
        hours: {1: '1 гадзіна', 2: '2 гадзіны', 5: '5 гадзін', 12: '12 гадзін'},
        days: {1: '1 дзень', 2: '2 дні', 5: '5 дзён', 21: '21 дзень'},
        weeks: {1: '1 тыдзень', 2: '2 тыдні', 5: '5 тыдняў', 21: '21 тыдзень'},
      );
      expectUnits(
        BeLocale().shortDurationUnits(),
        seconds: {5: '5 сек.'},
        minutes: {5: '5 хв.'},
        hours: {5: '5 гадз.'},
        days: {5: '5 дн.'},
        weeks: {5: '5 тыдз.'},
      );
    });
  });

  group('bn', () {
    final calendar = BnLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('৩:০০ PM'), 'আজ ৩:০০ PM');
      expect(calendar.nextDay('৩:০০ PM'), 'আগামীকাল ৩:০০ PM');
      expect(calendar.lastDay('৩:০০ PM'), 'গতকাল ৩:০০ PM');
      expect(
        calendar.nextWeek(monday, 'সোমবার', '৩:০০ PM'),
        'সোমবার, ৩:০০ PM',
      );
      expect(
        calendar.lastWeek(monday, 'সোমবার', '৩:০০ PM'),
        'গত সোমবার, ৩:০০ PM',
      );
    });
    test('duration units', () {
      expectUnits(
        BnLocale().durationUnits(),
        seconds: {1: '১ সেকেন্ড', 21: '২১ সেকেন্ড'},
        minutes: {2: '২ মিনিট'},
        hours: {5: '৫ ঘন্টা'},
        days: {5: '৫ দিন'},
        weeks: {1: '১ সপ্তাহ'},
      );
      expectUnits(
        BnLocale().shortDurationUnits(),
        seconds: {5: '৫ সেকেন্ড'},
        minutes: {5: '৫ মিনিট'},
        hours: {5: '৫ ঘন্টা'},
        days: {5: '৫ দিন'},
        weeks: {5: '৫ সপ্তাহ'},
      );
    });
  });

  group('bs', () {
    final calendar = BsLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'Danas u 15:00');
      expect(calendar.nextDay('15:00'), 'Sutra u 15:00');
      expect(calendar.lastDay('15:00'), 'Jučer u 15:00');
      expect(
        calendar.nextWeek(monday, 'ponedjeljak', '15:00'),
        'U ponedjeljak u 15:00',
      );
      expect(
        calendar.nextWeek(wednesday, 'srijeda', '15:00'),
        'U srijedu u 15:00',
      );
      expect(
        calendar.nextWeek(sunday, 'nedjelja', '15:00'),
        'U nedjelju u 15:00',
      );
      expect(
        calendar.lastWeek(monday, 'ponedjeljak', '15:00'),
        'Prošli ponedjeljak u 15:00',
      );
      expect(
        calendar.lastWeek(wednesday, 'srijeda', '15:00'),
        'Prošlu srijedu u 15:00',
      );
      expect(
        calendar.lastWeek(saturday, 'subota', '15:00'),
        'Prošle subote u 15:00',
      );
    });
    test('duration units', () {
      expectUnits(
        BsLocale().durationUnits(),
        seconds: {0: '0 sekundi', 1: '1 sekunda', 2: '2 sekunde'},
        minutes: {
          1: '1 minuta',
          2: '2 minute',
          5: '5 minuta',
          11: '11 minuta',
          21: '21 minuta',
          22: '22 minute',
        },
        hours: {1: '1 sat', 2: '2 sata', 5: '5 sati', 21: '21 sat'},
        days: {1: '1 dan', 2: '2 dana', 5: '5 dana', 21: '21 dan'},
        weeks: {1: '1 sedmica', 2: '2 sedmice', 5: '5 sedmica'},
      );
      expectUnits(
        BsLocale().shortDurationUnits(),
        seconds: {5: '5 sek.'},
        minutes: {5: '5 min.'},
        hours: {5: '5 h'},
        days: {5: '5 d.'},
        weeks: {5: '5 sedm.'},
      );
    });
  });

  group('ca', () {
    final calendar = CaLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'Avui a les 15:00');
      expect(calendar.sameDay('1:30'), 'Avui a la 1:30');
      expect(calendar.nextDay('15:00'), 'Demà a les 15:00');
      expect(calendar.lastDay('15:00'), 'Ahir a les 15:00');
      expect(
        calendar.nextWeek(monday, 'dilluns', '15:00'),
        'Dilluns a les 15:00',
      );
      expect(
        calendar.lastWeek(monday, 'dilluns', '15:00'),
        'El dilluns passat a les 15:00',
      );
    });
    test('duration units', () {
      expectUnits(
        CaLocale().durationUnits(),
        seconds: {0: '0 segons', 1: '1 segon', 2: '2 segons'},
        minutes: {1: '1 minut', 5: '5 minuts'},
        hours: {1: '1 hora', 21: '21 hores'},
        days: {1: '1 dia', 5: '5 dies'},
        weeks: {1: '1 setmana', 2: '2 setmanes'},
      );
      expectUnits(
        CaLocale().shortDurationUnits(),
        seconds: {5: '5 s'},
        minutes: {5: '5 min'},
        hours: {5: '5 h'},
        days: {5: '5 d'},
        weeks: {5: '5 setm.'},
      );
    });
  });

  group('cs', () {
    final calendar = CsLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'Dnes v 15:00');
      expect(calendar.nextDay('15:00'), 'Zítra v 15:00');
      expect(calendar.lastDay('15:00'), 'Včera v 15:00');
      expect(
        calendar.nextWeek(monday, 'pondělí', '15:00'),
        'V pondělí v 15:00',
      );
      expect(
        calendar.nextWeek(wednesday, 'středa', '15:00'),
        'Ve středu v 15:00',
      );
      expect(calendar.nextWeek(sunday, 'neděle', '15:00'), 'V neděli v 15:00');
      expect(
        calendar.lastWeek(monday, 'pondělí', '15:00'),
        'Minulé pondělí v 15:00',
      );
      expect(
        calendar.lastWeek(wednesday, 'středa', '15:00'),
        'Minulou středu v 15:00',
      );
      expect(
        calendar.lastWeek(thursday, 'čtvrtek', '15:00'),
        'Minulý čtvrtek v 15:00',
      );
      expect(
        calendar.lastWeek(saturday, 'sobota', '15:00'),
        'Minulou sobotu v 15:00',
      );
    });
    test('duration units', () {
      expectUnits(
        CsLocale().durationUnits(),
        seconds: {0: '0 sekund', 1: '1 sekunda', 2: '2 sekundy'},
        minutes: {
          1: '1 minuta',
          2: '2 minuty',
          5: '5 minut',
          21: '21 minut',
          22: '22 minut',
        },
        hours: {1: '1 hodina', 4: '4 hodiny', 5: '5 hodin'},
        days: {1: '1 den', 2: '2 dny', 5: '5 dní', 21: '21 dní'},
        weeks: {1: '1 týden', 2: '2 týdny', 5: '5 týdnů'},
      );
      expectUnits(
        CsLocale().shortDurationUnits(),
        seconds: {5: '5 s'},
        minutes: {5: '5 min'},
        hours: {5: '5 h'},
        days: {5: '5 d'},
        weeks: {5: '5 týd.'},
      );
    });
  });

  group('da', () {
    final calendar = DaLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('15.00'), 'I dag kl. 15.00');
      expect(calendar.nextDay('15.00'), 'I morgen kl. 15.00');
      expect(calendar.lastDay('15.00'), 'I går kl. 15.00');
      expect(
        calendar.nextWeek(monday, 'mandag', '15.00'),
        'På mandag kl. 15.00',
      );
      expect(
        calendar.lastWeek(monday, 'mandag', '15.00'),
        'I mandags kl. 15.00',
      );
    });
    test('duration units', () {
      expectUnits(
        DaLocale().durationUnits(),
        seconds: {0: '0 sekunder', 1: '1 sekund'},
        minutes: {1: '1 minut', 5: '5 minutter'},
        hours: {1: '1 time', 2: '2 timer'},
        days: {1: '1 dag', 5: '5 dage', 21: '21 dage'},
        weeks: {1: '1 uge', 2: '2 uger'},
      );
      expectUnits(
        DaLocale().shortDurationUnits(),
        seconds: {5: '5 sek.'},
        minutes: {5: '5 min.'},
        hours: {5: '5 t.'},
        days: {5: '5 d.'},
        weeks: {5: '5 u.'},
      );
    });
  });

  group('de', () {
    final calendar = DeLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'Heute um 15:00 Uhr');
      expect(calendar.nextDay('15:00'), 'Morgen um 15:00 Uhr');
      expect(calendar.lastDay('15:00'), 'Gestern um 15:00 Uhr');
      expect(
        calendar.nextWeek(monday, 'Montag', '15:00'),
        'Montag um 15:00 Uhr',
      );
      expect(
        calendar.lastWeek(DateTime(2025, 3, 10), 'Montag', '15:00'),
        'Letzten Montag um 15:00 Uhr',
      );
    });
    test('duration units', () {
      expectUnits(
        DeLocale().durationUnits(),
        seconds: {0: '0 Sekunden', 1: '1 Sekunde'},
        minutes: {1: '1 Minute', 2: '2 Minuten'},
        hours: {1: '1 Stunde', 21: '21 Stunden'},
        days: {1: '1 Tag', 5: '5 Tage'},
        weeks: {1: '1 Woche', 2: '2 Wochen'},
      );
      expectUnits(
        DeLocale().shortDurationUnits(),
        seconds: {5: '5 Sek.'},
        minutes: {5: '5 Min.'},
        hours: {2: '2 Std.'},
        days: {5: '5 Tg.'},
        weeks: {5: '5 Wo.'},
      );
    });
  });

  group('dv', () {
    final calendar = DvLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'މިއަދު 15:00');
      expect(calendar.nextDay('15:00'), 'މާދަމާ 15:00');
      expect(calendar.lastDay('15:00'), 'އިއްޔެ 15:00');
      expect(calendar.nextWeek(monday, 'Monday', '15:00'), 'ހޯމަ 15:00');
      expect(calendar.nextWeek(sunday, 'Sunday', '15:00'), 'އާދިއްތަ 15:00');
      expect(
        calendar.lastWeek(friday, 'Friday', '15:00'),
        'ފާއިތުވި ހުކުރު 15:00',
      );
    });
    test('duration units', () {
      expectUnits(
        DvLocale().durationUnits(),
        seconds: {1: '1 ސިކުންތު'},
        minutes: {2: '2 މިނެޓު'},
        hours: {5: '5 ގަޑިއިރު'},
        days: {5: '5 ދުވަސް'},
        weeks: {21: '21 ހަފްތާ'},
      );
      expect(DvLocale().shortDurationUnits().days(5), '5 ދުވަސް');
    });
  });

  group('el', () {
    final calendar = GrLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('3:00 μ.μ.'), 'Σήμερα στις 3:00 μ.μ.');
      expect(calendar.sameDay('1:00 μ.μ.'), 'Σήμερα στη 1:00 μ.μ.');
      expect(calendar.nextDay('3:00 μ.μ.'), 'Αύριο στις 3:00 μ.μ.');
      expect(calendar.lastDay('3:00 μ.μ.'), 'Χθες στις 3:00 μ.μ.');
      expect(
        calendar.nextWeek(monday, 'Δευτέρα', '3:00 μ.μ.'),
        'Δευτέρα στις 3:00 μ.μ.',
      );
      expect(
        calendar.lastWeek(monday, 'Δευτέρα', '3:00 μ.μ.'),
        'Την προηγούμενη Δευτέρα στις 3:00 μ.μ.',
      );
      expect(
        calendar.lastWeek(saturday, 'Σάββατο', '3:00 μ.μ.'),
        'Το προηγούμενο Σάββατο στις 3:00 μ.μ.',
      );
    });
    test('duration units', () {
      expectUnits(
        GrLocale().durationUnits(),
        seconds: {0: '0 δευτερόλεπτα', 1: '1 δευτερόλεπτο'},
        minutes: {1: '1 λεπτό', 2: '2 λεπτά'},
        hours: {1: '1 ώρα', 21: '21 ώρες'},
        days: {1: '1 μέρα', 5: '5 μέρες'},
        weeks: {1: '1 εβδομάδα', 2: '2 εβδομάδες'},
      );
      expectUnits(
        GrLocale().shortDurationUnits(),
        seconds: {5: '5 δευτ.'},
        minutes: {5: '5 λ.'},
        hours: {5: '5 ώ.'},
        days: {5: '5 ημ.'},
        weeks: {5: '5 εβδ.'},
      );
    });
  });

  group('es', () {
    final calendar = EsLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'Hoy a las 15:00');
      expect(calendar.sameDay('1:00'), 'Hoy a la 1:00');
      expect(calendar.nextDay('15:00'), 'Mañana a las 15:00');
      expect(calendar.lastDay('15:00'), 'Ayer a las 15:00');
      expect(
        calendar.nextWeek(monday, 'lunes', '15:00'),
        'Lunes a las 15:00',
      );
      expect(
        calendar.lastWeek(monday, 'lunes', '15:00'),
        'El lunes pasado a las 15:00',
      );
    });
    test('duration units', () {
      expectUnits(
        EsLocale().durationUnits(),
        seconds: {0: '0 segundos', 1: '1 segundo'},
        minutes: {1: '1 minuto', 2: '2 minutos'},
        hours: {1: '1 hora', 21: '21 horas'},
        days: {1: '1 día', 5: '5 días'},
        weeks: {1: '1 semana', 2: '2 semanas'},
      );
      expectUnits(
        EsLocale().shortDurationUnits(),
        seconds: {5: '5 s'},
        minutes: {5: '5 min'},
        hours: {5: '5 h'},
        days: {5: '5 d'},
        weeks: {5: '5 sem.'},
      );
    });
  });

  group('et', () {
    final calendar = EtLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'Täna, 15:00');
      expect(calendar.nextDay('15:00'), 'Homme, 15:00');
      expect(calendar.lastDay('15:00'), 'Eile, 15:00');
      expect(
        calendar.nextWeek(monday, 'esmaspäev', '15:00'),
        'Järgmine esmaspäev 15:00',
      );
      expect(
        calendar.lastWeek(monday, 'esmaspäev', '15:00'),
        'Eelmine esmaspäev 15:00',
      );
    });
    test('duration units', () {
      expectUnits(
        EtLocale().durationUnits(),
        seconds: {0: '0 sekundit', 1: '1 sekund'},
        minutes: {1: '1 minut', 2: '2 minutit'},
        hours: {1: '1 tund', 21: '21 tundi'},
        days: {1: '1 päev', 5: '5 päeva'},
        weeks: {1: '1 nädal', 2: '2 nädalat'},
      );
      expectUnits(
        EtLocale().shortDurationUnits(),
        seconds: {5: '5 s'},
        minutes: {5: '5 min'},
        hours: {5: '5 t'},
        days: {5: '5 p'},
        weeks: {5: '5 näd'},
      );
    });
  });

  group('fa', () {
    final calendar = FaLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('۱۵:۰۰'), 'امروز ساعت ۱۵:۰۰');
      expect(calendar.nextDay('۱۵:۰۰'), 'فردا ساعت ۱۵:۰۰');
      expect(calendar.lastDay('۱۵:۰۰'), 'دیروز ساعت ۱۵:۰۰');
      expect(
        calendar.nextWeek(monday, 'دوشنبه', '۱۵:۰۰'),
        'دوشنبه ساعت ۱۵:۰۰',
      );
      expect(
        calendar.lastWeek(monday, 'دوشنبه', '۱۵:۰۰'),
        'دوشنبه پیش ساعت ۱۵:۰۰',
      );
    });
    test('duration units', () {
      expectUnits(
        FaLocale().durationUnits(),
        seconds: {1: '۱ ثانیه', 1000: '۱۰۰۰ ثانیه'},
        minutes: {2: '۲ دقیقه'},
        hours: {21: '۲۱ ساعت'},
        days: {5: '۵ روز'},
        weeks: {5: '۵ هفته'},
      );
      expect(FaLocale().durationUnits().delimiter(), ' و ');
      expect(FaLocale().shortDurationUnits().days(5), '۵ روز');
    });
  });

  group('fi', () {
    final calendar = FiLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('15.00'), 'Tänään klo 15.00');
      expect(calendar.nextDay('15.00'), 'Huomenna klo 15.00');
      expect(calendar.lastDay('15.00'), 'Eilen klo 15.00');
      expect(
        calendar.nextWeek(monday, 'maanantai', '15.00'),
        'Maanantaina klo 15.00',
      );
      expect(
        calendar.nextWeek(wednesday, 'keskiviikko', '15.00'),
        'Keskiviikkona klo 15.00',
      );
      expect(
        calendar.lastWeek(monday, 'maanantai', '15.00'),
        'Viime maanantaina klo 15.00',
      );
      expect(
        calendar.lastWeek(sunday, 'sunnuntai', '15.00'),
        'Viime sunnuntaina klo 15.00',
      );
    });
    test('duration units', () {
      expectUnits(
        FiLocale().durationUnits(),
        seconds: {0: '0 sekuntia', 1: '1 sekunti'},
        minutes: {1: '1 minuutti', 2: '2 minuuttia'},
        hours: {1: '1 tunti', 21: '21 tuntia'},
        days: {1: '1 päivä', 5: '5 päivää'},
        weeks: {1: '1 viikko', 2: '2 viikkoa'},
      );
      expectUnits(
        FiLocale().shortDurationUnits(),
        seconds: {5: '5 s'},
        minutes: {5: '5 min'},
        hours: {5: '5 t'},
        days: {5: '5 pv'},
        weeks: {5: '5 vk'},
      );
    });
  });

  group('fr', () {
    final calendar = FrLocale().calendarDateTime();
    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'Aujourd’hui à 15:00');
      expect(calendar.nextDay('15:00'), 'Demain à 15:00');
      expect(calendar.lastDay('15:00'), 'Hier à 15:00');
      expect(calendar.nextWeek(monday, 'lundi', '15:00'), 'Lundi à 15:00');
      expect(
        calendar.lastWeek(monday, 'lundi', '15:00'),
        'Lundi dernier à 15:00',
      );
    });
    test('duration units', () {
      expectUnits(
        FrLocale().durationUnits(),
        seconds: {0: '0 seconde', 1: '1 seconde', 2: '2 secondes'},
        minutes: {1: '1 minute', 5: '5 minutes'},
        hours: {1: '1 heure', 21: '21 heures'},
        days: {1: '1 jour', 5: '5 jours'},
        weeks: {1: '1 semaine', 2: '2 semaines'},
      );
      expectUnits(
        FrLocale().shortDurationUnits(),
        seconds: {5: '5 s'},
        minutes: {5: '5 min'},
        hours: {5: '5 h'},
        days: {5: '5 j'},
        weeks: {5: '5 sem.'},
      );
    });
  });
}
