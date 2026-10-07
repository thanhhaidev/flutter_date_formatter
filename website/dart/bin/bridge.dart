// Exposes flutter_date_formatter to the docs site as
// `globalThis.dateFormatter.call(method, argsJson) → resultJson`.
//
// Build: dart compile js -O2 -o ../static/js/date_formatter.js bin/bridge.dart
import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter_date_formatter/flutter_date_formatter.dart';

void main() {
  final api = JSObject()
    ..setProperty('call'.toJS, _call.toJS)
    ..setProperty('ready'.toJS, true.toJS);
  globalContext.setProperty('dateFormatter'.toJS, api);
  if (globalContext.has('dispatchEvent')) {
    globalContext.callMethod('dispatchEvent'.toJS, _readyEvent());
  }
}

@JS('Event')
extension type _Event._(JSObject _) implements JSObject {
  external factory _Event(String type);
}

JSObject _readyEvent() => _Event('date-formatter-ready');

String _call(String method, String argsJson) {
  try {
    final args = (jsonDecode(argsJson) as Map).cast<String, Object?>();
    return jsonEncode({'value': _dispatch(method, _Args(args))});
  } on FormatException catch (error) {
    // The message alone: toString() also prints the source text.
    return jsonEncode({'error': error.message});
  } catch (error) {
    return jsonEncode({'error': '$error'});
  }
}

class _Args {
  _Args(this._map);

  final Map<String, Object?> _map;

  String? str(String key) {
    final value = _map[key];
    return value == null || value == '' ? null : '$value';
  }

  bool flag(String key) => _map[key] == true;

  int integer(String key, [int fallback = 0]) =>
      (_map[key] as num?)?.toInt() ?? fallback;

  DateTime date(String key) => DateTime.parse(str(key)!);

  DateTime? maybeDate(String key) {
    final value = str(key);
    return value == null ? null : DateTime.parse(value);
  }

  Unit unit(String key, [Unit fallback = Unit.day]) {
    final name = str(key);
    return name == null ? fallback : Unit.values.byName(name);
  }
}

String _iso(DateTime date) {
  final local = date.toIso8601String();
  return local.length > 19 && !date.isUtc ? local.substring(0, 19) : local;
}

Object? _dispatch(String method, _Args a) {
  // Per-call settings: clock and first day of the week.
  DateFormatterConfig.reset();
  final now = a.maybeDate('now');
  final startOfWeek = a.str('startOfWeek');
  DateFormatterConfig.configure(
    clock: now == null ? null : () => now,
    startOfWeek:
        startOfWeek == null ? null : StartOfWeek.values.byName(startOfWeek),
  );
  final locale = a.str('locale');

  switch (method) {
    case 'locales':
      return {
        'all': SupportedLocalesUtils.getSupportedRelativeLocales()..sort(),
        'pattern': SupportedLocalesUtils.getSupportedLocales(),
      };

    case 'format':
      return a
          .date('date')
          .format(pattern: a.str('pattern') ?? '', locale: locale);

    case 'ordinal':
      return FlutterDateFormatter.ordinal(a.integer('n'), locale: locale);

    case 'relative':
      return a.date('date').formatRelative(
            clock: a.maybeDate('clock') ?? now,
            locale: locale,
            short: a.flag('short'),
            withPrefixAndSuffix: a._map['withPrefixAndSuffix'] != false,
          );

    case 'relativeHelpers':
      final date = a.date('date');
      final other = a.date('other');
      return {
        'formatFromNow': date.formatFromNow(locale: locale),
        'formatToNow': date.formatToNow(locale: locale),
        'formatFrom': date.formatFrom(clock: other, locale: locale),
        'formatTo': date.formatTo(clock: other, locale: locale),
      };

    case 'calendar':
      return a.date('date').formatCalendar(
            clock: a.maybeDate('clock') ?? now,
            locale: locale,
            timePattern: a.str('timePattern'),
            datePattern: a.str('datePattern'),
          );

    case 'humanize':
      return Duration(milliseconds: a.integer('milliseconds')).humanize(
        locale: locale,
        short: a.flag('short'),
        maxUnits: a.integer('maxUnits', 2),
        largestUnit: a.unit('largestUnit', Unit.day),
        smallestUnit: a.unit('smallestUnit', Unit.second),
        delimiter: a.str('delimiter'),
      );

    case 'parse':
      final formatter = FlutterDateFormatter(a.str('pattern'), locale);
      final date = formatter.parse(
        a.str('input') ?? '',
        strict: a.flag('strict'),
        utc: a.flag('utc'),
      );
      return {
        'iso': _iso(date),
        'isUtc': date.isUtc,
        'formatted': formatter.format(date)
      };

    case 'properties':
      final d = a.date('date');
      return {
        'isToday': d.isToday,
        'isYesterday': d.isYesterday,
        'isTomorrow': d.isTomorrow,
        'isPast': d.isPast,
        'isFuture': d.isFuture,
        'isWeekend': d.isWeekend,
        'isLeapYear': d.isLeapYear,
        'dayOfWeek': d.dayOfWeek,
        'dayOfYear': d.dayOfYear,
        'daysInMonth': d.daysInMonth,
        'weekOfYear': d.weekOfYear,
        'quarterOfYear': d.quarterOfYear,
        'startOfWeek': _iso(d.startOfWeek),
        'endOfWeek': _iso(d.endOfWeek),
        'startOfMonth': _iso(d.startOfMonth),
        'endOfMonth': _iso(d.endOfMonth),
        'startOfQuarter': _iso(d.startOfQuarter),
        'endOfQuarter': _iso(d.endOfQuarter),
        'startOfYear': _iso(d.startOfYear),
        'endOfYear': _iso(d.endOfYear),
      };

    case 'arithmetic':
      final d = a.date('date');
      final unit = a.unit('unit');
      final amount = a.integer('amount');
      DateTime shift(int n) => switch (unit) {
            Unit.microsecond => d.addMicroseconds(n),
            Unit.millisecond => d.addMilliseconds(n),
            Unit.second => d.addSeconds(n),
            Unit.minute => d.addMinutes(n),
            Unit.hour => d.addHours(n),
            Unit.day => d.addDays(n),
            Unit.week => d.addWeeks(n),
            Unit.month => d.addMonths(n),
            Unit.year => d.addYears(n),
          };
      return {
        'add': _iso(shift(amount)),
        'subtract': _iso(shift(-amount)),
        'startOf': _iso(d.startOf(unit)),
        'endOf': _iso(d.endOf(unit)),
      };

    case 'compare':
      final d = a.date('date');
      final other = a.date('other');
      final unit = a.unit('unit');
      return {
        'diff': other.diff(d, unit: unit, asFloat: a.flag('asFloat')),
        'isSame': d.isSame(other, unit: unit),
        'isBeforeDate': d.isBeforeDate(other, unit: unit),
        'isAfterDate': d.isAfterDate(other, unit: unit),
        'isSameOrBefore': d.isSameOrBefore(other, unit: unit),
      };

    case 'timeSpan':
      final x = TimeSpan(a.date('aStart'), a.date('aEnd'));
      final y = TimeSpan(a.date('bStart'), a.date('bEnd'));
      List<String>? span(TimeSpan? s) =>
          s == null ? null : [_iso(s.start), _iso(s.end)];
      Object? merge;
      try {
        merge = span(x.merge(y));
      } on RangeError catch (error) {
        merge = '${error.message}';
      }
      return {
        'totalDuration': x.totalDuration.humanize(maxUnits: 3, locale: locale),
        'intersects': x.intersects(y),
        'containsTimeSpan': x.containsTimeSpan(y),
        'intersection': span(x.getIntersection(y)),
        'merge': merge,
        'differences': [for (final s in x.getDifferences(y)) span(s)],
        'symmetricDifference': [
          for (final s in x.symmetricDifference(y)) span(s)
        ],
        'equals': x == y,
      };

    case 'iterate':
      return [
        for (final d in a
            .date('start')
            .rangeTo(
              a.date('end'),
              unit: a.unit('unit'),
              step: a.integer('step', 1),
            )
            .take(a.integer('limit', 60)))
          _iso(d),
      ];

    case 'clamp':
      final dates = [
        for (final key in ['aStart', 'aEnd', 'bStart', 'bEnd']) a.date(key)
      ];
      return {
        'bStartClamped': _iso(dates[2].clamp(dates[0], dates[1])),
        'bEndClamped': _iso(dates[3].clamp(dates[0], dates[1])),
        'earliest': _iso(dates.earliest!),
        'latest': _iso(dates.latest!),
      };

    case 'localeRow':
      final n = now ?? DateTime.now();
      return {
        'format': n.format(pattern: 'do MMMM yyyy', locale: locale),
        'relative': n.subDays(3).formatRelative(clock: n, locale: locale),
        'calendar': n
            .subDays(1)
            .copyWith(hour: 15, minute: 0)
            .formatCalendar(clock: n, locale: locale),
        'duration':
            const Duration(hours: 2, minutes: 5).humanize(locale: locale),
        'ordinal': FlutterDateFormatter.ordinal(21, locale: locale),
      };

    default:
      throw ArgumentError.value(method, 'method', 'Unknown method');
  }
}
