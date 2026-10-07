import 'package:flutter_date_formatter/src/locale/locales/nn_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/pl_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/ps_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/pt_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/ro_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/ru_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/rw_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/sk_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/sr_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/sv_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/ta_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/th_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/tk_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/tl_ph_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/tr_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/uk_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/ur_locale.dart';
import 'package:flutter_date_formatter/src/locale/locales/zh_locale.dart';
import 'package:test/test.dart';

// The week of 3-9 March 2025 runs Monday to Sunday.
final DateTime monday = DateTime(2025, 3, 3);
final DateTime tuesday = DateTime(2025, 3, 4);
final DateTime wednesday = DateTime(2025, 3, 5);
final DateTime thursday = DateTime(2025, 3, 6);
final DateTime friday = DateTime(2025, 3, 7);
final DateTime saturday = DateTime(2025, 3, 8);
final DateTime sunday = DateTime(2025, 3, 9);

void main() {
  group('nn', () {
    final cal = NnLocale().calendarDateTime();
    final units = NnLocale().durationUnits();
    final short = NnLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('15:00'), 'I dag klokka 15:00');
      expect(cal.nextDay('15:00'), 'I morgon klokka 15:00');
      expect(cal.lastDay('15:00'), 'I går klokka 15:00');
      expect(
        cal.nextWeek(monday, 'mandag', '15:00'),
        'Måndag klokka 15:00',
      );
      expect(
        cal.lastWeek(sunday, 'søndag', '15:00'),
        'Førre sundag klokka 15:00',
      );
    });

    test('duration units', () {
      expect(units.hours(1), '1 time');
      expect(units.hours(2), '2 timar');
      expect(units.days(5), '5 dagar');
      expect(units.weeks(1), '1 veke');
      expect(units.weeks(21), '21 veker');
      expect(units.minutes(5), '5 minutt');
      expect(units.seconds(1), '1 sekund');
      expect(short.days(5), '5 d');
      expect(short.hours(2), '2 t');
    });
  });

  group('pl', () {
    final cal = PlLocale().calendarDateTime();
    final units = PlLocale().durationUnits();
    final short = PlLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('15:00'), 'Dziś o 15:00');
      expect(cal.nextDay('15:00'), 'Jutro o 15:00');
      expect(cal.lastDay('15:00'), 'Wczoraj o 15:00');
      expect(
        cal.nextWeek(tuesday, 'wtorek', '15:00'),
        'We wtorek o 15:00',
      );
      expect(
        cal.nextWeek(wednesday, 'środa', '15:00'),
        'W środę o 15:00',
      );
      expect(
        cal.nextWeek(friday, 'piątek', '15:00'),
        'W piątek o 15:00',
      );
      expect(
        cal.lastWeek(sunday, 'niedziela', '15:00'),
        'W zeszłą niedzielę o 15:00',
      );
      expect(
        cal.lastWeek(saturday, 'sobota', '15:00'),
        'W zeszłą sobotę o 15:00',
      );
      expect(
        cal.lastWeek(monday, 'poniedziałek', '15:00'),
        'W zeszły poniedziałek o 15:00',
      );
    });

    test('duration units', () {
      expect(units.minutes(1), '1 minuta');
      expect(units.minutes(2), '2 minuty');
      expect(units.minutes(5), '5 minut');
      expect(units.minutes(21), '21 minut');
      expect(units.minutes(22), '22 minuty');
      expect(units.minutes(12), '12 minut');
      expect(units.minutes(0), '0 minut');
      expect(units.seconds(2), '2 sekundy');
      expect(units.hours(1), '1 godzina');
      expect(units.hours(5), '5 godzin');
      expect(units.days(1), '1 dzień');
      expect(units.days(5), '5 dni');
      expect(units.weeks(2), '2 tygodnie');
      expect(units.weeks(5), '5 tygodni');
      expect(short.days(5), '5 d');
      expect(short.hours(2), '2 godz.');
    });
  });

  group('ps', () {
    final cal = PsLocale().calendarDateTime();
    final units = PsLocale().durationUnits();
    final short = PsLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('۱۵:۰۰'), 'نن په ۱۵:۰۰');
      expect(cal.nextDay('۱۵:۰۰'), 'سبا په ۱۵:۰۰');
      expect(cal.lastDay('۱۵:۰۰'), 'پرون په ۱۵:۰۰');
      expect(cal.nextWeek(monday, 'دونۍ', '۱۵:۰۰'), 'دونۍ په ۱۵:۰۰');
      expect(cal.lastWeek(sunday, 'يونۍ', '۱۵:۰۰'), 'تېره يونۍ په ۱۵:۰۰');
    });

    test('duration units', () {
      expect(units.minutes(1), '۱ دقیقه');
      expect(units.minutes(5), '۵ دقیقې');
      expect(units.hours(2), '۲ ساعته');
      expect(units.days(1), '۱ ورځ');
      expect(units.days(5), '۵ ورځې');
      expect(units.days(21), '۲۱ ورځې');
      expect(units.weeks(2), '۲ اونۍ');
      expect(short.days(5), '۵ ورځې');
    });
  });

  group('pt', () {
    final cal = PtLocale().calendarDateTime();
    final units = PtLocale().durationUnits();
    final short = PtLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('15:00'), 'Hoje às 15:00');
      expect(cal.nextDay('15:00'), 'Amanhã às 15:00');
      expect(cal.lastDay('15:00'), 'Ontem às 15:00');
      expect(
        cal.nextWeek(monday, 'segunda-feira', '15:00'),
        'Segunda-feira às 15:00',
      );
      expect(
        cal.lastWeek(monday, 'segunda-feira', '15:00'),
        'Última segunda-feira às 15:00',
      );
      expect(
        cal.lastWeek(sunday, 'domingo', '15:00'),
        'Último domingo às 15:00',
      );
      expect(
        cal.lastWeek(saturday, 'sábado', '15:00'),
        'Último sábado às 15:00',
      );
    });

    test('duration units', () {
      expect(units.minutes(0), '0 minutos');
      expect(units.minutes(1), '1 minuto');
      expect(units.minutes(2), '2 minutos');
      expect(units.hours(1), '1 hora');
      expect(units.days(5), '5 dias');
      expect(units.weeks(21), '21 semanas');
      expect(short.days(5), '5 d');
      expect(short.weeks(2), '2 sem.');
    });
  });

  group('ro', () {
    final cal = RoLocale().calendarDateTime();
    final units = RoLocale().durationUnits();
    final short = RoLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('15:00'), 'Azi la 15:00');
      expect(cal.nextDay('15:00'), 'Mâine la 15:00');
      expect(cal.lastDay('15:00'), 'Ieri la 15:00');
      expect(cal.nextWeek(monday, 'luni', '15:00'), 'Luni la 15:00');
      expect(
        cal.lastWeek(sunday, 'duminică', '15:00'),
        'Fosta duminică la 15:00',
      );
    });

    test('duration units', () {
      expect(units.minutes(1), '1 minut');
      expect(units.minutes(2), '2 minute');
      expect(units.minutes(5), '5 minute');
      expect(units.minutes(21), '21 de minute');
      expect(units.minutes(0), '0 minute');
      expect(units.minutes(101), '101 minute');
      expect(units.seconds(1), '1 secundă');
      expect(units.hours(1), '1 oră');
      expect(units.hours(25), '25 de ore');
      expect(units.days(1), '1 zi');
      expect(units.days(5), '5 zile');
      expect(units.weeks(1), '1 săptămână');
      expect(units.weeks(2), '2 săptămâni');
      expect(short.days(5), '5 z');
    });
  });

  group('ru', () {
    final cal = RuLocale().calendarDateTime();
    final units = RuLocale().durationUnits();
    final short = RuLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('15:00'), 'Сегодня, в 15:00');
      expect(cal.nextDay('15:00'), 'Завтра, в 15:00');
      expect(cal.lastDay('15:00'), 'Вчера, в 15:00');
      expect(
        cal.nextWeek(tuesday, 'вторник', '15:00'),
        'В следующий вторник, в 15:00',
      );
      expect(
        cal.nextWeek(tuesday, 'вторник', '15:00', isSameWeek: true),
        'Во вторник, в 15:00',
      );
      expect(
        cal.nextWeek(friday, 'пятница', '15:00'),
        'В следующую пятницу, в 15:00',
      );
      expect(
        cal.nextWeek(friday, 'пятница', '15:00', isSameWeek: true),
        'В пятницу, в 15:00',
      );
      expect(
        cal.lastWeek(wednesday, 'среда', '15:00', isSameWeek: true),
        'В среду, в 15:00',
      );
      expect(
        cal.lastWeek(sunday, 'воскресенье', '15:00'),
        'В прошлое воскресенье, в 15:00',
      );
      expect(
        cal.lastWeek(wednesday, 'среда', '15:00'),
        'В прошлую среду, в 15:00',
      );
      expect(
        cal.lastWeek(monday, 'понедельник', '15:00'),
        'В прошлый понедельник, в 15:00',
      );
    });

    test('duration units', () {
      expect(units.minutes(1), '1 минута');
      expect(units.minutes(2), '2 минуты');
      expect(units.minutes(5), '5 минут');
      expect(units.minutes(11), '11 минут');
      expect(units.minutes(21), '21 минута');
      expect(units.minutes(22), '22 минуты');
      expect(units.minutes(0), '0 минут');
      expect(units.seconds(21), '21 секунда');
      expect(units.hours(1), '1 час');
      expect(units.hours(2), '2 часа');
      expect(units.hours(5), '5 часов');
      expect(units.days(1), '1 день');
      expect(units.days(2), '2 дня');
      expect(units.days(5), '5 дней');
      expect(units.weeks(1), '1 неделя');
      expect(units.weeks(5), '5 недель');
      expect(short.minutes(5), '5 мин');
      expect(short.hours(2), '2 ч');
      expect(short.days(5), '5 дн.');
    });
  });

  group('rw', () {
    final cal = RwLocale().calendarDateTime();
    final units = RwLocale().durationUnits();
    final short = RwLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('15:00'), 'Uyu munsi saa 15:00');
      expect(cal.nextDay('15:00'), 'Ejo hazaza saa 15:00');
      expect(cal.lastDay('15:00'), 'Ejo hashize saa 15:00');
      expect(
        cal.nextWeek(monday, 'Monday', '15:00'),
        'Kuwa mbere saa 15:00',
      );
      expect(
        cal.lastWeek(monday, 'Monday', '15:00'),
        'Kuwa mbere ushize saa 15:00',
      );
      expect(
        cal.lastWeek(sunday, 'Sunday', '15:00'),
        'Ku cyumweru hashize saa 15:00',
      );
    });

    test('duration units', () {
      expect(units.minutes(1), 'umunota 1');
      expect(units.minutes(5), 'iminota 5');
      expect(units.hours(2), 'amasaha 2');
      expect(units.days(1), 'umunsi 1');
      expect(units.days(5), 'iminsi 5');
      expect(units.weeks(21), 'ibyumweru 21');
      expect(short.days(5), 'iminsi 5');
    });
  });

  group('sk', () {
    final cal = SkLocale().calendarDateTime();
    final units = SkLocale().durationUnits();
    final short = SkLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('15:00'), 'Dnes o 15:00');
      expect(cal.nextDay('15:00'), 'Zajtra o 15:00');
      expect(cal.lastDay('15:00'), 'Včera o 15:00');
      expect(
        cal.nextWeek(thursday, 'štvrtok', '15:00'),
        'Vo štvrtok o 15:00',
      );
      expect(
        cal.nextWeek(sunday, 'nedeľa', '15:00'),
        'V nedeľu o 15:00',
      );
      expect(
        cal.lastWeek(sunday, 'nedeľa', '15:00'),
        'Minulú nedeľu o 15:00',
      );
      expect(
        cal.lastWeek(monday, 'pondelok', '15:00'),
        'Minulý pondelok o 15:00',
      );
    });

    test('duration units', () {
      expect(units.minutes(1), '1 minúta');
      expect(units.minutes(2), '2 minúty');
      expect(units.minutes(5), '5 minút');
      expect(units.minutes(21), '21 minút');
      expect(units.hours(1), '1 hodina');
      expect(units.days(1), '1 deň');
      expect(units.days(2), '2 dni');
      expect(units.days(5), '5 dní');
      expect(units.weeks(2), '2 týždne');
      expect(units.weeks(5), '5 týždňov');
      expect(short.days(5), '5 d');
    });
  });

  group('sr', () {
    final cal = SrLocale().calendarDateTime();
    final units = SrLocale().durationUnits();
    final short = SrLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('15:00'), 'Данас у 15:00');
      expect(cal.nextDay('15:00'), 'Сутра у 15:00');
      expect(cal.lastDay('15:00'), 'Јуче у 15:00');
      expect(
        cal.nextWeek(wednesday, 'среда', '15:00'),
        'У среду у 15:00',
      );
      expect(
        cal.nextWeek(monday, 'понедељак', '15:00'),
        'У понедељак у 15:00',
      );
      expect(
        cal.lastWeek(sunday, 'недеља', '15:00'),
        'Прошле недеље у 15:00',
      );
      expect(
        cal.lastWeek(monday, 'понедељак', '15:00'),
        'Прошлог понедељка у 15:00',
      );
    });

    test('duration units', () {
      expect(units.minutes(1), '1 минут');
      expect(units.minutes(2), '2 минута');
      expect(units.minutes(5), '5 минута');
      expect(units.minutes(21), '21 минут');
      expect(units.minutes(11), '11 минута');
      expect(units.seconds(2), '2 секунде');
      expect(units.seconds(5), '5 секунди');
      expect(units.hours(1), '1 сат');
      expect(units.hours(2), '2 сата');
      expect(units.hours(5), '5 сати');
      expect(units.days(5), '5 дана');
      expect(units.weeks(1), '1 недеља');
      expect(units.weeks(2), '2 недеље');
      expect(short.days(5), '5 д');
    });
  });

  group('sv', () {
    final cal = SvLocale().calendarDateTime();
    final units = SvLocale().durationUnits();
    final short = SvLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('15:00'), 'Idag 15:00');
      expect(cal.nextDay('15:00'), 'Imorgon 15:00');
      expect(cal.lastDay('15:00'), 'Igår 15:00');
      expect(cal.nextWeek(monday, 'måndag', '15:00'), 'På måndag 15:00');
      expect(cal.lastWeek(sunday, 'söndag', '15:00'), 'I söndags 15:00');
    });

    test('duration units', () {
      expect(units.minutes(1), '1 minut');
      expect(units.minutes(5), '5 minuter');
      expect(units.hours(1), '1 timme');
      expect(units.hours(2), '2 timmar');
      expect(units.days(5), '5 dagar');
      expect(units.weeks(21), '21 veckor');
      expect(short.days(5), '5 d');
    });
  });

  group('ta', () {
    final cal = TaLocale().calendarDateTime();
    final units = TaLocale().durationUnits();
    final short = TaLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('3:00 PM'), 'இன்று 3:00 PM');
      expect(cal.nextDay('3:00 PM'), 'நாளை 3:00 PM');
      expect(cal.lastDay('3:00 PM'), 'நேற்று 3:00 PM');
      expect(cal.nextWeek(monday, 'திங்கள்', '3:00 PM'), 'திங்கள், 3:00 PM');
      expect(
        cal.lastWeek(sunday, 'ஞாயிறு', '3:00 PM'),
        'கடந்த வாரம் ஞாயிறு, 3:00 PM',
      );
    });

    test('duration units', () {
      expect(units.minutes(1), '1 நிமிடம்');
      expect(units.minutes(5), '5 நிமிடங்கள்');
      expect(units.days(1), '1 நாள்');
      expect(units.days(5), '5 நாட்கள்');
      expect(units.hours(2), '2 மணி நேரம்');
      expect(short.days(5), '5 நாட்கள்');
    });
  });

  group('th', () {
    final cal = ThLocale().calendarDateTime();
    final units = ThLocale().durationUnits();
    final short = ThLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('15:00 น.'), 'วันนี้ เวลา 15:00 น.');
      expect(cal.nextDay('15:00 น.'), 'พรุ่งนี้ เวลา 15:00 น.');
      expect(cal.lastDay('15:00 น.'), 'เมื่อวานนี้ เวลา 15:00 น.');
      expect(
        cal.nextWeek(monday, 'วันจันทร์', '15:00 น.'),
        'วันจันทร์หน้า เวลา 15:00 น.',
      );
      expect(
        cal.lastWeek(sunday, 'วันอาทิตย์', '15:00 น.'),
        'วันอาทิตย์ที่แล้ว เวลา 15:00 น.',
      );
    });

    test('duration units', () {
      expect(units.minutes(5), '5 นาที');
      expect(units.hours(2), '2 ชั่วโมง');
      expect(units.days(5), '5 วัน');
      expect(short.days(5), '5 วัน');
      expect(short.hours(2), '2 ชม.');
    });
  });

  group('tk', () {
    final cal = TkLocale().calendarDateTime();
    final units = TkLocale().durationUnits();
    final short = TkLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('15:00'), 'Şu gün sagat 15:00');
      expect(cal.nextDay('15:00'), 'Ertir sagat 15:00');
      expect(cal.lastDay('15:00'), 'Düýn sagat 15:00');
      expect(
        cal.nextWeek(monday, 'Monday', '15:00'),
        'Indiki duşenbe sagat 15:00',
      );
      expect(
        cal.nextWeek(friday, 'Friday', '15:00', isSameWeek: true),
        'Anna sagat 15:00',
      );
      expect(
        cal.lastWeek(tuesday, 'Tuesday', '15:00', isSameWeek: true),
        'Sişenbe sagat 15:00',
      );
      expect(
        cal.lastWeek(sunday, 'Sunday', '15:00'),
        'Geçen ýekşenbe sagat 15:00',
      );
    });

    test('duration units', () {
      expect(units.minutes(1), '1 minut');
      expect(units.days(5), '5 gün');
      expect(units.weeks(2), '2 hepde');
      expect(short.days(5), '5 gün');
    });
  });

  group('tl_PH', () {
    final cal = TlPhLocale().calendarDateTime();
    final units = TlPhLocale().durationUnits();
    final short = TlPhLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('3:00 PM'), '3:00 PM ngayong araw');
      expect(cal.nextDay('3:00 PM'), 'Bukas ng 3:00 PM');
      expect(cal.lastDay('3:00 PM'), '3:00 PM kahapon');
      expect(
        cal.nextWeek(monday, 'Lunes', '3:00 PM'),
        '3:00 PM sa susunod na Lunes',
      );
      expect(
        cal.lastWeek(sunday, 'Linggo', '3:00 PM'),
        '3:00 PM noong nakaraang Linggo',
      );
    });

    test('duration units', () {
      expect(units.minutes(1), '1 minuto');
      expect(units.days(5), '5 araw');
      expect(units.weeks(2), '2 linggo');
      expect(short.days(5), '5 araw');
      expect(short.seconds(5), '5 seg');
    });
  });

  group('tr', () {
    final cal = TrLocale().calendarDateTime();
    final units = TrLocale().durationUnits();
    final short = TrLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('15:00'), 'Bugün saat 15:00');
      expect(cal.nextDay('15:00'), 'Yarın saat 15:00');
      expect(cal.lastDay('15:00'), 'Dün 15:00');
      expect(
        cal.nextWeek(monday, 'Pazartesi', '15:00'),
        'Gelecek Pazartesi saat 15:00',
      );
      expect(
        cal.lastWeek(sunday, 'Pazar', '15:00'),
        'Geçen Pazar saat 15:00',
      );
    });

    test('duration units', () {
      expect(units.minutes(1), '1 dakika');
      expect(units.days(5), '5 gün');
      expect(units.weeks(2), '2 hafta');
      expect(short.days(5), '5 g');
      expect(short.minutes(5), '5 dk');
    });
  });

  group('uk', () {
    final cal = UkLocale().calendarDateTime();
    final units = UkLocale().durationUnits();
    final short = UkLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('15:00'), 'Сьогодні о 15:00');
      expect(cal.sameDay('11:30'), 'Сьогодні об 11:30');
      expect(cal.nextDay('15:00'), 'Завтра о 15:00');
      expect(cal.lastDay('15:00'), 'Вчора о 15:00');
      expect(
        cal.nextWeek(friday, 'пʼятниця', '15:00'),
        'У пʼятницю о 15:00',
      );
      expect(
        cal.lastWeek(sunday, 'неділя', '15:00'),
        'Минулої неділі о 15:00',
      );
      expect(
        cal.lastWeek(monday, 'понеділок', '15:00'),
        'Минулого понеділка о 15:00',
      );
    });

    test('duration units', () {
      expect(units.minutes(1), '1 хвилина');
      expect(units.minutes(2), '2 хвилини');
      expect(units.minutes(5), '5 хвилин');
      expect(units.minutes(21), '21 хвилина');
      expect(units.hours(1), '1 година');
      expect(units.days(1), '1 день');
      expect(units.days(2), '2 дні');
      expect(units.days(5), '5 днів');
      expect(units.weeks(2), '2 тижні');
      expect(units.weeks(5), '5 тижнів');
      expect(short.days(5), '5 дн.');
      expect(short.minutes(5), '5 хв');
    });
  });

  group('ur', () {
    final cal = UrLocale().calendarDateTime();
    final units = UrLocale().durationUnits();
    final short = UrLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('3:00 PM'), 'آج بوقت 3:00 PM');
      expect(cal.nextDay('3:00 PM'), 'کل بوقت 3:00 PM');
      expect(cal.lastDay('3:00 PM'), 'گذشتہ روز بوقت 3:00 PM');
      expect(cal.nextWeek(monday, 'پیر', '3:00 PM'), 'پیر بوقت 3:00 PM');
      expect(
        cal.lastWeek(sunday, 'اتوار', '3:00 PM'),
        'گذشتہ اتوار بوقت 3:00 PM',
      );
    });

    test('duration units', () {
      expect(units.hours(1), '۱ گھنٹہ');
      expect(units.hours(2), '۲ گھنٹے');
      expect(units.days(5), '۵ دن');
      expect(units.weeks(1), '۱ ہفتہ');
      expect(units.weeks(21), '۲۱ ہفتے');
      expect(short.days(5), '۵ دن');
      expect(short.hours(1), '۱ گھنٹہ');
      expect(short.hours(2), '۲ گھنٹے');
    });
  });

  group('zh', () {
    final cal = ZhLocale().calendarDateTime();
    final units = ZhLocale().durationUnits();
    final short = ZhLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('15:00'), '今天15:00');
      expect(cal.nextDay('15:00'), '明天15:00');
      expect(cal.lastDay('15:00'), '昨天15:00');
      expect(cal.nextWeek(thursday, '星期四', '15:00'), '下周四15:00');
      expect(
        cal.nextWeek(thursday, '星期四', '15:00', isSameWeek: true),
        '本周四15:00',
      );
      expect(cal.lastWeek(sunday, '星期日', '15:00'), '上周日15:00');
      expect(
        cal.lastWeek(sunday, '星期日', '15:00', isSameWeek: true),
        '本周日15:00',
      );
    });

    test('duration units', () {
      expect(units.minutes(5), '5分钟');
      expect(units.hours(2), '2小时');
      expect(units.days(5), '5天');
      expect(units.weeks(1), '1周');
      expect(units.delimiter(), '');
      expect(short.days(5), '5天');
      expect(short.minutes(5), '5分');
    });

    test('zh_CN inherits Simplified strings', () {
      expect(ZhCnLocale().calendarDateTime().sameDay('15:00'), '今天15:00');
      expect(ZhCnLocale().durationUnits().minutes(5), '5分钟');
    });
  });

  group('zh_TW', () {
    final cal = ZhTwLocale().calendarDateTime();
    final units = ZhTwLocale().durationUnits();
    final short = ZhTwLocale().shortDurationUnits();

    test('calendar', () {
      expect(cal.sameDay('下午3:00'), '今天 下午3:00');
      expect(cal.nextDay('下午3:00'), '明天 下午3:00');
      expect(cal.lastDay('下午3:00'), '昨天 下午3:00');
      expect(cal.nextWeek(thursday, '星期四', '下午3:00'), '下星期四 下午3:00');
      expect(
        cal.nextWeek(thursday, '星期四', '下午3:00', isSameWeek: true),
        '星期四 下午3:00',
      );
      expect(cal.lastWeek(sunday, '星期日', '下午3:00'), '上星期日 下午3:00');
      expect(
        cal.lastWeek(sunday, '星期日', '下午3:00', isSameWeek: true),
        '星期日 下午3:00',
      );
    });

    test('duration units', () {
      expect(units.minutes(5), '5分鐘');
      expect(units.hours(2), '2小時');
      expect(units.days(5), '5天');
      expect(units.weeks(2), '2週');
      expect(short.days(5), '5天');
      expect(short.hours(2), '2小時');
    });
  });
}
