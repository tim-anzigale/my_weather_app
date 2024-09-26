import 'package:get/get.dart';
import 'package:weather_app/data/api/api_client.dart';
import 'package:weather_app/utils/environment.dart';

class WeatherRepository extends GetxService {
  final ApiClient apiClient;

  WeatherRepository({required this.apiClient});

  Future<Response> fetchWeather({
    required double lat,
    required double lon,
    String? exclude,
    String units = 'metric',
    String lang = 'en',
  }) async {
    final String baseUrl = Environment.openWeatherBaseUrl;
    final String apiKey = Environment.openWeatherApiKey;
    final String uri = '$baseUrl${Environment.oneCallUrl}';
    final Map<String, String> queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': apiKey,
      'units': units,
      'lang': lang,
      if (exclude != null) 'exclude': exclude,
    };
    final response = await apiClient.getWithParamData(uri, queryParams: queryParams);
    if (response.statusCode != 200 || response.body == null) {
      throw Exception('Failed to fetch weather data: ${response.statusText}');
    }
    return response;
  }

  Future<Response> fetchWeatherByTimestamp({
    required double lat,
    required double lon,
    required int timestamp,
    String units = 'metric',
    String lang = 'en',
  }) async {
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
      'appid': apiKey,
      'units': units,
      'lang': lang,
    };
    final response = await apiClient.getWithParamData(uri, queryParams: queryParams);
    if (response.statusCode != 200 || response.body == null) {
      throw Exception(
          'Failed to fetch weather data for the given timestamp: ${response.statusText}');
    }
    return response;
  }
}
