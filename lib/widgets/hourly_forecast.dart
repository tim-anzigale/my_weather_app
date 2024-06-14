import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GradientCard extends StatelessWidget {
  final Widget child;

  const GradientCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: child,
      ),
    );
  }
}

class HourlyForecast extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const HourlyForecast({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final hourly = weatherData['hourly'];

    if (hourly == null || hourly.isEmpty) {
      return Center(child: Text('No hourly forecast data available'));
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

          return GradientCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${time.format(context)}',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Image.network('https://openweathermap.org/img/wn/$icon.png'),
                SizedBox(height: 8.0),
                Text('$temp°C', style: TextStyle(color: Colors.white)),
                SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.water_drop,
                      color: Colors.white,
                      size: 16.0,
                    ),
                    SizedBox(width: 4.0),
                    Text('$humidity%', style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.air,
                      color: Colors.white,
                      size: 16.0,
                    ),
                    SizedBox(width: 4.0),
                    Text('$windSpeed m/s', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
