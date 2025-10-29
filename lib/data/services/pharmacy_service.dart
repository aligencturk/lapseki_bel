import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import '../../core/utils/logger_util.dart';
import '../models/pharmacy.dart';

class PharmacyService {
  static const String _sourceUrl =
      'https://www.eczaneler.gen.tr/nobetci-canakkale-lapseki';

  Future<List<Pharmacy>> fetchDutyPharmacies({bool forceMock = false}) async {
    if (forceMock) {
      AppLogger.info(
        'Nöbetçi eczaneler forceMock=true, mock veri döndürülüyor',
      );
      return _mockFallback();
    }
    try {
      AppLogger.info('Nöbetçi eczaneler çekiliyor: $_sourceUrl');
      final response = await http
          .get(
            Uri.parse(_sourceUrl),
            headers: {
              'User-Agent':
                  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125 Safari/537.36',
              'Accept':
                  'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            },
          )
          .timeout(const Duration(seconds: 12));

      if (response.statusCode != 200) {
        AppLogger.warning('Eczane sayfası status: ${response.statusCode}');
        return _mockFallback();
      }

      final document = html_parser.parse(response.body);

      // Olası kart/list yapıları için çoklu seçici denemeleri
      final List<dom.Element> itemNodes = [
        ...document.querySelectorAll(
          '.eczane, .eczane-kutu, .card.eczane, .pharmacy-item',
        ),
        ...document.querySelectorAll(
          '.list-group .list-group-item.eczane, .eczaneler li',
        ),
      ];

      if (itemNodes.isEmpty) {
        // Alternatif: tablo yapısı
        final rows = document.querySelectorAll('table tr');
        if (rows.isNotEmpty) {
          return _parseFromTable(rows);
        }
      }

      final pharmacies = <Pharmacy>[];

      for (final node in itemNodes) {
        final name = _firstText(node, [
          '.eczane-adi',
          '.title',
          'h3',
          'h2',
          'strong',
        ]);

        if (name == null || name.isEmpty) {
          continue;
        }

        final address = _firstText(node, [
          '.adres',
          '.address',
          '.card-text',
          'p',
        ]);

        final phone = _firstText(node, [
          '.telefon a',
          '.telefon',
          '.phone a',
          '.phone',
          'a[href^="tel:"]',
        ]);

        final detailUrl = node
            .querySelector('a[href*="eczane"]')
            ?.attributes['href'];

        pharmacies.add(
          Pharmacy(
            name: name.trim(),
            address: address?.trim(),
            phone: _normalizePhone(phone),
            district: _guessDistrict(address),
            detailUrl: detailUrl,
          ),
        );
      }

      if (pharmacies.isEmpty) {
        AppLogger.warning('Hiç eczane bulunamadı, fallback kullanılıyor');
        return _mockFallback();
      }

      AppLogger.info('${pharmacies.length} nöbetçi eczane bulundu');
      return pharmacies;
    } on TimeoutException catch (e, st) {
      AppLogger.error('Eczane isteği zaman aşımı', e, st);
      return _mockFallback();
    } catch (e, st) {
      AppLogger.error('Eczaneler çekilirken hata', e, st);
      return _mockFallback();
    }
  }

  List<Pharmacy> _parseFromTable(List<dom.Element> rows) {
    final pharmacies = <Pharmacy>[];
    for (final tr in rows.skip(1)) {
      final cells = tr.querySelectorAll('td');
      if (cells.length < 2) continue;
      final name = cells[0].text.trim();
      final address = cells.length > 1 ? cells[1].text.trim() : null;
      final phone = cells.length > 2 ? cells[2].text.trim() : null;
      if (name.isEmpty) continue;
      pharmacies.add(
        Pharmacy(
          name: name,
          address: address,
          phone: _normalizePhone(phone),
          district: _guessDistrict(address),
        ),
      );
    }
    return pharmacies;
  }

  String? _firstText(dom.Element root, List<String> selectors) {
    for (final sel in selectors) {
      final el = root.querySelector(sel);
      if (el != null) {
        final text = el.text.trim();
        if (text.isNotEmpty) return text;
      }
    }
    return null;
  }

  String? _normalizePhone(String? raw) {
    if (raw == null) return null;
    final digits = raw.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digits.startsWith('0')) return digits;
    if (digits.length == 10) return '0$digits';
    return digits.isEmpty ? null : digits;
  }

  String? _guessDistrict(String? address) {
    if (address == null) return null;
    final text = address.toLowerCase();
    if (text.contains('çardak')) return 'Çardak';
    if (text.contains('lapseki')) return 'Lapseki';
    return null;
  }

  List<Pharmacy> _mockFallback() {
    return const [
      Pharmacy(
        name: 'Köksal Eczanesi',
        address: 'Tekke Mah., Zübeyde Hanım Cad. No:34/2, Çardak/Lapseki',
        phone: '02865320061',
        district: 'Çardak',
      ),
      Pharmacy(
        name: 'Ebrucan Eczanesi',
        address:
            'Cumhuriyet Mah., Pazaryeri Meydanı, Fahrettin Oral Pasajı No:18/A, Lapseki',
        phone: '02865121002',
        district: 'Lapseki',
      ),
    ];
  }
}
