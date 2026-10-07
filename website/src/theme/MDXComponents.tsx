import MDXComponents from '@theme-original/MDXComponents';
import {Card, Cards, Step, Steps} from '@site/src/components/Playground';
import * as demos from '@site/src/components/Playground/demos';

/** Makes the playground components available in every MDX page. */
export default {
  ...MDXComponents,
  Card,
  Cards,
  Step,
  Steps,
  ...demos,
};
