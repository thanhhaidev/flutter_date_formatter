import {createHash} from 'node:crypto';
import {existsSync, readFileSync} from 'node:fs';
import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const repo = 'https://github.com/thanhhaidev/flutter_date_formatter';
const releasedDocVersions = JSON.parse(
  readFileSync(new URL('./versions.json', import.meta.url), 'utf8'),
) as string[];
const docsVersionLabels = {
  current: {label: 'Next'},
  ...Object.fromEntries(
    releasedDocVersions.map((version) => [version, {label: `v${version}`}]),
  ),
};

// Content hash of the compiled package, appended to its URL so browsers never
// keep an outdated copy.
const bridgeFile = './static/js/date_formatter.js';
const bridgeVersion = existsSync(bridgeFile)
  ? createHash('sha256').update(readFileSync(bridgeFile)).digest('hex').slice(0, 10)
  : 'dev';

const config: Config = {
  title: 'flutter_date_formatter',
  tagline: 'Format, parse and compute dates in 55+ locales, for Dart and Flutter.',
  favicon: 'img/favicon.svg',

  // GitHub Pages project site by default; set SITE_URL/BASE_URL for other hosts.
  url: process.env.SITE_URL ?? 'https://thanhhaidev.github.io',
  baseUrl: process.env.BASE_URL ?? '/flutter_date_formatter/',
  organizationName: 'thanhhaidev',
  projectName: 'flutter_date_formatter',
  // With `true`, static files such as search-index.json get redirected to a
  // trailing-slash URL by `docusaurus serve`.
  trailingSlash: false,

  onBrokenLinks: 'throw',
  markdown: {hooks: {onBrokenMarkdownLinks: 'throw'}},

  i18n: {defaultLocale: 'en', locales: ['en']},

  customFields: {bridgeVersion},

  future: {v4: true, faster: true},

  headTags: [
    {tagName: 'link', attributes: {rel: 'preconnect', href: 'https://fonts.googleapis.com'}},
    {tagName: 'link', attributes: {rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: 'anonymous'}},
  ],
  stylesheets: [
    'https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600&family=Rethink+Sans:wght@400;500;600;700;800&display=swap',
  ],

  presets: [
    [
      'classic',
      {
        docs: {
          routeBasePath: 'docs',
          sidebarPath: './sidebars.ts',
          editUrl: `${repo}/tree/main/website/`,
        },
        blog: false,
        theme: {customCss: './src/css/custom.css'},
      } satisfies Preset.Options,
    ],
  ],

  themes: [
    [
      '@easyops-cn/docusaurus-search-local',
      {
        hashed: true,
        docsRouteBasePath: 'docs',
        indexBlog: false,
        highlightSearchTermsOnTargetPage: true,
        searchBarShortcutHint: true,
      },
    ],
  ],

  themeConfig: {
    image: 'img/social-card.svg',
    colorMode: {defaultMode: 'light', respectPrefersColorScheme: true},
    docs: {sidebar: {hideable: false, autoCollapseCategories: false}},
    navbar: {
      title: '',
      logo: {
        alt: 'flutter_date_formatter',
        src: 'img/logo.svg',
        srcDark: 'img/logo.svg',
      },
      items: [
        {type: 'html', position: 'left', value: '<span class="navbar-docs-badge">DOCS</span>'},
        {type: 'doc', docId: 'index', label: 'Guide', position: 'left'},
        {type: 'doc', docId: 'formatting', label: 'API', position: 'left'},
        {type: 'doc', docId: 'locales', label: 'Locales', position: 'left'},
        {
          type: 'docsVersionDropdown',
          position: 'right',
          className: 'navbar-version-dropdown',
          versions: docsVersionLabels,
          dropdownItemsBefore: [
            {type: 'html', value: '<span class="dropdown__header">FLUTTER DATE FORMATTER</span>'},
          ],
          dropdownItemsAfter: [
            {to: '/changelog', label: 'Release notes', className: 'version-picker-footer'},
          ],
        },
        {to: '/changelog', label: 'Changelog', position: 'left'},
        {href: repo, position: 'right', className: 'navbar-github', 'aria-label': 'GitHub repository'},
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Guide',
          items: [
            {label: 'Getting started', to: '/docs/'},
            {label: 'Configuration', to: '/docs/configuration'},
            {label: 'Locales', to: '/docs/locales'},
          ],
        },
        {
          title: 'API',
          items: [
            {label: 'Formatting', to: '/docs/formatting'},
            {label: 'Calendar time', to: '/docs/calendar'},
            {label: 'Durations', to: '/docs/durations'},
          ],
        },
        {
          title: 'Project',
          items: [
            {label: 'pub.dev', href: 'https://pub.dev/packages/flutter_date_formatter'},
            {label: 'GitHub', href: repo},
            {label: 'Changelog', to: '/changelog'},
          ],
        },
      ],
      copyright: `MIT licensed · Built with Docusaurus · Every example runs the real package, compiled from Dart to JavaScript.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.vsDark,
      additionalLanguages: ['dart', 'bash', 'yaml'],
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
