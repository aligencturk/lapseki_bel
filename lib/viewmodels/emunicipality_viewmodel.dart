import 'package:flutter/material.dart';
import '../data/repositories/emunicipality_repository.dart';
import '../data/models/emunicipality_link.dart';
import '../core/utils/logger_util.dart';

class EMunicipalityViewModel extends ChangeNotifier {
  final EMunicipalityRepository _repository = EMunicipalityRepository();
  
  List<EMunicipalityLink> _links = [];
  bool _isLoading = false;
  String? _error;

  List<EMunicipalityLink> get links => _links;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadLinks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _links = await _repository.getLinks();
      AppLogger.info('${_links.length} E-Belediye linki yüklendi');
    } catch (e) {
      _error = e.toString();
      AppLogger.error('E-Belediye linkleri yüklenirken hata:', e);
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

