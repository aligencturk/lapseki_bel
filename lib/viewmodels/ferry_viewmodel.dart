import 'package:flutter/material.dart';
import '../data/repositories/ferry_repository.dart';
import '../data/models/ferry_schedule.dart';
import '../core/utils/logger_util.dart';

class FerryViewModel extends ChangeNotifier {
  final FerryRepository _repository = FerryRepository();
  
  List<FerrySchedule> _schedules = [];
  bool _isLoading = false;
  String? _error;

  List<FerrySchedule> get schedules => _schedules;
  bool get isLoading => _isLoading;
  String? get error => _error;

  FerrySchedule? get toGeliboluSchedule {
    try {
      return _schedules.firstWhere(
        (schedule) => schedule.direction.contains('Gelibolu') && 
                     schedule.direction.startsWith('Lapseki'),
      );
    } catch (e) {
      return null;
    }
  }

  FerrySchedule? get toLapsekiSchedule {
    try {
      return _schedules.firstWhere(
        (schedule) => schedule.direction.contains('Lapseki') && 
                     schedule.direction.startsWith('Gelibolu'),
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> loadSchedules() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _schedules = await _repository.getFerrySchedules();
      AppLogger.info('${_schedules.length} feribot seferi yüklendi');
    } catch (e) {
      _error = e.toString();
      AppLogger.error('Feribot saatleri yüklenirken hata:', e);
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

