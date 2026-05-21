/**
 * House Hill Star — i18n string tables
 *
 * MVP launches with SR populated. EN and RU are scaffolded as TODOs
 * to be translated in phase 2.
 *
 * Editorial voice — third person, atmospheric, restrained.
 * See brand-book.md §2 for voice guidelines.
 */

export const languages = {
  sr: { label: 'SR', name: 'Srpski' },
  en: { label: 'EN', name: 'English' },
  ru: { label: 'RU', name: 'Русский' }
} as const;

export const defaultLang = 'sr';

export type Lang = keyof typeof languages;

/**
 * Localised Booking.com listing URLs.
 * Each language variant of the listing has its own URL path.
 */
export const bookingUrl: Record<Lang, string> = {
  sr: 'https://www.booking.com/hotel/me/house-hill-star-kumbor.sr.html',
  en: 'https://www.booking.com/hotel/me/house-hill-star-kumbor.en-gb.html',
  ru: 'https://www.booking.com/hotel/me/house-hill-star-kumbor.ru.html'
};

export const ui = {
  sr: {
    // Navigation
    'nav.home': 'Početna',
    'nav.gallery': 'Galerija',
    'nav.location': 'Kumbor',
    'nav.about': 'O nama',
    'nav.book': 'Rezerviši',

    // Hero
    'hero.eyebrow': 'Kumbor · Boka Kotorska',
    'hero.title.line1': 'Tamo gde',
    'hero.title.line1.accent': 'brdo',
    'hero.title.line2': 'dotakne',
    'hero.title.line2.accent': 'zaliv.',
    'hero.lede': 'Privatna vila iznad Portonovog. Jedna kuća, jedan par, jedan pogled koji ostaje u sećanju.',
    'hero.cta.primary': 'Rezerviši boravak',
    'hero.cta.secondary': 'Otkrij više',

    // Meta strip
    'meta.private': 'Privatno',
    'meta.private.value': '100%',
    'meta.beach': 'Do plaže',
    'meta.beach.value': '5 min',
    'meta.view': 'Pogled',
    'meta.view.value': 'Bokokotorski zaliv',
    'meta.guests': 'Gosti',
    'meta.guests.value': 'Dvoje',

    // Intro section
    'intro.eyebrow': 'O smeštaju',
    'intro.title.line1': 'Iskustvo krojeno',
    'intro.title.line2.accent': 'za dvoje.',
    'intro.body': 'Bez deljenih prostora. Bez pregovaranja oko terase. House Hill Star prima jedan par tokom boravka — i sve što kuća nudi pripada samo vama. Vrt, parking, dnevni boravak, terasa. Sve sopstveno, ništa deljeno.',

    // Signature feature
    'signature.label': 'Signature feature',
    'signature.title': 'Terasa pri zalasku',
    'signature.body': 'Zapadno orijentisana terasa hvata svaki zalazak nad Bokokotorskim zalivom. Zalasci su isti svake večeri — i nikad isti. Posluženje vina i lokalne degustacije organizujemo na zahtev.',

    // Location teaser
    'location.eyebrow': 'Lokacija',
    'location.title': 'Kumbor —',
    'location.title.accent': 'srce Boke.',
    'location.body': 'Kuća se nalazi na blagom uzvišenju iznad Portonovog, u tihom delu Kumbora. Pet minuta do mora, deset do Herceg Novog, trideset do aerodroma Tivat. Dovoljno blizu da sve dostigneš. Dovoljno daleko da te niko ne pronađe.',
    'location.cta': 'Više o Kumboru',

    // Reviews section
    'reviews.eyebrow': 'Recenzije gostiju',
    'reviews.title': 'Glas onih',
    'reviews.title.accent': 'koji su već boravili.',
    'reviews.body': 'Kuća se prepoznaje po onome što gosti pamte nakon povratka kući. Nekoliko utisaka koji su nam ostavljeni.',
    'reviews.cta': 'Pogledaj sve recenzije na Booking.com',

    // Reviews — placeholder content (zameniti pravim recenzijama kad ih dobijemo)
    'review.1.quote': 'Najlepša terasa na koju smo stupili. Vino, zalazak sunca, tišina — i ništa više nam nije bilo potrebno.',
    'review.1.author': 'Ana & Marko',
    'review.1.origin': 'Beograd, Srbija',

    'review.2.quote': 'Kuća je tačno onakva kakvom je opisuju — privatna, mirna, sa pogledom koji oduzima dah. Vraćamo se sigurno.',
    'review.2.author': 'Elena & Dmitri',
    'review.2.origin': 'Moskva, Rusija',

    'review.3.quote': 'Pažnja prema detaljima ovde je nečuvena. Sve što je obećano — i mnogo više od toga.',
    'review.3.author': 'Sophie & Thomas',
    'review.3.origin': 'Beč, Austrija',

    // Gallery teaser
    'gallery.eyebrow': 'Galerija',
    'gallery.title': 'Kuća,',
    'gallery.title.accent': 'kadar po kadar.',
    'gallery.body': 'Terasa, vrt, enterijer, zaliv. Nekoliko izabranih trenutaka iz dana i večeri.',
    'gallery.cta': 'Cela galerija',
    'gallery.1.caption': 'Terasa pri zalasku',
    'gallery.2.caption': 'Dnevni boravak',
    'gallery.3.caption': 'Privatni vrt',
    'gallery.4.caption': 'Pogled na zaliv',

    // Closing CTA
    'cta.title.line1': 'Kuća čeka.',
    'cta.title.line2.accent': 'Datum biraš ti.',
    'cta.body': 'Dostupnost i cene se prate u realnom vremenu preko Booking.com platforme.',
    'cta.primary': 'Proveri dostupnost',

    // Footer
    'footer.tagline': 'Privatna vila iznad Bokokotorskog zaliva.',
    'footer.location': 'Kumbor · Herceg Novi · Crna Gora',
    'footer.email': 'info@househillstar.com',
    'footer.copyright': '© 2026 House Hill Star. Sva prava zadržana.'
  },

  en: {
    // TODO: phase 2 translation
    'nav.home': 'Home',
    'nav.gallery': 'Gallery',
    'nav.location': 'Kumbor',
    'nav.about': 'About',
    'nav.book': 'Book',
    'hero.eyebrow': 'Kumbor · Bay of Kotor',
    'hero.title.line1': 'Where the',
    'hero.title.line1.accent': 'hill',
    'hero.title.line2': 'meets the',
    'hero.title.line2.accent': 'bay.',
    'hero.lede': 'A private villa above Portonovi. One house, one couple, one view that stays with you.',
    'hero.cta.primary': 'Book your stay',
    'hero.cta.secondary': 'Discover more',
    'footer.copyright': '© 2026 House Hill Star. All rights reserved.'
  },

  ru: {
    // TODO: phase 2 translation
    'nav.home': 'Главная',
    'nav.gallery': 'Галерея',
    'nav.location': 'Кумбор',
    'nav.about': 'О нас',
    'nav.book': 'Бронировать',
    'hero.eyebrow': 'Кумбор · Которский залив',
    'hero.title.line1': 'Там, где',
    'hero.title.line1.accent': 'холм',
    'hero.title.line2': 'встречает',
    'hero.title.line2.accent': 'залив.',
    'hero.lede': 'Частная вилла над Портонови. Один дом, одна пара, один вид, который остаётся с вами.',
    'hero.cta.primary': 'Забронировать',
    'hero.cta.secondary': 'Узнать больше',
    'footer.copyright': '© 2026 House Hill Star. Все права защищены.'
  }
} as const;

type SrKeys = keyof typeof ui.sr;

export function useTranslations(lang: Lang) {
  return function t(key: SrKeys): string {
    const dict = ui[lang] as Record<string, string>;
    return dict[key] ?? ui.sr[key];
  };
}
