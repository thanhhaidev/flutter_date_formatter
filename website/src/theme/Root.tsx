import React, {type ReactNode} from 'react';
import {PlaygroundProvider} from '@site/src/components/Playground/context';

/** Wraps every page so all playgrounds share the same settings. */
export default function Root({children}: {children: ReactNode}) {
  return <PlaygroundProvider>{children}</PlaygroundProvider>;
}
