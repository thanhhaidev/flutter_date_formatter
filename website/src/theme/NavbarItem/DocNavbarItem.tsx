import React, {type ReactNode} from 'react';
import {
  useActiveDocContext,
  useLayoutDoc,
} from '@docusaurus/plugin-content-docs/client';
import DefaultNavbarItem from '@theme/NavbarItem/DefaultNavbarItem';
import type {Props} from '@theme/NavbarItem/DocNavbarItem';

const activeDocIds: Record<string, Set<string>> = {
  index: new Set(['index', 'configuration', 'timezones']),
  formatting: new Set([
    'formatting',
    'relative-time',
    'calendar',
    'durations',
    'parsing',
    'datetime-helpers',
    'timespan-ranges',
  ]),
  locales: new Set(['locales', 'custom-locales']),
};

export default function DocNavbarItem({
  docId,
  label: staticLabel,
  docsPluginId,
  ...props
}: Props): ReactNode {
  const {activeDoc} = useActiveDocContext(docsPluginId);
  const doc = useLayoutDoc(docId, docsPluginId);
  const pageActive = activeDoc
    ? (activeDocIds[docId]?.has(activeDoc.id) ?? activeDoc.path === doc?.path)
    : false;

  if (doc === null || (doc.unlisted && !pageActive)) {
    return null;
  }

  return (
    <DefaultNavbarItem
      exact
      {...props}
      isActive={() => pageActive}
      label={staticLabel ?? doc.id}
      to={doc.path}
    />
  );
}
