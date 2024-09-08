import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/api/api_client.dart';
import 'package:weather_app/data/controllers/geocoding_controller.dart';
import 'package:weather_app/data/controllers/weather_controller.dart';
import 'package:weather_app/data/repositories/geocoding_repository.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/utils/environmet.dart';



Future<void> init() async {
  // Core
  await Get.putAsync<SharedPreferences>(() => SharedPreferences.getInstance());
  Get.lazyPut<ApiClient>(
    () => ApiClient(
      baseUrl: Environment.openWeatherBaseUrl,
      sharedPreferences: Get.find<SharedPreferences>(),
    ),
  );

  // Repositories
  Get.lazyPut<WeatherRepository>(
    () => WeatherRepository(
      apiClient: Get.find<ApiClient>(),
    ),
  );

  Get.lazyPut<GeocodingRepository>(
    () => GeocodingRepository(
      apiClient: Get.find<ApiClient>(),
    ),
  );

  // Controllers
  Get.lazyPut<WeatherController>(
    () => WeatherController(
      weatherRepository: Get.find<WeatherRepository>(),
    ),
  );

  Get.lazyPut<GeocodingController>(
    () => GeocodingController(
      geocodingRepository: Get.find<GeocodingRepository>(),
    ),
  );

}


