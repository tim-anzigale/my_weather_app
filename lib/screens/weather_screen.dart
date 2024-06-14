import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../services/weather_provider.dart';
import '../services/geolocator_service.dart';
import '../services/geocoding_service.dart';
import '../widgets/current_weather_display.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/daily_forecast.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool isLoading = true;
  String? errorMessage;
  String? cityName;
  final GeocodingService geocodingService = GeocodingService('7aeb94610fca0886bd64cf2987e71a30'); // Replace with your actual API key

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      Position position = await getCurrentLocation();
      await Provider.of<WeatherProvider>(context, listen: false)
          .fetchWeather(position.latitude, position.longitude);
      cityName = await geocodingService.getCityName(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context).weatherData;

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : weatherData != null
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          CurrentWeatherDisplay(
                            weatherData: weatherData,
                            cityName: cityName,
                            onRefresh: _loadWeather,  // Pass the refresh callback
                          ),
                         // HourlyForecast(weatherData: weatherData),
                          DailyForecast(weatherData: weatherData),
                        ],
                      ),
                    )
                  : Center(child: Text('No weather data available')),
    );
  }
}
