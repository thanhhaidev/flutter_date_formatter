# flutter_date_formatter docs

The documentation site and live playground, built with [Docusaurus](https://docusaurus.io/).
Every example runs the real package: `dart/bin/bridge.dart` compiles
`flutter_date_formatter` to JavaScript (`static/js/date_formatter.js`), and the React
components in `src/components/Playground` call it.

## Develop

Requires Node 20+ and the Dart SDK.

```bash
cd website
npm install
npm start          # compiles the Dart bridge, then serves on http://localhost:3000
```

## Build

```bash
npm run build      # output in build/
npm run serve      # preview the build
```

By default the site is built for GitHub Pages at `/flutter_date_formatter/`.
For another host, set `SITE_URL` and `BASE_URL`, e.g. `BASE_URL=/ npm run build`.

## Structure

| Path | Content |
| --- | --- |
| `docs/` | MDX pages; playground components are available without imports |
| `src/components/Playground/` | settings context, primitives and one demo per feature |
| `src/pages/index.tsx` | landing page |
| `src/css/custom.css` | theme (colors, fonts, navbar, sidebar) |
| `dart/bin/bridge.dart` | the package API exposed to JavaScript |

Deployment: `.github/workflows/docs.yaml` builds and publishes to GitHub Pages on every push
to `main` that touches the package or the site.
