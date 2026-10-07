import React, {type ReactNode} from 'react';
import Head from '@docusaurus/Head';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import {useLocation} from '@docusaurus/router';
import {PlaygroundProvider} from '@site/src/components/Playground/context';

function SeoHead() {
  const {siteConfig} = useDocusaurusContext();
  const location = useLocation();
  const basePath = siteConfig.baseUrl.replace(/\/$/, '');
  const pathname = location.pathname
    .replace(new RegExp(`^${basePath}`), '')
    .replace(/^\/|\/$/g, '');
  const home = pathname === '';
  const slug = pathname.replace(/^docs\//, '').replace(/-/g, ' ');
  const pageName = home ? 'Dates for every locale' : slug ? slug.replace(/\b\w/g, (letter) => letter.toUpperCase()) : 'Documentation';
  const title = `${pageName} | flutter_date_formatter`;
  const description = home
    ? 'Format, parse and compute dates in 55+ locales for Dart and Flutter.'
    : `flutter_date_formatter documentation: ${pageName.toLowerCase()} for Dart and Flutter.`;
  const url = `${siteConfig.url}${siteConfig.baseUrl}${pathname}`;
  const image = `${siteConfig.url}${siteConfig.baseUrl}img/social-card.svg`;
  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': home ? 'SoftwareApplication' : 'TechArticle',
    name: title,
    description,
    url,
    image,
    ...(home
      ? {applicationCategory: 'DeveloperApplication', operatingSystem: 'Any', programmingLanguage: ['Dart', 'Flutter']}
      : {isPartOf: {'@type': 'WebSite', name: 'flutter_date_formatter', url: `${siteConfig.url}${siteConfig.baseUrl}`}}),
  };
  return (
    <Head>
      <meta property="og:type" content={home ? 'website' : 'article'} />
      <meta property="og:title" content={title} />
      <meta property="og:description" content={description} />
      <meta property="og:url" content={url} />
      <meta property="og:image" content={image} />
      <meta name="twitter:card" content="summary_large_image" />
      <meta name="twitter:title" content={title} />
      <meta name="twitter:description" content={description} />
      <link rel="canonical" href={url} />
      <script type="application/ld+json">{JSON.stringify(jsonLd)}</script>
    </Head>
  );
}

/** Wraps every page so all playgrounds share the same settings. */
export default function Root({children}: {children: ReactNode}) {
  return (
    <>
      <SeoHead />
      <PlaygroundProvider>{children}</PlaygroundProvider>
    </>
  );
}
