import 'package:flutter/material.dart';
import 'package:weather_app/theme/theme.dart';

class CurrentWeatherDisplay extends StatelessWidget {
  final Map<String, dynamic> weatherData;
  final String? cityName;
  final VoidCallback onRefresh;

  const CurrentWeatherDisplay({super.key, 
    required this.weatherData,
    this.cityName,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final current = weatherData['current'];
    final temp = current['temp'];
    final humidity = current['humidity'];
    final windSpeed = current['wind_speed'];
    final weather = current['weather'][0];
    final icon = weather['icon'];
    final description = weather['description'];

    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF64B5F6), // Start color - sky blue
            Color(0xFF42A5F5), // End color - lighter blue
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF64B5F6).withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (cityName != null)
                  Text(
                    cityName!,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  onPressed: onRefresh,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Current Weather',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/$icon.png',
                  width: 50,
                  height: 50,
                  color: Colors.white, // Ensure icon color matches card background
                  colorBlendMode: BlendMode.srcATop,
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$temp°C',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(
                  Icons.speed,
                  color: Colors.white,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Wind Speed: $windSpeed m/s',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                const Icon(
                  Icons.water_drop,
                  color: Colors.white,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Humidity: $humidity%',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
