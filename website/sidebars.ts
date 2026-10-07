import type {SidebarsConfig} from '@docusaurus/plugin-content-docs';

const sidebars: SidebarsConfig = {
  docs: [
    {
      type: 'category',
      label: 'Getting Started',
      collapsible: false,
      items: ['index', 'configuration'],
    },
    {
      type: 'category',
      label: 'Formatting',
      collapsible: false,
      items: ['formatting', 'relative-time', 'calendar', 'durations', 'parsing'],
    },
    {
      type: 'category',
      label: 'Date Math',
      collapsible: false,
      items: ['datetime-helpers', 'timespan-ranges'],
    },
    {
      type: 'category',
      label: 'Localization',
      collapsible: false,
      items: ['locales', 'custom-locales'],
    },
  ],
};

export default sidebars;
