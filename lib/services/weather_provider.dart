import 'package:flutter/material.dart';
import 'api_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? _weatherData;

  Map<String, dynamic>? get weatherData => _weatherData;

  Future<void> fetchWeather(double lat, double lon) async {
    try {
      _weatherData = await _weatherService.fetchWeather(lat, lon);
      notifyListeners(); // Notify listeners to update UI
    } catch (e) {
      print('Error fetching weather: $e');
      // Optionally handle the error, e.g., set _weatherData to null or log the error
    }
  }
}
