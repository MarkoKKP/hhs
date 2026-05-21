import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://househillstar.com',
  trailingSlash: 'always',
  build: {
    format: 'directory'
  },
  i18n: {
    defaultLocale: 'sr',
    locales: ['sr', 'en', 'ru'],
    routing: {
      prefixDefaultLocale: false
    }
  }
});
