import 'package:get/get.dart';
import 'package:weather_app/data/api/api_client.dart';
import 'package:weather_app/utils/environment.dart'; // Ensure the correct import path

class WeatherRepository extends GetxService {
  final ApiClient apiClient;

  WeatherRepository({required this.apiClient});

  /// Fetch weather data based on latitude and longitude
  Future<Response> fetchWeather({
    required double lat,
    required double lon,
    String? exclude,
    String units = 'metric',
    String lang = 'en',
  }) async {
    // Ensure that the base URL and API key are not null
    final String baseUrl = Environment.openWeatherBaseUrl;
    final String apiKey = Environment.openWeatherApiKey;

    final String uri = '$baseUrl${Environment.oneCallUrl}';
    final Map<String, String> queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': apiKey, // Use the correct environment variable name
      'units': units,
      'lang': lang,
    };

    if (exclude != null) {
      queryParams['exclude'] = exclude;
    }

    // Perform the API call
    final response = await apiClient.getWithParamData(uri, queryParams: queryParams);

    // Check if the response is valid
    if (response.statusCode != 200 || response.body == null) {
      throw Exception('Failed to fetch weather data: ${response.statusText}');
    }

    return response;
  }

  /// Fetch weather data for a specific timestamp using the Time Machine API
  Future<Response> fetchWeatherByTimestamp({
    required double lat,
    required double lon,
    required int timestamp,
    String units = 'metric',
    String lang = 'en',
  }) async {
    // Ensure that the base URL and API key are not null
    final String? baseUrl = Environment.openWeatherBaseUrl;
    final String? apiKey = Environment.openWeatherApiKey;

    if (baseUrl == null || apiKey == null) {
      throw Exception('API configuration is missing. Check environment variables.');
    }

    final String uri = '$baseUrl${Environment.timeMachineUrl}';
    final Map<String, String> queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'dt': timestamp.toString(),
      'appid': apiKey, // Use the correct environment variable name
      'units': units,
      'lang': lang,
    };

    // Perform the API call
    final response = await apiClient.getWithParamData(uri, queryParams: queryParams);

    // Check if the response is valid
    if (response.statusCode != 200 || response.body == null) {
      throw Exception('Failed to fetch weather data for the given timestamp: ${response.statusText}');
    }

    return response;
  }
}
