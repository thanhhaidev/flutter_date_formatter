import React, {useEffect, useState} from 'react';
import {addDays, fromLocalIso, showIso, toLocalIso} from '@site/src/lib/dateFormatter';
import {
  Chips,
  DateInput,
  NumberInput,
  Output,
  Playground,
  ResultTable,
  Select,
  Switch,
  TextInput,
  playgroundStyles as styles,
  text,
  usePlayground,
} from './index';

const UNITS = ['microsecond', 'millisecond', 'second', 'minute', 'hour', 'day', 'week', 'month', 'year'] as const;
type UnitName = (typeof UNITS)[number];
const DURATION_UNITS = ['week', 'day', 'hour', 'minute', 'second'] as const;

/** `DateTime(2025, 3, 12, 15, 30)` for code samples. */
function dartDate(iso: string): string {
  const d = fromLocalIso(iso);
  const parts = [d.getFullYear(), d.getMonth() + 1, d.getDate()];
  if (d.getHours() || d.getMinutes() || d.getSeconds()) parts.push(d.getHours());
  if (d.getMinutes() || d.getSeconds()) parts.push(d.getMinutes());
  if (d.getSeconds()) parts.push(d.getSeconds());
  return `DateTime(${parts.join(', ')})`;
}

const q = (s: string) => `'${s.replace(/'/g, "\\'")}'`;

/* ---------------------------------------------------------------- Formatting */

const PATTERNS = ['do MMMM yyyy', 'EEEE, do MMM', '[Today is] EEEE', 'yMd', 'yMMMMEEEEd', 'HH:mm:ss', 'jm', 'QQQ y', "dd/MM/yyyy 'at' HH:mm"];

export function FormatDemo() {
  const p = usePlayground();
  const [pattern, setPattern] = useState('do MMMM yyyy');
  const [date, setDate] = useState<string | null>(null);
  const value = date ?? p.now;
  return (
    <Playground
      controls={
        <>
          <TextInput label="pattern" value={pattern} onChange={setPattern} width={260} />
          <DateInput label="date" value={value} onChange={setDate} />
          <Chips values={PATTERNS} selected={pattern} onSelect={setPattern} />
        </>
      }
      output={<Output result={p.call('format', {date: value, pattern})} />}
      code={`final date = ${dartDate(value)};\n\ndate.format(pattern: ${q(pattern)}, locale: ${q(p.locale)});\n\n// or keep one formatter and reuse it\nfinal formatter = FlutterDateFormatter(${q(pattern)}, ${q(p.locale)});\nformatter.format(date);`}
    />
  );
}

export function OrdinalDemo() {
  const p = usePlayground();
  const numbers = [1, 2, 3, 4, 11, 12, 13, 21, 22, 23, 101];
  return (
    <Playground
      output={
        <ResultTable
          header={['n', `FlutterDateFormatter.ordinal(n, locale: '${p.locale}')`]}
          rows={numbers.map((n) => [String(n), text(p.call('ordinal', {n}))])}
        />
      }
      code={`FlutterDateFormatter.ordinal(21, locale: ${q(p.locale)});\ndate.formatOrdinalNumber(locale: ${q(p.locale)}); // day of the month`}
    />
  );
}

/* ------------------------------------------------------------ Relative time */

const OFFSETS: [string, number][] = [
  ['-10s', -10], ['-1m', -60], ['-5m', -300], ['-1h', -3600], ['-5h', -18000], ['-1d', -86400],
  ['-3d', -259200], ['-40d', -3456000], ['-5mo', -12960000], ['-1y', -34560000], ['-3y', -95040000],
  ['+5m', 300], ['+2h', 7200], ['+3d', 259200], ['+2mo', 5356800],
];

function shiftSeconds(iso: string, seconds: number): string {
  return toLocalIso(new Date(fromLocalIso(iso).getTime() + seconds * 1000));
}

export function RelativeDemo() {
  const p = usePlayground();
  const [offset, setOffset] = useState('-5h');
  const [short, setShort] = useState(false);
  const [affixes, setAffixes] = useState(true);
  const date = shiftSeconds(p.now, OFFSETS.find(([label]) => label === offset)![1]);
  const args = {clock: p.now, short, withPrefixAndSuffix: affixes};
  const options = [`clock: now`, `locale: ${q(p.locale)}`, ...(short ? ['short: true'] : []), ...(affixes ? [] : ['withPrefixAndSuffix: false'])];
  return (
    <Playground
      controls={
        <>
          <Chips values={OFFSETS.map(([label]) => label)} selected={offset} onSelect={setOffset} />
          <Switch label="short" value={short} onChange={setShort} />
          <Switch label="withPrefixAndSuffix" value={affixes} onChange={setAffixes} />
        </>
      }
      output={
        <>
          <Output result={p.call('relative', {date, ...args})} />
          <div style={{height: 14}} />
          <ResultTable
            header={['offset', 'formatRelative()']}
            rows={OFFSETS.map(([label, seconds]) => [label, text(p.call('relative', {date: shiftSeconds(p.now, seconds), ...args}))])}
          />
        </>
      }
      code={`final now = ${dartDate(p.now)};\nfinal date = ${dartDate(date)};\n\ndate.formatRelative(${options.join(', ')});`}
    />
  );
}

export function RelativeHelpersDemo() {
  const p = usePlayground();
  const date = shiftSeconds(p.now, -5 * 3600);
  const other = addDays(p.now, 2);
  const r = p.call<Record<string, string>>('relativeHelpers', {date, other});
  return (
    <Playground
      output={
        <ResultTable
          rows={[
            ['date.formatFromNow()', r.value?.formatFromNow ?? text(r)],
            ['date.formatToNow()', r.value?.formatToNow ?? text(r)],
            ['date.formatFrom(clock: in2Days)', r.value?.formatFrom ?? text(r)],
            ['date.formatTo(clock: in2Days)', r.value?.formatTo ?? text(r)],
          ]}
        />
      }
      code={`final date = DateTime.now().subHours(5);\nfinal in2Days = DateTime.now().addDays(2);\n\ndate.formatFromNow(locale: ${q(p.locale)});\ndate.formatToNow(locale: ${q(p.locale)});\ndate.formatFrom(clock: in2Days, locale: ${q(p.locale)});\ndate.formatTo(clock: in2Days, locale: ${q(p.locale)});`}
    />
  );
}

/* ----------------------------------------------------------------- Calendar */

export function CalendarDemo() {
  const p = usePlayground();
  const [timePattern, setTimePattern] = useState('');
  const [datePattern, setDatePattern] = useState('');
  const options = [...(timePattern ? [`timePattern: ${q(timePattern)}`] : []), ...(datePattern ? [`datePattern: ${q(datePattern)}`] : [])];
  const today = p.call('format', {date: p.now, pattern: 'EEEE, d MMMM y'});
  const rows: [string, string][] = [];
  for (let offset = -8; offset <= 8; offset++) {
    const date = addDays(p.now, offset, 15, 30);
    rows.push([
      offset === 0 ? 'today' : `${offset > 0 ? '+' : ''}${offset} days`,
      text(p.call('calendar', {date, clock: p.now, timePattern, datePattern})),
    ]);
  }
  return (
    <Playground
      controls={
        <>
          <TextInput label="timePattern (optional)" placeholder="e.g. HH:mm" value={timePattern} onChange={setTimePattern} />
          <TextInput label="datePattern (optional)" placeholder="e.g. do MMMM yyyy" value={datePattern} onChange={setDatePattern} />
        </>
      }
      output={
        <>
          <p style={{margin: '0 0 0.8rem', color: 'var(--asx-muted)'}}>Today is {text(today)}.</p>
          <ResultTable header={['day', 'formatCalendar()']} rows={rows} />
        </>
      }
      code={`date.formatCalendar(clock: now, locale: ${q(p.locale)}${options.length ? `, ${options.join(', ')}` : ''});`}
    />
  );
}

/* ---------------------------------------------------------------- Durations */

export function DurationDemo() {
  const p = usePlayground();
  const [days, setDays] = useState(1);
  const [hours, setHours] = useState(2);
  const [minutes, setMinutes] = useState(5);
  const [seconds, setSeconds] = useState(9);
  const [maxUnits, setMaxUnits] = useState(2);
  const [largest, setLargest] = useState<(typeof DURATION_UNITS)[number]>('day');
  const [smallest, setSmallest] = useState<(typeof DURATION_UNITS)[number]>('second');
  const [short, setShort] = useState(false);
  const [delimiter, setDelimiter] = useState('');
  const milliseconds = (((days * 24 + hours) * 60 + minutes) * 60 + seconds) * 1000;
  const args = [
    `locale: ${q(p.locale)}`,
    ...(short ? ['short: true'] : []),
    ...(maxUnits !== 2 ? [`maxUnits: ${maxUnits}`] : []),
    ...(largest !== 'day' ? [`largestUnit: Unit.${largest}`] : []),
    ...(smallest !== 'second' ? [`smallestUnit: Unit.${smallest}`] : []),
    ...(delimiter ? [`delimiter: ${q(delimiter)}`] : []),
  ];
  return (
    <Playground
      controls={
        <>
          <NumberInput label="days" value={days} onChange={setDays} />
          <NumberInput label="hours" value={hours} onChange={setHours} />
          <NumberInput label="minutes" value={minutes} onChange={setMinutes} />
          <NumberInput label="seconds" value={seconds} onChange={setSeconds} />
          <Select label="maxUnits" value={maxUnits} options={[1, 2, 3, 4, 5]} onChange={setMaxUnits} width={100} />
          <Select label="largestUnit" value={largest} options={DURATION_UNITS} onChange={setLargest} width={120} />
          <Select label="smallestUnit" value={smallest} options={DURATION_UNITS} onChange={setSmallest} width={120} />
          <TextInput label="delimiter" placeholder="locale default" value={delimiter} onChange={setDelimiter} width={130} />
          <Switch label="short" value={short} onChange={setShort} />
        </>
      }
      output={
        <Output
          result={p.call('humanize', {milliseconds, short, maxUnits, largestUnit: largest, smallestUnit: smallest, delimiter})}
        />
      }
      code={`const duration = Duration(days: ${days}, hours: ${hours}, minutes: ${minutes}, seconds: ${seconds});\n\nduration.humanize(${args.join(', ')});`}
    />
  );
}

export function PluralDemo() {
  const p = usePlayground();
  const one = (unit: string, n: number, short = false) =>
    text(p.call('humanize', {milliseconds: n * {minute: 60e3, hour: 36e5, day: 864e5}[unit]!, largestUnit: unit, smallestUnit: unit, short}));
  return (
    <Playground
      output={
        <ResultTable
          header={['n', 'minutes · hours · days (short)']}
          rows={[0, 1, 2, 5, 11, 21, 22].map((n) => [
            String(n),
            `${one('minute', n)} · ${one('hour', n)} · ${one('day', n)}   (${one('day', n, true)})`,
          ])}
        />
      }
    />
  );
}

/* ------------------------------------------------------------------ Parsing */

const PARSE_PATTERNS = ['do MMMM yyyy', 'yyyy-MM-dd HH:mm', "dd/MM/yyyy 'at' HH:mm", '[Day] d, MMMM yyyy', 'EEEE, do MMM y'];
const PARSE_SAMPLE = '2025-03-21T14:30:00';
const STRICT_EXAMPLE = 'Feb 30 + strict';

export function ParseDemo() {
  const p = usePlayground();
  const [pattern, setPattern] = useState('do MMMM yyyy');
  // null: a sample date formatted in the current locale, so it always parses.
  const [typed, setTyped] = useState<string | null>(null);
  const [strict, setStrict] = useState(false);
  const [utc, setUtc] = useState(false);

  // A new locale needs a new sample input.
  useEffect(() => setTyped(null), [p.locale]);

  const sample = p.call<string>('format', {date: PARSE_SAMPLE, pattern});
  const input = typed ?? sample.value ?? '';
  const options = [...(strict ? ['strict: true'] : []), ...(utc ? ['utc: true'] : [])];
  const result = p.call<{iso: string; isUtc: boolean; formatted: string}>('parse', {pattern, input, strict, utc});
  return (
    <Playground
      controls={
        <>
          <TextInput label="pattern" value={pattern} onChange={setPattern} />
          <TextInput label={typed === null ? 'input (sample in this locale)' : 'input'} value={input} onChange={setTyped} width={280} />
          <Switch label="strict" value={strict} onChange={setStrict} />
          <Switch label="utc" value={utc} onChange={setUtc} />
          <Chips
            values={[...PARSE_PATTERNS, STRICT_EXAMPLE]}
            selected={typed === null ? pattern : undefined}
            onSelect={(value) => {
              if (value === STRICT_EXAMPLE) {
                setPattern('dd/MM/yyyy');
                setTyped('30/02/2025');
                setStrict(true);
              } else {
                setPattern(value);
                setTyped(null);
              }
            }}
          />
        </>
      }
      output={
        <Output
          result={result}
          render={(v) => {
            const value = v as {iso: string; isUtc: boolean; formatted: string};
            return `${showIso(value.iso)}${value.isUtc ? ' UTC' : ''}   →   format again: ${value.formatted}`;
          }}
        />
      }
      code={`final formatter = FlutterDateFormatter(${q(pattern)}, ${q(p.locale)});\n\nformatter.parse(${q(input)}${options.length ? `, ${options.join(', ')}` : ''});\nformatter.tryParse(${q(input)}); // null instead of throwing`}
    />
  );
}

/* --------------------------------------------------------- DateTime helpers */

export function PropertiesDemo() {
  const p = usePlayground();
  const [date, setDate] = useState<string | null>(null);
  const value = date ?? addDays(p.now, 0, 15, 30);
  const r = p.call<Record<string, string | number | boolean>>('properties', {date: value});
  const v = r.value ?? {};
  const s = (k: string) => (typeof v[k] === 'string' ? showIso(v[k] as string) : String(v[k]));
  return (
    <Playground
      controls={<DateInput label="date" value={value} onChange={setDate} />}
      output={
        <ResultTable
          rows={[
            ['isToday / isYesterday / isTomorrow', `${v.isToday} / ${v.isYesterday} / ${v.isTomorrow}`],
            ['isPast / isFuture', `${v.isPast} / ${v.isFuture}`],
            ['isWeekend', s('isWeekend')],
            ['isLeapYear', s('isLeapYear')],
            ['dayOfWeek (locale week)', s('dayOfWeek')],
            ['dayOfYear', s('dayOfYear')],
            ['daysInMonth', s('daysInMonth')],
            ['weekOfYear (ISO-8601)', s('weekOfYear')],
            ['quarterOfYear', s('quarterOfYear')],
            ['startOfWeek → endOfWeek', `${s('startOfWeek')} → ${s('endOfWeek')}`],
            ['startOfMonth → endOfMonth', `${s('startOfMonth')} → ${s('endOfMonth')}`],
            ['startOfQuarter → endOfQuarter', `${s('startOfQuarter')} → ${s('endOfQuarter')}`],
            ['startOfYear → endOfYear', `${s('startOfYear')} → ${s('endOfYear')}`],
          ]}
        />
      }
      code={`final date = ${dartDate(value)};\n\ndate.weekOfYear;      // ISO-8601\ndate.quarterOfYear;\ndate.daysInMonth;\ndate.startOf(Unit.week);\ndate.endOfQuarter;`}
    />
  );
}

export function ArithmeticDemo() {
  const p = usePlayground();
  const [date, setDate] = useState('2025-01-31T09:00:00');
  const [unit, setUnit] = useState<UnitName>('month');
  const [amount, setAmount] = useState(1);
  const r = p.call<Record<string, string>>('arithmetic', {date, unit, amount});
  return (
    <Playground
      controls={
        <>
          <DateInput label="date" value={date} onChange={setDate} />
          <NumberInput label="amount" value={amount} onChange={setAmount} />
          <Select label="unit" value={unit} options={UNITS} onChange={setUnit} width={140} />
        </>
      }
      output={
        <ResultTable
          rows={[
            [`add ${amount} ${unit}`, showIso(r.value?.add) ?? text(r)],
            [`subtract ${amount} ${unit}`, showIso(r.value?.subtract)],
            [`startOf(Unit.${unit})`, showIso(r.value?.startOf)],
            [`endOf(Unit.${unit})`, showIso(r.value?.endOf)],
          ]}
        />
      }
      code={`final date = ${dartDate(date)};\n\ndate.addDate(${unit}s: ${amount});\ndate.subtractDate(${unit}s: ${amount});\ndate.startOf(Unit.${unit});\ndate.endOf(Unit.${unit});`}
    />
  );
}

export function CompareDemo() {
  const p = usePlayground();
  const [date, setDate] = useState('2025-03-12T15:30:00');
  const [other, setOther] = useState('2025-05-22T08:00:00');
  const [unit, setUnit] = useState<UnitName>('month');
  const [asFloat, setAsFloat] = useState(false);
  const r = p.call<Record<string, number | boolean>>('compare', {date, other, unit, asFloat});
  const v = r.value ?? {};
  return (
    <Playground
      controls={
        <>
          <DateInput label="date" value={date} onChange={setDate} />
          <DateInput label="other" value={other} onChange={setOther} />
          <Select label="unit" value={unit} options={UNITS} onChange={setUnit} width={140} />
          <Switch label="asFloat" value={asFloat} onChange={setAsFloat} />
        </>
      }
      output={
        <ResultTable
          rows={[
            [`other.diff(date, unit: Unit.${unit})`, String(v.diff ?? text(r))],
            ['date.isSame(other, unit)', String(v.isSame)],
            ['date.isBeforeDate(other, unit)', String(v.isBeforeDate)],
            ['date.isAfterDate(other, unit)', String(v.isAfterDate)],
            ['date.isSameOrBefore(other, unit)', String(v.isSameOrBefore)],
          ]}
        />
      }
      code={`other.diff(date, unit: Unit.${unit}${asFloat ? ', asFloat: true' : ''});\ndate.isSame(other, unit: Unit.${unit});\ndate.isBeforeDate(other, unit: Unit.${unit});`}
    />
  );
}

/* ---------------------------------------------------------- TimeSpan/ranges */

function useSpans() {
  const [aStart, setAStart] = useState('2025-03-01T00:00:00');
  const [aEnd, setAEnd] = useState('2025-03-20T00:00:00');
  const [bStart, setBStart] = useState('2025-03-10T00:00:00');
  const [bEnd, setBEnd] = useState('2025-03-31T00:00:00');
  const controls = (
    <>
      <DateInput label="A start" value={aStart} onChange={setAStart} />
      <DateInput label="A end" value={aEnd} onChange={setAEnd} />
      <DateInput label="B start" value={bStart} onChange={setBStart} />
      <DateInput label="B end" value={bEnd} onChange={setBEnd} />
    </>
  );
  return {spans: {aStart, aEnd, bStart, bEnd}, controls};
}

const day = (iso: string) => showIso(iso).slice(0, 10);
const span = (s: unknown) => (Array.isArray(s) ? `${day(s[0])} → ${day(s[1])}` : s == null ? 'null' : String(s));
const spans = (list: unknown) => (Array.isArray(list) && list.length ? list.map(span).join('   |   ') : '[]');

export function TimeSpanDemo() {
  const p = usePlayground();
  const {spans: s, controls} = useSpans();
  const r = p.call<Record<string, unknown>>('timeSpan', s);
  const v = r.value ?? {};
  return (
    <Playground
      controls={controls}
      output={
        <ResultTable
          rows={[
            ['a.totalDuration', String(v.totalDuration ?? text(r))],
            ['a.intersects(b)', String(v.intersects)],
            ['a.containsTimeSpan(b)', String(v.containsTimeSpan)],
            ['a.getIntersection(b)', span(v.intersection)],
            ['a.merge(b)', span(v.merge)],
            ['a.getDifferences(b)', spans(v.differences)],
            ['a.symmetricDifference(b)', spans(v.symmetricDifference)],
            ['a == b', String(v.equals)],
          ]}
        />
      }
      code={`final a = TimeSpan(${dartDate(s.aStart)}, ${dartDate(s.aEnd)});\nfinal b = TimeSpan(${dartDate(s.bStart)}, ${dartDate(s.bEnd)});\n\na.intersects(b);\na.merge(b);\na.getIntersection(b);\na.getDifferences(b);\na.symmetricDifference(b);`}
    />
  );
}

export function IterateDemo() {
  const p = usePlayground();
  const [start, setStart] = useState('2025-01-31T09:00:00');
  const [end, setEnd] = useState('2025-06-30T09:00:00');
  const [unit, setUnit] = useState<UnitName>('month');
  const [step, setStep] = useState(1);
  const r = p.call<string[]>('iterate', {start, end, unit, step: Math.max(1, step), limit: 60});
  return (
    <Playground
      controls={
        <>
          <DateInput label="start" value={start} onChange={setStart} />
          <DateInput label="end" value={end} onChange={setEnd} />
          <Select label="unit" value={unit} options={UNITS} onChange={setUnit} width={140} />
          <NumberInput label="step" value={step} onChange={setStep} />
        </>
      }
      output={
        <Output
          result={r}
          render={(v) => {
            const list = v as string[];
            return `${list.length}${list.length === 60 ? '+' : ''} dates: ${list.map(showIso).join(', ')}`;
          }}
        />
      }
      code={`${dartDate(start)}.rangeTo(${dartDate(end)}, unit: Unit.${unit}, step: ${step});\n\n// or, on a TimeSpan\nTimeSpan(start, end).iterate(unit: Unit.${unit}, step: ${step});`}
    />
  );
}

export function ClampDemo() {
  const p = usePlayground();
  const {spans: s, controls} = useSpans();
  const r = p.call<Record<string, string>>('clamp', s);
  return (
    <Playground
      controls={controls}
      output={
        <ResultTable
          rows={[
            ['bStart.clamp(aStart, aEnd)', day(r.value?.bStartClamped ?? '')],
            ['bEnd.clamp(aStart, aEnd)', day(r.value?.bEndClamped ?? '')],
            ['[aStart, aEnd, bStart, bEnd].earliest', day(r.value?.earliest ?? '')],
            ['[aStart, aEnd, bStart, bEnd].latest', day(r.value?.latest ?? '')],
          ]}
        />
      }
      code={`date.clamp(min, max);\n[a, b, c].earliest;\n[a, b, c].latest;`}
    />
  );
}

/* ------------------------------------------------------------------ Locales */

export function LocaleGallery() {
  const p = usePlayground();
  const [filter, setFilter] = useState('');
  const pattern = new Set(p.patternLocales);
  const rows = p.locales.filter((code) => code.toLowerCase().includes(filter.toLowerCase()));
  return (
    <Playground
      controls={<TextInput label="filter" value={filter} onChange={setFilter} placeholder="e.g. zh" />}
      output={
        !p.ready ? (
          <Output result={{error: 'Loading…'}} />
        ) : (
          <div className={styles.scroll}>
            <table className={styles.table}>
              <thead>
                <tr>
                  <th>code</th>
                  <th>do MMMM yyyy</th>
                  <th>3 days ago</th>
                  <th>calendar · yesterday</th>
                  <th>2h 5m</th>
                  <th>ordinal 21</th>
                </tr>
              </thead>
              <tbody>
                {rows.map((code) => {
                  const r = p.call<Record<string, string>>('localeRow', {locale: code}).value ?? {};
                  return (
                    <tr
                      key={code}
                      data-selected={code === p.locale}
                      data-clickable="true"
                      onClick={() => p.setLocale(code)}
                      title="Use this locale in every example"
                    >
                      <td className={styles.key}>{pattern.has(code) ? code : `${code} *`}</td>
                      <td>{r.format}</td>
                      <td>{r.relative}</td>
                      <td>{r.calendar}</td>
                      <td>{r.duration}</td>
                      <td>{r.ordinal}</td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        )
      }
    />
  );
}
