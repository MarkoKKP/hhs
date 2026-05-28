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

    // ========================================================
    // GALERIJA page
    // ========================================================
    'gallery.page.eyebrow': 'Galerija',
    'gallery.page.title.line1': 'Kuća,',
    'gallery.page.title.accent': 'kadar po kadar.',
    'gallery.page.lede': 'Terasa okrenuta zalivu, enterijer u toplim tonovima, vrt koji miriše na borovinu i more. Slike koje slede beleže svetlo kakvo Kumbor poznaje — od jutarnje izmaglice nad vodom do zlatnog sata pred veče.',
    'gallery.page.note': 'Prave fotografije biće dodate uskoro. Prikazani okviri su privremeni.',

    'gallery.terrace.eyebrow': '01 — Terasa',
    'gallery.terrace.title': 'Zapadna terasa',
    'gallery.terrace.body': 'Mesto oko kojeg se vrti ceo dan. Kafa u senci ujutru, večera pod otvorenim nebom kada se zaliv oboji.',
    'gallery.terrace.1': 'Jutarnja kafa na terasi',
    'gallery.terrace.2': 'Večera pod otvorenim nebom',
    'gallery.terrace.3': 'Zalazak nad zalivom',

    'gallery.interior.eyebrow': '02 — Enterijer',
    'gallery.interior.title': 'Unutrašnji prostor',
    'gallery.interior.body': 'Dnevni boravak, spavaća soba, kuhinja. Prirodni materijali, prigušene boje, ništa suvišno.',
    'gallery.interior.1': 'Dnevni boravak',
    'gallery.interior.2': 'Spavaća soba sa pogledom',
    'gallery.interior.3': 'Kuhinja i trpezarija',

    'gallery.garden.eyebrow': '03 — Vrt',
    'gallery.garden.title': 'Privatni vrt',
    'gallery.garden.body': 'Maslina, lovor i lavanda. Ograđen prostor u kojem se ne čuje niko osim cvrčaka.',
    'gallery.garden.1': 'Maslinjak u dvorištu',
    'gallery.garden.2': 'Senka lovora u podne',

    'gallery.views.eyebrow': '04 — Pogledi',
    'gallery.views.title': 'Bokokotorski zaliv',
    'gallery.views.body': 'Voda, ostrva i planine koje se spuštaju do mora. Pogled koji se menja sa svakim satom.',
    'gallery.views.1': 'Pogled na Portonovi',
    'gallery.views.2': 'Zaliv u zlatnom satu',
    'gallery.views.3': 'Svetla zaliva noću',

    'gallery.cta.title.line1': 'Najbolji kadar je',
    'gallery.cta.title.accent': 'onaj uživo.',
    'gallery.cta.body': 'Datumi i dostupnost prate se preko Booking.com platforme.',
    'gallery.cta.button': 'Proveri dostupnost',

    // ========================================================
    // KUMBOR page
    // ========================================================
    'kumbor.page.eyebrow': 'Kumbor · Boka Kotorska',
    'kumbor.page.title.line1': 'Mesto koje',
    'kumbor.page.title.accent': 'ne žuri.',
    'kumbor.page.lede': 'Kumbor leži na ulazu u Bokokotorski zaliv, između Herceg Novog i Tivta. Ribarsko naselje koje je zadržalo svoj mir i kada je Portonovi pored njega izrastao u marinu svetskog glasa.',

    'kumbor.intro.eyebrow': 'O mestu',
    'kumbor.intro.title.line1': 'Između mora',
    'kumbor.intro.title.accent': 'i planine.',
    'kumbor.intro.body1': 'Selo se niže uz obalu, sa kamenim kućama koje gledaju na vodu i uskim ulicama koje se penju ka brdu. Iznad krovova, maslinjaci i borova šuma koja se spušta gotovo do same obale.',
    'kumbor.intro.body2': 'House Hill Star stoji na uzvišenju iznad Portonovog — dovoljno visoko da pogledom obuhvati ceo zaliv, a dovoljno blizu da se do plaže stigne peške. Mir brda, blizina mora.',

    'kumbor.distances.eyebrow': 'Razdaljine',
    'kumbor.distances.title.line1': 'Sve je',
    'kumbor.distances.title.accent': 'na dohvat.',
    'kumbor.dist.1.value': '5 min',
    'kumbor.dist.1.label': 'Plaža',
    'kumbor.dist.1.note': 'peške do mora',
    'kumbor.dist.2.value': '10 min',
    'kumbor.dist.2.label': 'Portonovi marina',
    'kumbor.dist.2.note': 'restorani uz more',
    'kumbor.dist.3.value': '10 min',
    'kumbor.dist.3.label': 'Herceg Novi',
    'kumbor.dist.3.note': 'stari grad i tvrđave',
    'kumbor.dist.4.value': '25 min',
    'kumbor.dist.4.label': 'Aerodrom Tivat',
    'kumbor.dist.4.note': 'najbliži dolazak',
    'kumbor.dist.5.value': '40 min',
    'kumbor.dist.5.label': 'Kotor',
    'kumbor.dist.5.note': 'pod zaštitom UNESCO-a',
    'kumbor.dist.6.value': '45 min',
    'kumbor.dist.6.label': 'Dubrovnik',
    'kumbor.dist.6.note': 'preko granice',

    'kumbor.nearby.eyebrow': 'U okolini',
    'kumbor.nearby.title.line1': 'Dan koji',
    'kumbor.nearby.title.accent': 'sami krojite.',
    'kumbor.nearby.body': 'U krugu od pola sata: marina Portonovi sa restoranima na vodi, tvrđave i šetalište Herceg Novog, plaža Žanjice i ostrvo Mamula do kojih se stiže brodom, te skrivene uvale poluostrva Luštica za one koji traže potpunu samoću. Jedrenje, degustacije lokalnih vina i izleti brodom organizuju se na zahtev.',

    'kumbor.cta.title.line1': 'Boka se ne',
    'kumbor.cta.title.accent': 'opisuje. Vidi se.',
    'kumbor.cta.body': 'Dostupnost i cene prate se u realnom vremenu preko Booking.com platforme.',
    'kumbor.cta.button': 'Proveri dostupnost',

    // ========================================================
    // O NAMA page
    // ========================================================
    'about.page.eyebrow': 'O nama',
    'about.page.title.line1': 'Jedna kuća,',
    'about.page.title.accent': 'jedna priča.',
    'about.page.lede': 'House Hill Star nije hotel. To je jedna kuća na brdu iznad Kumbora, otvorena za jedan par u jednom trenutku — i sve što nudi pripada samo njima.',

    'about.story.eyebrow': 'Zamisao',
    'about.story.title.line1': 'Protivteža',
    'about.story.title.accent': 'žurbi.',
    'about.story.body1': 'Kuća je zamišljena kao mesto na koje se dolazi da bi se usporilo. Bez recepcije, bez hodnika punih vrata, bez suseda iza zida. Samo prostor, svetlo i pogled na zaliv koji se menja sa svakim satom.',
    'about.story.body2': 'Svaki detalj biran je sa istom merom: prirodni materijali, topli tonovi, nameštaj koji poziva da se ostane duže. Ono što kuća ne nudi jednako je važno kao ono što nudi — nema buke, nema gužve, nema kompromisa oko privatnosti.',

    'about.principles.eyebrow': 'Načela',
    'about.principles.title.line1': 'Tri stvari koje',
    'about.principles.title.accent': 'se ne menjaju.',
    'about.principle.1.num': '01',
    'about.principle.1.title': 'Privatnost',
    'about.principle.1.body': 'Jedan par tokom boravka. Vrt, terasa i dnevni boravak pripadaju samo vama — ništa se ne deli.',
    'about.principle.2.num': '02',
    'about.principle.2.title': 'Mir',
    'about.principle.2.body': 'Daleko od gužve, dovoljno blizu svemu. Tišina brda umesto buke naselja.',
    'about.principle.3.num': '03',
    'about.principle.3.title': 'Pogled',
    'about.principle.3.body': 'Zapadna terasa hvata ceo Bokokotorski zaliv i svaki zalazak nad vodom.',

    'about.cta.title.line1': 'Ostalo se',
    'about.cta.title.accent': 'doživi na licu mesta.',
    'about.cta.body': 'Dostupnost i cene prate se u realnom vremenu preko Booking.com platforme.',
    'about.cta.button': 'Rezerviši boravak',

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
