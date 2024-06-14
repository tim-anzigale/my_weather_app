import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const HourlyForecast({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final hourly = weatherData['hourly'];

    if (hourly == null || hourly.isEmpty) {
      return Center(child: Text('No hourly forecast data available'));
    }

    return Column(
      children: [
        Text('Hourly Forecast', style: TextStyle(fontSize: 20)),
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hourly.length,
            itemBuilder: (context, index) {
              final hour = hourly[index];
              final temp = hour['temp'];
              final icon = hour['weather'][0]['icon'];
              final dt = DateTime.fromMillisecondsSinceEpoch(hour['dt'] * 1000);
              final time = TimeOfDay.fromDateTime(dt);

              return Column(
                children: [
                  Text('${time.format(context)}'),
                  Image.network('https://openweathermap.org/img/wn/$icon.png'),
                  Text('$temp°C'),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
