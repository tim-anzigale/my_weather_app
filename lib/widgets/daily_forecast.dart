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

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF64B5F6), // Start color - sky blue
                      Color(0xFF42A5F5), // End color - lighter blue
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Image.network(
                        'https://openweathermap.org/img/wn/$icon.png',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dayOfWeek,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'High: $tempMax°C, Low: $tempMin°C',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
