import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/api/api_client.dart';
import 'package:weather_app/data/controllers/geocoding_controller.dart';
import 'package:weather_app/data/controllers/weather_controller.dart';
import 'package:weather_app/data/repositories/geocoding_repository.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/utils/environment.dart';

Future<void> init() async {
  // Core
  Get.putAsync(() => SharedPreferences.getInstance());
  Get.lazyPut(() => ApiClient(
      baseUrl: Environment.openWeatherBaseUrl,
        sharedPreferences: Get.find(),
      ));

  // Repositories
  Get.lazyPut(() => WeatherRepository(apiClient: Get.find()));
  Get.lazyPut(() => GeocodingRepository(apiClient: Get.find()));

  // Controllers
  Get.lazyPut(() => WeatherController(weatherRepository: Get.find()));
  Get.lazyPut(() => GeocodingController(geocodingRepository: Get.find()));
}
