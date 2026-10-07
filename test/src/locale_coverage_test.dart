import 'package:flutter_date_formatter/flutter_date_formatter.dart';
import 'package:test/test.dart';

/// Checks that [text] is non-empty, trimmed, single-spaced and has no
/// leftover moment.js escape brackets.
void _expectClean(String text, String reason) {
  expect(text, isNotEmpty, reason: reason);
  expect(text.trim(), text, reason: '$reason: untrimmed "$text"');
  expect(text, isNot(contains('  ')), reason: '$reason: double space "$text"');
  expect(text, isNot(contains(RegExp(r'[\[\]]'))), reason: '$reason: "$text"');
}

void main() {
  final clock = DateTime(2025, 3, 12, 12); // Wednesday
  final locales = SupportedLocalesUtils.getSupportedRelativeLocales();

  for (final code in locales) {
    group(code, () {
      final locale = SupportedLocalesUtils.getRelativeLocale(code);

      test('has calendar and duration strings', () {
        expect(locale.calendarDateTime(), isNotNull);
        expect(locale.durationUnits(), isNotNull);
        expect(locale.shortDurationUnits(), isNotNull);
      });

      test('formatCalendar gives clean text for every range', () {
        for (var offset = -7; offset <= 7; offset++) {
          final date = clock.addDays(offset).copyWith(hour: 15);
          _expectClean(
            date.formatCalendar(clock: clock, locale: code),
            'day offset $offset',
          );
        }
      });

      test('humanize gives clean text for every unit and count', () {
        for (final short in [false, true]) {
          final units =
              short ? locale.shortDurationUnits() : locale.durationUnits();
          if (units == null) continue;
          for (final n in [0, 1, 2, 5, 11, 21, 22, 25, 101]) {
            for (final text in [
              units.seconds(n),
              units.minutes(n),
              units.hours(n),
              units.days(n),
              units.weeks(n),
            ]) {
              _expectClean(text, 'short: $short, n: $n');
            }
          }
          _expectClean(
            const Duration(days: 2, hours: 3)
                .humanize(locale: code, short: short),
            'humanize, short: $short',
          );
        }
      });
    });
  }
}
