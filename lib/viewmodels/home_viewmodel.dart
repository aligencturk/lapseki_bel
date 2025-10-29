import 'package:flutter/material.dart';
import '../data/services/website_scraper_service.dart';
import '../data/models/announcement.dart';
import '../core/utils/logger_util.dart';

class HomeViewModel extends ChangeNotifier {
  final WebsiteScraperService _scraperService = WebsiteScraperService();

  List<Announcement> _announcements = [];
  bool _isLoading = false;
  String? _error;

  List<Announcement> get announcements => _announcements;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadAnnouncements() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _announcements = await _scraperService.fetchAnnouncements(limit: 5);
      AppLogger.info('${_announcements.length} duyuru yüklendi');
    } catch (e) {
      _error = e.toString();
      AppLogger.error('Duyurular yüklenirken hata:', e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
