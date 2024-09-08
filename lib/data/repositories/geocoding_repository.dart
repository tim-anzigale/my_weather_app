import 'package:get/get.dart';

import 'package:weather_app/data/api/api_client.dart';
import 'package:weather_app/utils/environmet.dart';



class GeocodingRepository extends GetxService {
  final ApiClient apiClient;

  GeocodingRepository({required this.apiClient});

  /// Fetch coordinates for a given city name
  Future<Response> getCoordinates(String cityName) async {
    final String uri = '${Environment.openWeatherBaseUrl}${Environment.geocodingDirectUrl}';
    final Map<String, String> queryParams = {
      'q': cityName,
      'limit': '1',
      'appid': Environment.weatherApiKey,
    };

    return await apiClient.getWithParamData(uri, queryParams: queryParams);
  }

  /// Fetch city name for given coordinates
  Future<Response> getCityName(double lat, double lon) async {
    final String uri = '${Environment.openWeatherBaseUrl}${Environment.geocodingReverseUrl}';
    final Map<String, String> queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'limit': '1',
      'appid': Environment.weatherApiKey,
    };

    return await apiClient.getWithParamData(uri, queryParams: queryParams);
  }

}


