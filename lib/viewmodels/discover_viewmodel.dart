import 'package:flutter/material.dart';
import '../data/services/website_scraper_service.dart';
import '../data/models/place.dart';
import '../core/utils/logger_util.dart';

class DiscoverViewModel extends ChangeNotifier {
  final WebsiteScraperService _scraperService = WebsiteScraperService();
  
  List<Place> _places = [];
  bool _isLoading = false;
  String? _error;

  List<Place> get places => _places;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadPlaces() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _places = await _scraperService.fetchPlaces();
      AppLogger.info('${_places.length} yer yüklendi');
    } catch (e) {
      _error = e.toString();
      AppLogger.error('Yerler yüklenirken hata:', e);
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

