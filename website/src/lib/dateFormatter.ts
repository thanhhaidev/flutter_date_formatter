import {useEffect, useState} from 'react';

/** Result of a call into the compiled Dart package. */
export type CallResult<T = unknown> = {value: T; error?: undefined} | {value?: undefined; error: string};

type Bridge = {call(method: string, argsJson: string): string; ready: boolean};

declare global {
  interface Window {
    dateFormatter?: Bridge;
  }
}

let loading: Promise<Bridge> | null = null;

/** Loads `static/js/date_formatter.js` once (flutter_date_formatter compiled to JS). */
export function loadBridge(scriptUrl: string): Promise<Bridge> {
  if (typeof window === 'undefined') return new Promise(() => {});
  if (window.dateFormatter?.ready) return Promise.resolve(window.dateFormatter);
  loading ??= new Promise((resolve, reject) => {
    window.addEventListener('date-formatter-ready', () => resolve(window.dateFormatter!), {once: true});
    const script = document.createElement('script');
    script.src = scriptUrl;
    script.async = true;
    script.onerror = () => {
      loading = null;
      reject(new Error(`Could not load ${scriptUrl}`));
    };
    document.head.appendChild(script);
  });
  return loading;
}

/** Calls a bridge method; see website/dart/bin/bridge.dart for the list. */
export function callBridge<T = unknown>(bridge: Bridge, method: string, args: object): CallResult<T> {
  try {
    return JSON.parse(bridge.call(method, JSON.stringify(args))) as CallResult<T>;
  } catch (error) {
    return {error: String(error)};
  }
}

/** Formats a JS Date as a local ISO string without a time zone, as Dart expects. */
export function toLocalIso(date: Date): string {
  const pad = (n: number) => String(n).padStart(2, '0');
  return (
    `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())}` +
    `T${pad(date.getHours())}:${pad(date.getMinutes())}:${pad(date.getSeconds())}`
  );
}

/** Parses a local ISO string ("2025-03-12T15:30[:00]") to a JS Date. */
export function fromLocalIso(iso: string): Date {
  const [d, t = '00:00:00'] = iso.split('T');
  const [y, m, day] = d.split('-').map(Number);
  const [h, min, s] = t.split(':').map(Number);
  return new Date(y, m - 1, day, h || 0, min || 0, s || 0);
}

/** Returns [iso] moved by calendar [days], keeping the wall-clock time. */
export function addDays(iso: string, days: number, hour?: number, minute = 0): string {
  const date = fromLocalIso(iso);
  date.setDate(date.getDate() + days);
  if (hour !== undefined) date.setHours(hour, minute, 0, 0);
  return toLocalIso(date);
}

/** A readable "2025-03-12 15:30" form of a local ISO string. */
export function showIso(iso: string | null | undefined): string {
  return iso ? iso.replace('T', ' ').slice(0, 16) : 'null';
}

/** Re-renders when the bridge is ready and returns it, or null while loading. */
export function useBridge(scriptUrl: string | null): {bridge: Bridge | null; error: string | null} {
  const [bridge, setBridge] = useState<Bridge | null>(
    typeof window !== 'undefined' && window.dateFormatter?.ready ? window.dateFormatter : null,
  );
  const [error, setError] = useState<string | null>(null);
  useEffect(() => {
    if (bridge || !scriptUrl) return;
    loadBridge(scriptUrl).then(setBridge, (e: Error) => setError(e.message));
  }, [bridge, scriptUrl]);
  return {bridge, error};
}
