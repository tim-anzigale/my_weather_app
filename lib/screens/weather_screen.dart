import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../services/weather_provider.dart';
import '../services/geolocator_service.dart';
import '../services/geocoding_service.dart';
import '../widgets/current_weather_display.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/daily_forecast.dart';
import '../utils/cities.dart'; 

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool isLoading = true;
  String? errorMessage;
  String? cityName;
  String? selectedCity;
  final GeocodingService geocodingService = GeocodingService('7aeb94610fca0886bd64cf2987e71a30');

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather({String? city}) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      double? latitude;
      double? longitude;

      if (city != null && city != 'Use My Location') {
        final coordinates = await geocodingService.getCoordinates(city);
        latitude = coordinates!.lat;
        longitude = coordinates.lon;
      } else {
        Position position = await getCurrentLocation();
        latitude = position.latitude;
        longitude = position.longitude;
        
        selectedCity = 'Use My Location';
      }

      await Provider.of<WeatherProvider>(context, listen: false)
          .fetchWeather(latitude, longitude);

      cityName = city != null && city != 'Use My Location'
          ? city
          : await geocodingService.getCityName(latitude, longitude);
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
        automaticallyImplyLeading: false, 
        title: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: false,
                      value: selectedCity,
                      hint: const Text('Select a City'),
                      items: [
                        const DropdownMenuItem<String>(
                          value: 'Use My Location',
                          child: Text('My Location'),
                        ),
                        ...kenyanCities.map((String city) {
                          return DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                      ],
                      onChanged: (newValue) {
                        setState(() {
                          selectedCity = newValue;
                        });
                        _loadWeather(city: newValue);
                      },
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.location_on),
              onPressed: () => _loadWeather(),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : weatherData != null
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                      child: Column(
                        children: [
                          CurrentWeatherDisplay(
                            weatherData: weatherData,
                            cityName: cityName,
                            onRefresh: () => _loadWeather(city: selectedCity),
                          ),
                          const SizedBox(height: 16.0),
                          HourlyForecast(weatherData: weatherData),
                          const SizedBox(height: 16.0),
                          DailyForecast(weatherData: weatherData),
                        ],
                      ),
                    )
                  : const Center(child: Text('No weather data available')),
    );
  }
}
