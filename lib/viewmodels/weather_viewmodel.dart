import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import '../data/services/weather_service.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherService _service;
  final Logger _logger;

  WeatherViewModel({WeatherService? service, Logger? logger})
    : _service = service ?? WeatherService(),
      _logger = logger ?? Logger();

  bool _loading = false;
  double? _temperatureC;
  String? _weatherCode;
  String? _error;

  bool get isLoading => _loading;
  double? get temperatureC => _temperatureC;
  String? get weatherCode => _weatherCode;
  String? get error => _error;

  Future<void> load() async {
    if (_loading) return;
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final data = await _service.fetchCurrentWeather();
      _temperatureC = data.temperatureC;
      _weatherCode = data.weatherCode;
    } catch (e, st) {
      _error = 'Hava bilgisi alınamadı';
      _logger.e('Weather load failed', error: e, stackTrace: st);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
