import 'package:get/get.dart';
import 'package:weather_app/data/api/api_client.dart';
import 'package:weather_app/utils/environmet.dart';


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
    final String uri = '${Environment.openWeatherBaseUrl}${Environment.oneCallUrl}';
    final Map<String, String> queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': Environment.weatherApiKey,
      'units': units,
      'lang': lang,
    };

    if (exclude != null) {
      queryParams['exclude'] = exclude;
    }

    return await apiClient.getWithParamData(uri, queryParams: queryParams);
  }

  /// Fetch weather data for a specific timestamp using the Time Machine API
  Future<Response> fetchWeatherByTimestamp({
    required double lat,
    required double lon,
    required int timestamp,
    String units = 'metric',
    String lang = 'en',
  }) async {
    final String uri = '${Environment.openWeatherBaseUrl}${Environment.timeMachineUrl}';
    final Map<String, String> queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'dt': timestamp.toString(),
      'appid': Environment.weatherApiKey,
      'units': units,
      'lang': lang,
    };

    return await apiClient.getWithParamData(uri, queryParams: queryParams);
  }

}


