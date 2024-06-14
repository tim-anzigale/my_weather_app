import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '7aeb94610fca0886bd64cf2987e71a30';

  Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=minutely,hourly,alerts&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> weatherData = json.decode(response.body);
      print('Weather Data: $weatherData'); // Print data to console
      return weatherData;
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
  }
}
