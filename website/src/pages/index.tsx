import React, {useState, type ReactNode} from 'react';
import Layout from '@theme/Layout';
import Link from '@docusaurus/Link';
import {Card, Cards, usePlayground} from '@site/src/components/Playground';
import {addDays} from '@site/src/lib/dateFormatter';
import styles from './index.module.css';

type Example = {
  tab: string;
  code: (locale: string) => ReactNode;
  run: (p: ReturnType<typeof usePlayground>) => string;
};

const s = (text: string) => <span className={styles.str}>{text}</span>;
const f = (text: string) => <span className={styles.fn}>{text}</span>;
const k = (text: string) => <span className={styles.kw}>{text}</span>;
const c = (text: string) => <span className={styles.cm}>{text}</span>;

const EXAMPLES: Example[] = [
  {
    tab: 'Format',
    code: (locale) => (
      <>
        {k('final')} date = {f('DateTime')}.now();{'\n\n'}
        date.{f('format')}({'\n'}
        {'  '}pattern: {s("'EEEE, do MMMM yyyy'")},{'\n'}
        {'  '}locale: {s(`'${locale}'`)},{'\n'});
      </>
    ),
    run: (p) => (p.call<string>('format', {date: p.now, pattern: 'EEEE, do MMMM yyyy'}).value ?? ''),
  },
  {
    tab: 'Relative',
    code: (locale) => (
      <>
        {k('final')} sent = {f('DateTime')}.now().{f('subHours')}({s('3')});{'\n\n'}
        sent.{f('formatRelative')}(locale: {s(`'${locale}'`)});{'\n'}
        {c('// short: true → "3h"')}
      </>
    ),
    run: (p) =>
      p.call<string>('relative', {date: addDays(p.now, 0, Math.max(0, Number(p.now.slice(11, 13)) - 3), Number(p.now.slice(14, 16))), clock: p.now}).value ?? '',
  },
  {
    tab: 'Calendar',
    code: (locale) => (
      <>
        {k('final')} message = {f('DateTime')}.now(){'\n'}
        {'    '}.{f('subDays')}({s('1')}).{f('copyWith')}(hour: {s('15')});{'\n\n'}
        message.{f('formatCalendar')}(locale: {s(`'${locale}'`)});
      </>
    ),
    run: (p) => p.call<string>('calendar', {date: addDays(p.now, -1, 15), clock: p.now}).value ?? '',
  },
  {
    tab: 'Duration',
    code: (locale) => (
      <>
        {k('const')} trip = {f('Duration')}(hours: {s('2')}, minutes: {s('5')});{'\n\n'}
        trip.{f('humanize')}(locale: {s(`'${locale}'`)});{'\n'}
        {c("// short: true → '2h 5m'")}
      </>
    ),
    run: (p) => p.call<string>('humanize', {milliseconds: 7_500_000}).value ?? '',
  },
];

function CodePanel() {
  const p = usePlayground();
  const [index, setIndex] = useState(0);
  const example = EXAMPLES[index];
  return (
    <div className={styles.panel}>
      <div className={styles.tabs}>
        {EXAMPLES.map((e, i) => (
          <button key={e.tab} type="button" className={i === index ? styles.tabActive : styles.tab} onClick={() => setIndex(i)}>
            {e.tab}
          </button>
        ))}
        <span className={styles.file}>main.dart</span>
      </div>
      <pre className={styles.code}>{example.code(p.locale)}</pre>
      <div className={styles.result}>
        <span>→</span>
        <span className={styles.resultValue}>{p.ready ? example.run(p) : 'Loading the package…'}</span>
        <select className={styles.localeSelect} value={p.locale} onChange={(e) => p.setLocale(e.target.value)} aria-label="Locale">
          {p.locales.map((code) => (
            <option key={code} value={code}>
              {code}
            </option>
          ))}
        </select>
      </div>
    </div>
  );
}

function Hero() {
  return (
    <header className={styles.hero}>
      <div className={styles.stripe} />
      <div className={styles.stripe2} />
      <div className={`container ${styles.heroInner}`}>
        <div>
          <Link className={styles.badge} to="/docs/calendar">
            Dart &amp; Flutter package <span>New: calendar &amp; durations →</span>
          </Link>
          <h1 className={styles.title}>
            Dates for every locale, <em>in one line of Dart</em>
          </h1>
          <p className={styles.subtitle}>
            Format, parse and compute dates in 55+ locales: ordinal patterns, relative and calendar times,
            humanized durations and DST-safe date math.
          </p>
          <div className={styles.actions}>
            <Link className={styles.primary} to="/docs/">
              Get started ↗
            </Link>
            <Link className={styles.secondary} to="/docs/locales">
              Browse locales
            </Link>
          </div>
          <div className={styles.install}>
            $ <code>dart pub add flutter_date_formatter</code>
          </div>
        </div>
        <CodePanel />
      </div>
    </header>
  );
}

const FEATURES: [string, string, string][] = [
  ['55+', 'Locales', 'Patterns, relative, calendar and duration strings, with CLDR plural rules.'],
  ['DST', 'Calendar-safe math', 'Day, week and month steps keep the wall-clock time across daylight saving.'],
  ['⏲', 'Testable clock', 'Inject "now" once with DateFormatterConfig; every API follows it.'],
  ['0', 'Setup', 'No initializeDateFormatting call: the intl data loads on first use.'],
];

export default function Home(): ReactNode {
  return (
    <Layout
      title="Dates for every locale"
      description="flutter_date_formatter: format, parse and compute dates in 55+ locales for Dart and Flutter."
    >
      <Hero />
      <main>
        <section className={styles.section}>
          <div className="container">
            <h2 className={styles.sectionTitle}>Explore the API</h2>
            <p className={styles.sectionText}>Every page has live examples running the real package.</p>
            <Cards>
              <Card to="/docs/formatting" icon="Aa" title="Formatting" tags={['format', 'ordinal']}>
                intl patterns plus <code>do</code> ordinals and <code>[literal]</code> text.
              </Card>
              <Card to="/docs/relative-time" icon="↺" title="Relative time" tags={['ago', 'in']}>
                "5 minutes ago", "in 3 days", long or short.
              </Card>
              <Card to="/docs/calendar" icon="▦" title="Calendar time" tags={['chat', 'feed']}>
                "Today at 3:00 PM", "Last Monday at…", aware of the week.
              </Card>
              <Card to="/docs/durations" icon="⏱" title="Durations" tags={['humanize']}>
                "2 hours 5 minutes" with correct plurals in every locale.
              </Card>
              <Card to="/docs/parsing" icon="⇥" title="Parsing" tags={['parse', 'tryParse']}>
                Read strings back with the same pattern syntax.
              </Card>
              <Card to="/docs/datetime-helpers" icon="ƒ" title="DateTime helpers" tags={['startOf', 'diff']}>
                Week numbers, quarters, DST-safe arithmetic.
              </Card>
              <Card to="/docs/timespan-ranges" icon="↔" title="TimeSpan & ranges" tags={['merge', 'iterate']}>
                Interval set operations, iteration and clamping.
              </Card>
              <Card to="/docs/locales" icon="文" title="Locales" tags={['gallery']}>
                Every locale side by side, live.
              </Card>
            </Cards>
          </div>
        </section>
        <section className={styles.sectionAlt}>
          <div className="container">
            <div className={styles.features}>
              {FEATURES.map(([stat, title, text]) => (
                <div key={title} className={styles.feature}>
                  <div className={styles.stat}>{stat}</div>
                  <h3>{title}</h3>
                  <p>{text}</p>
                </div>
              ))}
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}
