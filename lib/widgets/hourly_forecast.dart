import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widgets/glassmorphism.dart';

class HourlyForecast extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const HourlyForecast({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final hourly = weatherData['hourly'];

    if (hourly == null || hourly.isEmpty) {
      return const Center(child: Text('No hourly forecast data available'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: hourly.map<Widget>((hour) {
          final temp = hour['temp'];
          final humidity = hour['humidity'];
          final windSpeed = hour['wind_speed'];
          final icon = hour['weather'][0]['icon'];
          final dt = DateTime.fromMillisecondsSinceEpoch(hour['dt'] * 1000);
          final time = TimeOfDay.fromDateTime(dt);

          return GlassMorphism(
            blur: 20.0,
            opacity: 0.1,
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              width: 140,
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${time.format(context)}',
                    style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  Image.network('https://openweathermap.org/img/wn/$icon.png'),
                  const SizedBox(height: 8.0),
                  Text('$temp°C', style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.water_drop,
                        color: Colors.white,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text('$humidity%', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.air,
                        color: Colors.white,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text('$windSpeed m/s', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}