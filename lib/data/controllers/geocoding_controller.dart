import 'package:get/get.dart';
import '../repositories/geocoding_repository.dart';

class GeocodingController extends GetxController {
  final GeocodingRepository geocodingRepository;

  var isLoading = false.obs;
  var coordinates = {}.obs; // Holds the coordinates response
  var cityName = ''.obs;
  var errorMessage = ''.obs;

  GeocodingController({required this.geocodingRepository});

  /// Fetch coordinates for a given city name
  Future<void> fetchCoordinates(String cityName) async {
    isLoading.value = true; // Start loading
    try {
      final response = await geocodingRepository.getCoordinates(cityName);
      if (response.statusCode == 200) {
        List<dynamic> data = response.body;
        if (data.isNotEmpty) {
          coordinates.value = {'lat': data[0]['lat'], 'lon': data[0]['lon']};
          errorMessage.value = ''; // Clear any previous errors
        } else {
          errorMessage.value = 'No location data found for $cityName';
        }
      } else {
        errorMessage.value = 'Failed to fetch coordinates: ${response.statusText}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching coordinates: $e';
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  /// Fetch city name for given coordinates
  Future<void> fetchCityName(double lat, double lon) async {
    isLoading.value = true; // Start loading
    try {
      final response = await geocodingRepository.getCityName(lat, lon);
      if (response.statusCode == 200) {
        List<dynamic> data = response.body;
        if (data.isNotEmpty) {
          cityName.value = data[0]['name'];
          errorMessage.value = ''; // Clear any previous errors
        } else {
          errorMessage.value = 'No city name found for coordinates ($lat, $lon)';
        }
      } else {
        errorMessage.value = 'Failed to fetch city name: ${response.statusText}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching city name: $e';
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

}

