import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  // Lapseki koordinatları (yaklaşık)
  static const double _latitude = 40.3459;
  static const double _longitude = 26.6858;

  Future<({double temperatureC, String weatherCode})>
  fetchCurrentWeather() async {
    final uri = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$_latitude&longitude=$_longitude&current=temperature_2m,weather_code&timezone=auto',
    );
    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception('Weather fetch failed: ${res.statusCode}');
    }
    final map = json.decode(res.body) as Map<String, dynamic>;

    if (map['current'] is Map<String, dynamic>) {
      final current = map['current'] as Map<String, dynamic>;
      final temp = (current['temperature_2m'] as num).toDouble();
      final codeVal = current['weather_code'];
      final code = codeVal == null ? '0' : codeVal.toString();
      return (temperatureC: temp, weatherCode: code);
    }

    if (map['current_weather'] is Map<String, dynamic>) {
      final current = map['current_weather'] as Map<String, dynamic>;
      final temp = (current['temperature'] as num).toDouble();
      final codeVal = current['weathercode'];
      final code = codeVal == null ? '0' : codeVal.toString();
      return (temperatureC: temp, weatherCode: code);
    }

    throw Exception('Unsupported weather response shape');
  }
}
