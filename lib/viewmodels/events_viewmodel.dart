import 'package:flutter/material.dart';
import '../data/services/website_scraper_service.dart';
import '../data/models/event.dart';
import '../core/utils/logger_util.dart';

class EventsViewModel extends ChangeNotifier {
  final WebsiteScraperService _scraperService = WebsiteScraperService();
  
  List<Event> _events = [];
  bool _isLoading = false;
  String? _error;

  List<Event> get events => _events;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadEvents() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _events = await _scraperService.fetchEvents();
      AppLogger.info('${_events.length} etkinlik yüklendi');
    } catch (e) {
      _error = e.toString();
      AppLogger.error('Etkinlikler yüklenirken hata:', e);
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

