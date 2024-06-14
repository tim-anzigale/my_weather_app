import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyForecast extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const DailyForecast({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final daily = weatherData['daily'];

    if (daily == null || daily.isEmpty) {
      return Center(child: Text('No daily forecast data available'));
    }

    return Column(
      children: [
        //Text('Forecast', style: TextStyle(fontSize: 20)),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: daily.length,
          itemBuilder: (context, index) {
            final day = daily[index];
            final tempMax = day['temp']['max'];
            final tempMin = day['temp']['min'];
            final icon = day['weather'][0]['icon'];
            final dt = DateTime.fromMillisecondsSinceEpoch(day['dt'] * 1000);
            final dayOfWeek = DateFormat('EEEE').format(dt);

            return ListTile(
              leading: Image.network('https://openweathermap.org/img/wn/$icon.png'),
              title: Text(dayOfWeek),
              subtitle: Text('High: $tempMax°C, Low: $tempMin°C'),
            );
          },
        ),
      ],
    );
  }
}
