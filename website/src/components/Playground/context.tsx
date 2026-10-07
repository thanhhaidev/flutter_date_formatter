import React, {createContext, useContext, useEffect, useMemo, useState, type ReactNode} from 'react';
import useBaseUrl from '@docusaurus/useBaseUrl';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import {callBridge, toLocalIso, useBridge, type CallResult} from '@site/src/lib/dateFormatter';

export type StartOfWeek = '' | 'monday' | 'sunday' | 'saturday';

type Settings = {
  locale: string;
  setLocale(locale: string): void;
  /** Fixed "now" as a local ISO string, or '' to use the real clock. */
  fixedNow: string;
  setFixedNow(iso: string): void;
  startOfWeek: StartOfWeek;
  setStartOfWeek(value: StartOfWeek): void;
  /** The current reference time as a local ISO string. */
  now: string;
  locales: string[];
  patternLocales: string[];
  ready: boolean;
  loadError: string | null;
  /** Starts downloading the package. */
  request(): void;
  /** Calls the package with the shared settings (locale, now, startOfWeek). */
  call<T = unknown>(method: string, args?: object): CallResult<T>;
};

const SettingsContext = createContext<Settings | null>(null);

function usePersisted<T extends string>(key: string, initial: T): [T, (value: T) => void] {
  const [value, setValue] = useState<T>(initial);
  useEffect(() => {
    try {
      const stored = window.localStorage.getItem(key);
      if (stored !== null) setValue(stored as T);
    } catch {
      // Storage may be unavailable (private mode); keep the default.
    }
  }, [key]);
  const set = (next: T) => {
    setValue(next);
    try {
      window.localStorage.setItem(key, next);
    } catch {
      // Ignore storage errors.
    }
  };
  return [value, set];
}

export function PlaygroundProvider({children}: {children: ReactNode}) {
  // The package is only downloaded once a playground asks for it.
  const [wanted, setWanted] = useState(false);
  const {siteConfig} = useDocusaurusContext();
  const scriptUrl = `${useBaseUrl('/js/date_formatter.js')}?v=${siteConfig.customFields?.bridgeVersion ?? 'dev'}`;
  const {bridge, error} = useBridge(wanted ? scriptUrl : null);
  const [locale, setLocale] = usePersisted('dfp.locale', 'en');
  const [fixedNow, setFixedNow] = usePersisted('dfp.now', '');
  const [startOfWeek, setStartOfWeek] = usePersisted<StartOfWeek>('dfp.week', '');
  const [tick, setTick] = useState(0);

  // Keep the live clock fresh.
  useEffect(() => {
    if (fixedNow) return;
    const id = window.setInterval(() => setTick((t) => t + 1), 30_000);
    return () => window.clearInterval(id);
  }, [fixedNow]);

  const value = useMemo<Settings>(() => {
    const now = fixedNow || toLocalIso(new Date());
    const base = {locale, now, ...(startOfWeek ? {startOfWeek} : {})};
    const call = <T,>(method: string, args: object = {}): CallResult<T> =>
      bridge ? callBridge<T>(bridge, method, {...base, ...args}) : {error: 'Loading…'};
    const lists = bridge
      ? callBridge<{all: string[]; pattern: string[]}>(bridge, 'locales', {}).value
      : undefined;
    return {
      locale,
      setLocale,
      fixedNow,
      setFixedNow,
      startOfWeek,
      setStartOfWeek,
      now,
      locales: lists?.all ?? [locale],
      patternLocales: lists?.pattern ?? [],
      ready: bridge !== null,
      loadError: error,
      request: () => setWanted(true),
      call,
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [bridge, error, locale, fixedNow, startOfWeek, tick]);

  return <SettingsContext.Provider value={value}>{children}</SettingsContext.Provider>;
}

/** Shared playground settings; mounting a user starts loading the package. */
export function usePlayground(): Settings {
  const settings = useContext(SettingsContext);
  if (!settings) throw new Error('usePlayground needs <PlaygroundProvider>');
  const {request} = settings;
  useEffect(() => request(), [request]);
  return settings;
}
