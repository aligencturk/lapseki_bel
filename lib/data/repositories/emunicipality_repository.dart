import '../models/emunicipality_link.dart';
import '../../core/utils/logger_util.dart';

class EMunicipalityRepository {
  static const String eBelediyeBaseUrl = 'https://e-belediye.lapseki.bel.tr';

  /// E-Belediye linklerini getirir
  Future<List<EMunicipalityLink>> getLinks() async {
    try {
      AppLogger.info('E-Belediye linkleri getiriliyor...');

      await Future.delayed(const Duration(milliseconds: 200));

      return [
        EMunicipalityLink(
          title: 'E-Belediye',
          url: eBelediyeBaseUrl,
          iconName: 'home',
        ),
        EMunicipalityLink(
          title: 'Borç Ödeme / Sorgulama',
          url: eBelediyeBaseUrl,
          iconName: 'payment',
        ),
        EMunicipalityLink(
          title: 'Tahsilat Görüntüleme',
          url: eBelediyeBaseUrl,
          iconName: 'receipt',
        ),
        EMunicipalityLink(
          title: 'Emlak Beyan İşlemleri',
          url: eBelediyeBaseUrl,
          iconName: 'home_work',
        ),
        EMunicipalityLink(
          title: 'Çevre Beyan İşlemleri',
          url: eBelediyeBaseUrl,
          iconName: 'eco',
        ),
        EMunicipalityLink(
          title: 'İlan Reklam Beyan',
          url: eBelediyeBaseUrl,
          iconName: 'ad_units',
        ),
        EMunicipalityLink(
          title: 'Online İstek / Sorun',
          url: eBelediyeBaseUrl,
          iconName: 'support',
        ),
      ];
    } catch (e) {
      AppLogger.error('E-Belediye linkleri getirilirken hata:', e);
      return [];
    }
  }
}
