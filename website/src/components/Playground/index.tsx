import React, {type ReactNode} from 'react';
import Link from '@docusaurus/Link';
import CodeBlock from '@theme/CodeBlock';
import clsx from 'clsx';
import {usePlayground, type StartOfWeek} from './context';
import type {CallResult} from '@site/src/lib/dateFormatter';
import styles from './styles.module.css';

export {usePlayground} from './context';

/** The shared settings bar: locale, "now" and first day of the week. */
function SettingsBar() {
  const p = usePlayground();
  return (
    <div className={styles.settings}>
      <span className={styles.settingsTitle}>
        <span className={styles.dot} /> {p.ready ? 'LIVE' : p.loadError ?? 'LOADING…'}
      </span>
      <label className={styles.settingsField}>
        locale
        <select value={p.locale} onChange={(e) => p.setLocale(e.target.value)} aria-label="Locale">
          {p.locales.map((code) => (
            <option key={code} value={code}>
              {code}
            </option>
          ))}
        </select>
      </label>
      <label className={styles.settingsField}>
        now
        <input
          type="datetime-local"
          aria-label="Reference time"
          value={p.now.slice(0, 16)}
          onChange={(e) => p.setFixedNow(e.target.value ? `${e.target.value}:00` : '')}
        />
        {p.fixedNow ? (
          <button type="button" className={styles.linkButton} onClick={() => p.setFixedNow('')}>
            live
          </button>
        ) : null}
      </label>
      <label className={styles.settingsField}>
        week
        <select
          value={p.startOfWeek}
          onChange={(e) => p.setStartOfWeek(e.target.value as StartOfWeek)}
          aria-label="First day of the week"
        >
          <option value="">locale</option>
          <option value="monday">monday</option>
          <option value="sunday">sunday</option>
          <option value="saturday">saturday</option>
        </select>
      </label>
    </div>
  );
}

/** A live example: controls, output and the matching Dart code. */
export function Playground({
  controls,
  output,
  code,
}: {
  controls?: ReactNode;
  output: ReactNode;
  code?: string;
}) {
  return (
    <div className={styles.panel}>
      <SettingsBar />
      {controls ? (
        <div className={clsx(styles.section, styles.controls)}>
          <div className={styles.label}>⚙ TRY IT</div>
          <div className={styles.grid}>{controls}</div>
        </div>
      ) : null}
      <div className={styles.section}>
        <div className={styles.label}>
          ⚡ OUTPUT <span className={styles.dot} />
        </div>
        {output}
      </div>
      {code ? (
        <div className={styles.code}>
          <CodeBlock language="dart">{code}</CodeBlock>
        </div>
      ) : null}
    </div>
  );
}

/** Shows a call result, its error, or a loading placeholder. */
export function Output({result, render}: {result: CallResult<unknown>; render?: (value: unknown) => ReactNode}) {
  const {ready} = usePlayground();
  if (!ready) return <div className={styles.skeleton} />;
  if (result.error !== undefined) {
    return <div className={clsx(styles.output, styles.outputError)}>{result.error}</div>;
  }
  return <div className={styles.output}>{render ? render(result.value) : String(result.value)}</div>;
}

export function Field({label, children}: {label: string; children: ReactNode}) {
  return (
    <label className={styles.field}>
      <span>{label}</span>
      {children}
    </label>
  );
}

export function TextInput({
  label,
  value,
  onChange,
  width = 220,
  placeholder,
}: {
  label: string;
  value: string;
  onChange(value: string): void;
  width?: number;
  placeholder?: string;
}) {
  return (
    <Field label={label}>
      <input
        className={styles.input}
        style={{width}}
        value={value}
        placeholder={placeholder}
        spellCheck={false}
        onChange={(e) => onChange(e.target.value)}
      />
    </Field>
  );
}

export function NumberInput({label, value, onChange, width = 96}: {label: string; value: number; onChange(value: number): void; width?: number}) {
  return (
    <Field label={label}>
      <input
        className={styles.input}
        style={{width}}
        type="number"
        value={value}
        onChange={(e) => onChange(Number(e.target.value) || 0)}
      />
    </Field>
  );
}

export function DateInput({label, value, onChange}: {label: string; value: string; onChange(value: string): void}) {
  return (
    <Field label={label}>
      <input
        className={styles.input}
        type="datetime-local"
        value={value.slice(0, 16)}
        onChange={(e) => e.target.value && onChange(`${e.target.value}:00`)}
      />
    </Field>
  );
}

export function Select<T extends string | number>({
  label,
  value,
  options,
  onChange,
  width = 150,
}: {
  label: string;
  value: T;
  options: readonly NoInfer<T>[];
  onChange(value: NoInfer<T>): void;
  width?: number;
}) {
  return (
    <Field label={label}>
      <select
        className={styles.input}
        style={{width}}
        value={value}
        onChange={(e) => onChange((typeof value === 'number' ? Number(e.target.value) : e.target.value) as T)}
      >
        {options.map((option) => (
          <option key={option} value={option}>
            {option}
          </option>
        ))}
      </select>
    </Field>
  );
}

export function Switch({label, value, onChange}: {label: string; value: boolean; onChange(value: boolean): void}) {
  return (
    <button type="button" className={styles.switch} data-on={value} onClick={() => onChange(!value)} aria-pressed={value}>
      {label}
      <span className={styles.track} />
    </button>
  );
}

export function Chips({values, selected, onSelect}: {values: string[]; selected?: string; onSelect(value: string): void}) {
  return (
    <div className={styles.chips}>
      {values.map((value) => (
        <button
          type="button"
          key={value}
          className={styles.chip}
          data-selected={value === selected}
          onClick={() => onSelect(value)}
        >
          {value}
        </button>
      ))}
    </div>
  );
}

/** A table of code-like keys and values. */
export function ResultTable({
  header,
  rows,
}: {
  header?: [string, string];
  rows: [string, ReactNode][];
}) {
  const {ready} = usePlayground();
  if (!ready) return <div className={styles.skeleton} />;
  return (
    <div className={styles.scroll}>
      <table className={styles.table}>
        {header ? (
          <thead>
            <tr>
              <th>{header[0]}</th>
              <th>{header[1]}</th>
            </tr>
          </thead>
        ) : null}
        <tbody>
          {rows.map(([key, value]) => (
            <tr key={key}>
              <td className={styles.key}>{key}</td>
              <td>{value}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

/** Unwraps a call result for tables: the value, or the error text. */
export function text(result: CallResult<unknown>): string {
  return result.error ?? String(result.value);
}

/** Numbered steps for guides. */
export function Steps({children}: {children: ReactNode}) {
  return <div className={styles.steps}>{children}</div>;
}

export function Step({title, children}: {title: string; children: ReactNode}) {
  return (
    <div className={styles.step}>
      <div className={styles.stepTitle}>{title}</div>
      {children}
    </div>
  );
}

/** A grid of link cards. */
export function Cards({children}: {children: ReactNode}) {
  return <div className={styles.cards}>{children}</div>;
}

export function Card({
  to,
  icon,
  title,
  tags = [],
  children,
}: {
  to: string;
  icon: string;
  title: string;
  tags?: string[];
  children: ReactNode;
}) {
  return (
    <Link to={to} className={styles.card}>
      <span className={styles.cardIcon}>{icon}</span>
      <span className={styles.cardTitle}>{title}</span>
      <span className={styles.cardText}>{children}</span>
      <span className={styles.cardFooter}>
        {tags.map((tag) => (
          <span key={tag} className={styles.tag}>
            {tag}
          </span>
        ))}
        <span className={styles.arrow}>↗</span>
      </span>
    </Link>
  );
}

export {styles as playgroundStyles};
