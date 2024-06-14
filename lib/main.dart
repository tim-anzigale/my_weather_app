import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/weather_screen.dart';
import 'services/weather_provider.dart';
import 'theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MaterialApp(
        theme: customTheme,
        home: WeatherScreen(),
        debugShowCheckedModeBanner: false, // Remove the debug banner
      ),
    );
  }
}
