import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import '../models/announcement.dart';
import '../models/event.dart';
import '../models/place.dart';
import '../../core/utils/logger_util.dart';

class WebsiteScraperService {
  static const String baseUrl = 'https://www.lapseki.bel.tr';

  /// Duyuruları çeker
  Future<List<Announcement>> fetchAnnouncements({
    int limit = 3,
    bool useMock = false,
  }) async {
    if (useMock) {
      AppLogger.info('Duyurular mock modunda yükleniyor');
      return _getMockAnnouncements();
    }
    try {
      AppLogger.info('Lapseki belediyesi duyuruları çekiliyor...');

      final response = await http
          .get(
            Uri.parse('$baseUrl/duyurular'),
            headers: const {
              'User-Agent':
                  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125 Safari/537.36',
              'Accept':
                  'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            },
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final document = html_parser.parse(response.body);
        final announcements = <Announcement>[];

        // 1) Link tabanlı yakalama: sadece duyuru detay linkleri (/duyuru/...)
        final linkCandidates = document.querySelectorAll('a[href*="/duyuru/"]');

        for (final a in linkCandidates) {
          if (announcements.length >= limit) break;
          final href = a.attributes['href'];
          if (href == null || href.isEmpty) continue;
          final titleText = a.text.trim();
          if (titleText.isEmpty) continue;
          // Menü ve kısa başlıkları filtrele
          const blockedTitles = [
            'Anasayfa',
            'Duyurular',
            'Etkinlikler',
            'E - Ödeme',
            'Galeri',
            'Haberler',
            'İhaleler',
            'Fotoğraf Galerisi',
            'Video Galeri',
            'İletişim Formu',
            'KOLAY MENU',
            'KOLAY MENÜ',
          ];
          if (blockedTitles.contains(titleText)) continue;
          if (titleText.length < 8) continue;

          // Tarih metni bulunamazsa boş bırak
          final String dateText = '';

          announcements.add(
            Announcement(
              title: titleText,
              date: dateText.isEmpty ? '' : dateText,
              description: null,
              url: href.startsWith('http') ? href : '$baseUrl$href',
            ),
          );
        }

        // 3) Son çare: Regex ile /duyuru/ linklerini yakala
        if (announcements.isEmpty) {
          final body = response.body;
          final regex = RegExp(
            r'href\s*=\s*"(\/duyuru\/[^"#]+)"[^>]*>([^<]{8,})<',
            caseSensitive: false,
          );
          final seen = <String>{};
          for (final m in regex.allMatches(body)) {
            if (announcements.length >= limit) break;
            final href = m.group(1);
            final title = (m.group(2) ?? '').trim();
            if (href == null || title.isEmpty) continue;
            const blockedTitles = [
              'Anasayfa',
              'Duyurular',
              'Etkinlikler',
              'E - Ödeme',
              'Galeri',
              'Haberler',
              'İhaleler',
              'Fotoğraf Galerisi',
              'Video Galeri',
              'İletişim Formu',
              'KOLAY MENU',
              'KOLAY MENÜ',
            ];
            if (blockedTitles.contains(title)) continue;
            if (seen.contains(title)) continue;
            seen.add(title);
            announcements.add(
              Announcement(
                title: title,
                date: '',
                description: null,
                url: href.startsWith('http') ? href : '$baseUrl$href',
              ),
            );
          }
        }

        // 2) Eğer hâlâ sonuç yoksa, daha geniş kart/liste seçicileri dene
        if (announcements.isEmpty) {
          final cards = document.querySelectorAll(
            '.announcement-item, .duyuru, .news-item, .haber, article, li',
          );
          for (final item in cards) {
            if (announcements.length >= limit) break;
            final titleElement = item.querySelector('a, h3 a, .title a');
            if (titleElement == null) continue;
            final href = titleElement.attributes['href'];
            final title = titleElement.text.trim();
            if (title.isEmpty) continue;
            final dateElement = item.querySelector(
              '.date, .tarih, time, .gun, .ay, .yil',
            );
            final date = dateElement?.text.trim() ?? '';
            announcements.add(
              Announcement(
                title: title,
                date: date,
                description: null,
                url: href == null
                    ? null
                    : (href.startsWith('http') ? href : '$baseUrl$href'),
              ),
            );
          }
        }

        AppLogger.info('${announcements.length} duyuru bulundu');
        return announcements;
      } else {
        AppLogger.warning('Duyurular çekilemedi, mock data kullanılıyor');
        return _getMockAnnouncements();
      }
    } catch (e) {
      AppLogger.error('Duyurular çekilirken hata:', e);
      return _getMockAnnouncements();
    }
  }

  /// Etkinlikleri çeker
  Future<List<Event>> fetchEvents() async {
    try {
      AppLogger.info('Lapseki belediyesi etkinlikleri çekiliyor...');

      final response = await http
          .get(Uri.parse('$baseUrl/etkinlikler'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final document = html_parser.parse(response.body);
        final events = <Event>[];

        final eventItems = document.querySelectorAll(
          '.event-item, .etkinlik-item',
        );

        for (var item in eventItems.take(5)) {
          final titleElement = item.querySelector(
            '.title a, h3 a, .event-title',
          );
          final dateElement = item.querySelector('.date, .tarih, time');

          if (titleElement != null) {
            final title = titleElement.text.trim();
            final dateTime = dateElement?.text.trim() ?? '';

            events.add(
              Event(
                title: title,
                date: dateTime,
                time: '09:00',
                description: null,
                location: 'Lapseki',
              ),
            );
          }
        }

        AppLogger.info('${events.length} etkinlik bulundu');
        return events.isNotEmpty ? events : _getMockEvents();
      } else {
        AppLogger.warning('Etkinlikler çekilemedi, mock data kullanılıyor');
        return _getMockEvents();
      }
    } catch (e) {
      AppLogger.error('Etkinlikler çekilirken hata:', e);
      return _getMockEvents();
    }
  }

  /// Gezilecek yerleri çeker
  Future<List<Place>> fetchPlaces() async {
    try {
      AppLogger.info('Lapseki kent rehberi çekiliyor...');

      // Kent rehberinden yerler çekiliyor
      final response = await http
          .get(Uri.parse('$baseUrl/kent-rehberi'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final document = html_parser.parse(response.body);
        final places = <Place>[];

        final placeItems = document.querySelectorAll('.place-item, .yer-item');

        for (var item in placeItems.take(4)) {
          final nameElement = item.querySelector('.name, h3, .place-name');
          final descElement = item.querySelector('.description, p, .aciklama');

          if (nameElement != null) {
            final name = nameElement.text.trim();
            final description =
                descElement?.text.trim() ?? 'Lapseki\'de gezilecek yer';

            places.add(
              Place(
                name: name,
                description: description,
                mapsUrl:
                    'https://www.google.com/maps/search/?api=1&query=$name+Lapseki',
              ),
            );
          }
        }

        AppLogger.info('${places.length} yer bulundu');
        return places.isNotEmpty ? places : _getMockPlaces();
      } else {
        AppLogger.warning('Yerler çekilemedi, mock data kullanılıyor');
        return _getMockPlaces();
      }
    } catch (e) {
      AppLogger.error('Yerler çekilirken hata:', e);
      return _getMockPlaces();
    }
  }

  // Mock data methods
  List<Announcement> _getMockAnnouncements() {
    return [
      Announcement(
        title: 'ÇÖPLERİMİZİ ARTIK BİZ TOPLUYORUZ',
        date: '18 Kasım 2024',
        description: 'Yeni çöp toplama sistemimiz hizmete başladı.',
      ),
      Announcement(
        title: 'DALYAN PLAJI YENİ SEZONA HAZIR!',
        date: '15 Kasım 2024',
        description: 'Dalyan plajımız yeni sezona hazırlandı.',
      ),
      Announcement(
        title: 'NİCE BAYRAMLARDA COŞKU VE SEVGİYLE BULUŞALIM',
        date: '10 Kasım 2024',
        description: 'Bayram mesajımız.',
      ),
    ];
  }

  List<Event> _getMockEvents() {
    return [
      Event(
        title: 'Toplu Sünnet Töreni',
        date: '18 Ağustos 2024',
        time: '09:00',
        description: 'Geleneksel toplu sünnet törenimiz',
        location: 'Lapseki Belediyesi',
      ),
      Event(
        title: 'Romanlar Günü',
        date: '8 Nisan 2024',
        time: '15:00',
        description: 'Romanlar Günü kutlamaları',
        location: 'Belediye Meydanı',
      ),
      Event(
        title: 'Annelere Özel Türk Sanat Müziği Konseri',
        date: '10 Mayıs 2024',
        time: '19:00',
        description: 'Annelere özel konser',
        location: 'Kültür Merkezi',
      ),
    ];
  }

  List<Place> _getMockPlaces() {
    return [
      Place(
        name: 'Dalyan Plajı',
        description: 'Temiz kumu ve berrak denizi ile ünlü plajımız',
        mapsUrl: 'https://goo.gl/maps/xyz123',
        latitude: 40.3446,
        longitude: 26.6612,
      ),
      Place(
        name: 'Lapseki Kale',
        description: 'Tarihi kale ve şehir manzarası',
        mapsUrl: 'https://goo.gl/maps/abc456',
        latitude: 40.3460,
        longitude: 26.6690,
      ),
      Place(
        name: 'Kent Ormanı',
        description: 'Doğa yürüyüşü ve piknik alanı',
        mapsUrl: 'https://goo.gl/maps/def789',
        latitude: 40.3350,
        longitude: 26.6500,
      ),
      Place(
        name: 'Belediye Meydanı',
        description: 'Şehir merkezi ve alışveriş bölgesi',
        mapsUrl: 'https://goo.gl/maps/ghi012',
        latitude: 40.3435,
        longitude: 26.6695,
      ),
    ];
  }
}
