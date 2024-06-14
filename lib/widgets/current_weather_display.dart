import 'package:flutter/material.dart';
import 'package:weather_app/theme/theme.dart';

class CurrentWeatherDisplay extends StatelessWidget {
  final Map<String, dynamic> weatherData;
  final String? cityName;
  final VoidCallback onRefresh;

  const CurrentWeatherDisplay({
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
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          colors: [
            Color(0xFF64B5F6), // Start color - sky blue
            Color(0xFF42A5F5), // End color - lighter blue
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF64B5F6).withOpacity(0.4),
            blurRadius: 8,
            offset: Offset(0, 4),
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
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                IconButton(
                  icon: Icon(Icons.refresh, color: Colors.white),
                  onPressed: onRefresh,
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              'Current Weather',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/$icon.png',
                  width: 50,
                  height: 50,
                  color: Colors.white, // Ensure icon color matches card background
                  colorBlendMode: BlendMode.srcATop,
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$temp°C',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(
                  Icons.speed,
                  color: Colors.white,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Wind Speed: $windSpeed m/s',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Row(
              children: [
                Icon(
                  Icons.water_drop,
                  color: Colors.white,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Humidity: $humidity%',
                  style: TextStyle(
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
