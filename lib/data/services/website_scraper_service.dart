import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import '../models/announcement.dart';
import '../models/event.dart';
import '../models/place.dart';
import '../../core/utils/logger_util.dart';

class WebsiteScraperService {
  static const String baseUrl = 'https://lapseki.bel.tr';

  /// Son duyuruları çeker
  Future<List<Announcement>> fetchAnnouncements() async {
    try {
      AppLogger.info('Lapseki belediyesi duyuruları çekiliyor...');

      final response = await http
          .get(Uri.parse('$baseUrl/duyurular'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final document = html_parser.parse(response.body);
        final announcements = <Announcement>[];

        // Son 3 duyuruyu al
        final announcementItems = document
            .querySelectorAll('.announcement-item')
            .take(3);

        for (var item in announcementItems) {
          final titleElement = item.querySelector(
            '.title a, h3 a, .announcement-title',
          );
          final dateElement = item.querySelector('.date, .tarih, time');

          if (titleElement != null) {
            final title = titleElement.text.trim();
            final date = dateElement?.text.trim() ?? 'Tarih belirtilmemiş';

            announcements.add(
              Announcement(
                title: title,
                date: date,
                description: null,
                url: titleElement.attributes['href'],
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
