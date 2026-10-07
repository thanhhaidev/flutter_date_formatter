import 'package:flutter_date_formatter/flutter_date_formatter.dart';
import 'package:test/test.dart';

// 2025-03-10 is a Monday; the following days run through Sunday 2025-03-16.
final monday = DateTime(2025, 3, 10, 15);
final wednesday = DateTime(2025, 3, 12, 15);
final friday = DateTime(2025, 3, 14, 15);
final saturday = DateTime(2025, 3, 15, 15);
final sunday = DateTime(2025, 3, 16, 15);

void main() {
  group('he', () {
    final calendar = HeLocale().calendarDateTime();
    final units = HeLocale().durationUnits();
    final short = HeLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'היום ב־15:00');
      expect(calendar.nextDay('15:00'), 'מחר ב־15:00');
      expect(calendar.lastDay('15:00'), 'אתמול ב־15:00');
      expect(
        calendar.nextWeek(monday, 'יום שני', '15:00'),
        'יום שני בשעה 15:00',
      );
      expect(
        calendar.lastWeek(monday, 'יום שני', '15:00'),
        'ביום שני האחרון בשעה 15:00',
      );
      expect(
        calendar.lastWeek(saturday, 'יום שבת', '15:00'),
        'ביום שבת האחרון בשעה 15:00',
      );
    });

    test('duration units', () {
      expect(units.seconds(1), 'שנייה אחת');
      expect(units.seconds(5), '5 שניות');
      expect(units.minutes(1), 'דקה אחת');
      expect(units.minutes(2), '2 דקות');
      expect(units.hours(1), 'שעה אחת');
      expect(units.hours(2), 'שעתיים');
      expect(units.hours(5), '5 שעות');
      expect(units.days(1), 'יום אחד');
      expect(units.days(2), 'יומיים');
      expect(units.days(5), '5 ימים');
      expect(units.days(21), '21 ימים');
      expect(units.weeks(2), 'שבועיים');
      expect(units.weeks(5), '5 שבועות');
      expect(units.delimiter(), ' ');
      expect(short.days(5), '5 ימ׳');
      expect(short.hours(2), '2 שע׳');
    });
  });

  group('hi', () {
    final calendar = HiLocale().calendarDateTime();
    final units = HiLocale().durationUnits();
    final short = HiLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('3:00 pm'), 'आज 3:00 pm');
      expect(calendar.nextDay('3:00 pm'), 'कल 3:00 pm');
      expect(calendar.lastDay('3:00 pm'), 'कल 3:00 pm');
      expect(
        calendar.nextWeek(monday, 'सोमवार', '3:00 pm'),
        'सोमवार, 3:00 pm',
      );
      expect(
        calendar.lastWeek(monday, 'सोमवार', '3:00 pm'),
        'पिछले सोमवार, 3:00 pm',
      );
    });

    test('duration units', () {
      expect(units.hours(0), '0 घंटा');
      expect(units.hours(1), '1 घंटा');
      expect(units.hours(2), '2 घंटे');
      expect(units.hours(21), '21 घंटे');
      expect(units.minutes(5), '5 मिनट');
      expect(units.seconds(5), '5 सेकंड');
      expect(units.days(5), '5 दिन');
      expect(units.weeks(2), '2 सप्ताह');
      expect(short.days(5), '5 दि');
      expect(short.minutes(5), '5 मि');
    });
  });

  group('hr', () {
    final calendar = HrLocale().calendarDateTime();
    final units = HrLocale().durationUnits();
    final short = HrLocale().shortDurationUnits();

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
        calendar.lastWeek(DateTime(2025, 3, 10), 'ponedjeljak', '15:00'),
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
      expect(
        calendar.lastWeek(sunday, 'nedjelja', '15:00'),
        'Prošlu nedjelju u 15:00',
      );
    });

    test('duration units', () {
      expect(units.minutes(1), '1 minuta');
      expect(units.minutes(2), '2 minute');
      expect(units.minutes(5), '5 minuta');
      expect(units.minutes(11), '11 minuta');
      expect(units.minutes(21), '21 minuta');
      expect(units.minutes(22), '22 minute');
      expect(units.seconds(1), '1 sekunda');
      expect(units.seconds(2), '2 sekunde');
      expect(units.seconds(5), '5 sekundi');
      expect(units.hours(1), '1 sat');
      expect(units.hours(2), '2 sata');
      expect(units.hours(5), '5 sati');
      expect(units.hours(21), '21 sat');
      expect(units.days(1), '1 dan');
      expect(units.days(5), '5 dana');
      expect(units.days(21), '21 dan');
      expect(units.weeks(1), '1 tjedan');
      expect(units.weeks(2), '2 tjedna');
      expect(units.weeks(5), '5 tjedana');
      expect(units.weeks(101), '101 tjedan');
      expect(short.days(5), '5 d');
      expect(short.weeks(2), '2 tj.');
    });
  });

  group('hu', () {
    final calendar = HuLocale().calendarDateTime();
    final units = HuLocale().durationUnits();
    final short = HuLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'Ma 15:00-kor');
      expect(calendar.nextDay('15:00'), 'Holnap 15:00-kor');
      expect(calendar.lastDay('15:00'), 'Tegnap 15:00-kor');
      expect(calendar.nextWeek(monday, 'hétfő', '15:00'), 'Hétfőn 15:00-kor');
      expect(
        calendar.nextWeek(sunday, 'vasárnap', '15:00'),
        'Vasárnap 15:00-kor',
      );
      expect(
        calendar.lastWeek(monday, 'hétfő', '15:00'),
        'Múlt hétfőn 15:00-kor',
      );
      expect(
        calendar.lastWeek(wednesday, 'szerda', '15:00'),
        'Múlt szerdán 15:00-kor',
      );
      expect(
        calendar.lastWeek(sunday, 'vasárnap', '15:00'),
        'Múlt vasárnap 15:00-kor',
      );
    });

    test('duration units', () {
      expect(units.minutes(1), '1 perc');
      expect(units.minutes(5), '5 perc');
      expect(units.hours(2), '2 óra');
      expect(units.days(5), '5 nap');
      expect(units.weeks(21), '21 hét');
      expect(units.seconds(5), '5 másodperc');
      expect(short.days(5), '5 nap');
      expect(short.seconds(5), '5 mp');
      expect(short.hours(5), '5 ó');
    });
  });

  group('id', () {
    final calendar = IdLocale().calendarDateTime();
    final units = IdLocale().durationUnits();
    final short = IdLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('15.00'), 'Hari ini pukul 15.00');
      expect(calendar.nextDay('15.00'), 'Besok pukul 15.00');
      expect(calendar.lastDay('15.00'), 'Kemarin pukul 15.00');
      expect(
        calendar.nextWeek(monday, 'Senin', '15.00'),
        'Senin pukul 15.00',
      );
      expect(
        calendar.lastWeek(monday, 'Senin', '15.00'),
        'Senin lalu pukul 15.00',
      );
    });

    test('duration units', () {
      expect(units.seconds(5), '5 detik');
      expect(units.minutes(1), '1 menit');
      expect(units.hours(2), '2 jam');
      expect(units.days(5), '5 hari');
      expect(units.weeks(21), '21 minggu');
      expect(short.days(5), '5 h');
      expect(short.minutes(5), '5 mnt');
    });
  });

  group('it', () {
    final calendar = ItLocale().calendarDateTime();
    final units = ItLocale().durationUnits();
    final short = ItLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'Oggi alle 15:00');
      expect(calendar.sameDay('01:00'), "Oggi all'01:00");
      expect(calendar.nextDay('15:00'), 'Domani alle 15:00');
      expect(calendar.lastDay('15:00'), 'Ieri alle 15:00');
      expect(calendar.nextWeek(monday, 'lunedì', '15:00'), 'Lunedì alle 15:00');
      expect(
        calendar.lastWeek(monday, 'lunedì', '15:00'),
        'Lo scorso lunedì alle 15:00',
      );
      expect(
        calendar.lastWeek(sunday, 'domenica', '15:00'),
        'La scorsa domenica alle 15:00',
      );
    });

    test('duration units', () {
      expect(units.minutes(0), '0 minuti');
      expect(units.minutes(1), '1 minuto');
      expect(units.minutes(2), '2 minuti');
      expect(units.hours(1), '1 ora');
      expect(units.hours(5), '5 ore');
      expect(units.days(5), '5 giorni');
      expect(units.days(21), '21 giorni');
      expect(units.weeks(1), '1 settimana');
      expect(units.weeks(2), '2 settimane');
      expect(units.seconds(1000000), '1000000 di secondi');
      expect(short.days(5), '5 g');
      expect(short.weeks(2), '2 sett.');
    });
  });

  group('ja', () {
    final calendar = JaLocale().calendarDateTime();
    final units = JaLocale().durationUnits();
    final short = JaLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('15:00'), '今日 15:00');
      expect(calendar.nextDay('15:00'), '明日 15:00');
      expect(calendar.lastDay('15:00'), '昨日 15:00');
      expect(calendar.nextWeek(monday, '月曜日', '15:00'), '来週月曜日 15:00');
      expect(calendar.nextWeek(friday, '金曜日', '15:00'), '来週金曜日 15:00');
      expect(
        calendar.nextWeek(friday, '金曜日', '15:00', isSameWeek: true),
        '金曜日 15:00',
      );
      expect(calendar.lastWeek(monday, '月曜日', '15:00'), '先週月曜日 15:00');
      expect(
        calendar.lastWeek(monday, '月曜日', '15:00', isSameWeek: true),
        '月曜日 15:00',
      );
      expect(calendar.lastWeek(friday, '金曜日', '15:00'), '先週金曜日 15:00');
    });

    test('duration units', () {
      expect(units.seconds(5), '5秒');
      expect(units.minutes(1), '1分');
      expect(units.hours(2), '2時間');
      expect(units.days(5), '5日');
      expect(units.weeks(21), '21週間');
      expect(units.delimiter(), '');
      expect(short.days(5), '5日');
      expect(short.weeks(2), '2週');
    });
  });

  group('ka', () {
    final calendar = KaLocale().calendarDateTime();
    final units = KaLocale().durationUnits();
    final short = KaLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'დღეს 15:00-ზე');
      expect(calendar.nextDay('15:00'), 'ხვალ 15:00-ზე');
      expect(calendar.lastDay('15:00'), 'გუშინ 15:00-ზე');
      expect(
        calendar.nextWeek(monday, 'ორშაბათი', '15:00'),
        'შემდეგ ორშაბათს 15:00-ზე',
      );
      expect(
        calendar.lastWeek(sunday, 'კვირა', '15:00'),
        'წინა კვირას 15:00-ზე',
      );
    });

    test('duration units', () {
      expect(units.seconds(5), '5 წამი');
      expect(units.minutes(1), '1 წუთი');
      expect(units.hours(2), '2 საათი');
      expect(units.days(5), '5 დღე');
      expect(units.weeks(21), '21 კვირა');
      expect(short.days(5), '5 დღ');
      expect(short.minutes(5), '5 წთ');
    });
  });

  group('km', () {
    final calendar = KmLocale().calendarDateTime();
    final units = KmLocale().durationUnits();
    final short = KmLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'ថ្ងៃនេះ ម៉ោង 15:00');
      expect(calendar.nextDay('15:00'), 'ស្អែក ម៉ោង 15:00');
      expect(calendar.lastDay('15:00'), 'ម្សិលមិញ ម៉ោង 15:00');
      expect(calendar.nextWeek(monday, 'ចន្ទ', '15:00'), 'ចន្ទ ម៉ោង 15:00');
      expect(
        calendar.lastWeek(monday, 'ចន្ទ', '15:00'),
        'ចន្ទ សប្តាហ៍មុន ម៉ោង 15:00',
      );
    });

    test('duration units', () {
      expect(units.seconds(5), '5 វិនាទី');
      expect(units.minutes(1), '1 នាទី');
      expect(units.hours(2), '2 ម៉ោង');
      expect(units.days(5), '5 ថ្ងៃ');
      expect(units.weeks(21), '21 សប្តាហ៍');
      expect(short.days(5), '5 ថ្ងៃ');
      expect(short.seconds(5), '5 វិ');
    });
  });

  group('ko', () {
    final calendar = KoLocale().calendarDateTime();
    final units = KoLocale().durationUnits();
    final short = KoLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('오후 3:00'), '오늘 오후 3:00');
      expect(calendar.nextDay('오후 3:00'), '내일 오후 3:00');
      expect(calendar.lastDay('오후 3:00'), '어제 오후 3:00');
      expect(
        calendar.nextWeek(monday, '월요일', '오후 3:00'),
        '다음 주 월요일 오후 3:00',
      );
      expect(
        calendar.nextWeek(monday, '월요일', '오후 3:00', isSameWeek: true),
        '월요일 오후 3:00',
      );
      expect(
        calendar.lastWeek(monday, '월요일', '오후 3:00'),
        '지난주 월요일 오후 3:00',
      );
    });

    test('duration units', () {
      expect(units.seconds(5), '5초');
      expect(units.minutes(1), '1분');
      expect(units.hours(2), '2시간');
      expect(units.days(5), '5일');
      expect(units.weeks(21), '21주');
      expect(units.delimiter(), ' ');
      expect(short.days(5), '5일');
    });
  });

  group('ku', () {
    final calendar = KuLocale().calendarDateTime();
    final units = KuLocale().durationUnits();
    final short = KuLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'ئەمڕۆ کاتژمێر 15:00');
      expect(calendar.nextDay('15:00'), 'بەیانی کاتژمێر 15:00');
      expect(calendar.lastDay('15:00'), 'دوێنێ کاتژمێر 15:00');
      expect(
        calendar.nextWeek(monday, 'Monday', '15:00'),
        'دووشەممە کاتژمێر 15:00',
      );
      expect(
        calendar.lastWeek(monday, 'Monday', '15:00'),
        'دووشەممەی ڕابردوو کاتژمێر 15:00',
      );
    });

    test('duration units', () {
      expect(units.seconds(5), '5 چرکە');
      expect(units.minutes(1), '1 خولەک');
      expect(units.hours(2), '2 کاتژمێر');
      expect(units.days(5), '5 ڕۆژ');
      expect(units.weeks(21), '21 هەفتە');
      expect(short.days(5), '5 ڕۆژ');
    });
  });

  group('lv', () {
    final calendar = LvLocale().calendarDateTime();
    final units = LvLocale().durationUnits();
    final short = LvLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'Šodien pulksten 15:00');
      expect(calendar.nextDay('15:00'), 'Rīt pulksten 15:00');
      expect(calendar.lastDay('15:00'), 'Vakar pulksten 15:00');
      expect(
        calendar.nextWeek(monday, 'Pirmdiena', '15:00'),
        'Pirmdien pulksten 15:00',
      );
      expect(
        calendar.lastWeek(monday, 'Pirmdiena', '15:00'),
        'Pagājušajā pirmdienā pulksten 15:00',
      );
      expect(
        calendar.lastWeek(sunday, 'Svētdiena', '15:00'),
        'Pagājušajā svētdienā pulksten 15:00',
      );
    });

    test('duration units', () {
      expect(units.minutes(0), '0 minūšu');
      expect(units.minutes(1), '1 minūte');
      expect(units.minutes(2), '2 minūtes');
      expect(units.minutes(11), '11 minūšu');
      expect(units.minutes(21), '21 minūte');
      expect(units.hours(1), '1 stunda');
      expect(units.hours(5), '5 stundas');
      expect(units.days(5), '5 dienas');
      expect(units.days(21), '21 diena');
      expect(units.days(10), '10 dienu');
      expect(units.hours(15), '15 stundu');
      expect(units.weeks(101), '101 nedēļa');
      expect(units.seconds(2), '2 sekundes');
      expect(short.days(5), '5 d.');
      expect(short.weeks(2), '2 ned.');
    });
  });

  group('mn', () {
    final calendar = MnLocale().calendarDateTime();
    final units = MnLocale().durationUnits();
    final short = MnLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'Өнөөдөр 15:00');
      expect(calendar.nextDay('15:00'), 'Маргааш 15:00');
      expect(calendar.lastDay('15:00'), 'Өчигдөр 15:00');
      expect(calendar.nextWeek(monday, 'Даваа', '15:00'), 'Ирэх Даваа 15:00');
      expect(
        calendar.lastWeek(monday, 'Даваа', '15:00'),
        'Өнгөрсөн Даваа 15:00',
      );
    });

    test('duration units', () {
      expect(units.seconds(5), '5 секунд');
      expect(units.minutes(1), '1 минут');
      expect(units.hours(2), '2 цаг');
      expect(units.days(5), '5 өдөр');
      expect(units.weeks(21), '21 долоо хоног');
      expect(short.days(5), '5 өдөр');
      expect(short.hours(5), '5 ц');
    });
  });

  group('ms_my', () {
    final calendar = MsMyLocale().calendarDateTime();
    final units = MsMyLocale().durationUnits();
    final short = MsMyLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('3:00 PTG'), 'Hari ini pukul 3:00 PTG');
      expect(calendar.nextDay('3:00 PTG'), 'Esok pukul 3:00 PTG');
      expect(calendar.lastDay('3:00 PTG'), 'Kelmarin pukul 3:00 PTG');
      expect(
        calendar.nextWeek(monday, 'Isnin', '3:00 PTG'),
        'Isnin pukul 3:00 PTG',
      );
      expect(
        calendar.lastWeek(monday, 'Isnin', '3:00 PTG'),
        'Isnin lepas pukul 3:00 PTG',
      );
    });

    test('duration units', () {
      expect(units.seconds(5), '5 saat');
      expect(units.minutes(1), '1 minit');
      expect(units.hours(2), '2 jam');
      expect(units.days(5), '5 hari');
      expect(units.weeks(21), '21 minggu');
      expect(short.days(5), '5 h');
      expect(short.weeks(2), '2 mgu');
    });
  });

  group('my', () {
    final calendar = MyLocale().calendarDateTime();
    final units = MyLocale().durationUnits();
    final short = MyLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('၁၅:၀၀'), 'ယနေ့ ၁၅:၀၀ မှာ');
      expect(calendar.nextDay('၁၅:၀၀'), 'မနက်ဖြန် ၁၅:၀၀ မှာ');
      expect(calendar.lastDay('၁၅:၀၀'), 'မနေ့က ၁၅:၀၀ မှာ');
      expect(
        calendar.nextWeek(monday, 'တနင်္လာ', '၁၅:၀၀'),
        'တနင်္လာ ၁၅:၀၀ မှာ',
      );
      expect(
        calendar.lastWeek(monday, 'တနင်္လာ', '၁၅:၀၀'),
        'ပြီးခဲ့သော တနင်္လာ ၁၅:၀၀ မှာ',
      );
    });

    test('duration units', () {
      expect(units.seconds(5), '၅ စက္ကန့်');
      expect(units.minutes(1), '၁ မိနစ်');
      expect(units.hours(2), '၂ နာရီ');
      expect(units.days(5), '၅ ရက်');
      expect(units.weeks(21), '၂၁ ပတ်');
      expect(short.days(5), '၅ရက်');
      expect(short.hours(2), '၂နာရီ');
    });
  });

  group('nb', () {
    final calendar = NbLocale().calendarDateTime();
    final units = NbLocale().durationUnits();
    final short = NbLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'I dag kl. 15:00');
      expect(calendar.nextDay('15:00'), 'I morgen kl. 15:00');
      expect(calendar.lastDay('15:00'), 'I går kl. 15:00');
      expect(calendar.nextWeek(monday, 'mandag', '15:00'), 'Mandag kl. 15:00');
      expect(
        calendar.lastWeek(monday, 'mandag', '15:00'),
        'Forrige mandag kl. 15:00',
      );
    });

    test('duration units', () {
      expect(units.seconds(1), '1 sekund');
      expect(units.seconds(5), '5 sekunder');
      expect(units.minutes(1), '1 minutt');
      expect(units.minutes(2), '2 minutter');
      expect(units.hours(1), '1 time');
      expect(units.hours(5), '5 timer');
      expect(units.days(1), '1 dag');
      expect(units.days(5), '5 dager');
      expect(units.days(21), '21 dager');
      expect(units.weeks(1), '1 uke');
      expect(units.weeks(2), '2 uker');
      expect(short.days(5), '5 d');
      expect(short.hours(5), '5 t');
    });
  });

  group('nl', () {
    final calendar = NlLocale().calendarDateTime();
    final units = NlLocale().durationUnits();
    final short = NlLocale().shortDurationUnits();

    test('calendar', () {
      expect(calendar.sameDay('15:00'), 'Vandaag om 15:00');
      expect(calendar.nextDay('15:00'), 'Morgen om 15:00');
      expect(calendar.lastDay('15:00'), 'Gisteren om 15:00');
      expect(calendar.nextWeek(monday, 'maandag', '15:00'), 'Maandag om 15:00');
      expect(
        calendar.lastWeek(monday, 'maandag', '15:00'),
        'Afgelopen maandag om 15:00',
      );
    });

    test('duration units', () {
      expect(units.seconds(1), '1 seconde');
      expect(units.seconds(5), '5 seconden');
      expect(units.minutes(1), '1 minuut');
      expect(units.minutes(2), '2 minuten');
      expect(units.hours(1), '1 uur');
      expect(units.hours(5), '5 uur');
      expect(units.days(1), '1 dag');
      expect(units.days(5), '5 dagen');
      expect(units.days(21), '21 dagen');
      expect(units.weeks(1), '1 week');
      expect(units.weeks(2), '2 weken');
      expect(short.days(5), '5 d');
      expect(short.hours(5), '5 u');
    });
  });
}
