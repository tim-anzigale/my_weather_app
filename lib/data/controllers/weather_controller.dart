import 'package:get/get.dart';
import '../repositories/weather_repository.dart';

class WeatherController extends GetxController {
  final WeatherRepository weatherRepository;

  var isLoading = false.obs;
  var weatherData = {}.obs; // Holds the weather data response
  var errorMessage = ''.obs;

  WeatherController({required this.weatherRepository});

  /// Fetch weather data for a given latitude and longitude
  Future<void> fetchWeatherData(double lat, double lon) async {
    isLoading.value = true; // Start loading
    try {
      final response = await weatherRepository.fetchWeather(lat: lat, lon: lon);
      if (response.statusCode == 200) {
        weatherData.value = response.body;
        errorMessage.value = ''; // Clear any previous errors
      } else {
        errorMessage.value = 'Failed to fetch weather data: ${response.statusText}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching weather data: $e';
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  /// Fetch weather data for a specific timestamp using Time Machine API
  Future<void> fetchWeatherByTimestamp(double lat, double lon, int timestamp) async {
    isLoading.value = true; // Start loading
    try {
      final response = await weatherRepository.fetchWeatherByTimestamp(
          lat: lat, lon: lon, timestamp: timestamp);
      if (response.statusCode == 200) {
        weatherData.value = response.body;
        errorMessage.value = ''; // Clear any previous errors
      } else {
        errorMessage.value = 'Failed to fetch historical weather data: ${response.statusText}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching historical weather data: $e';
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

}

