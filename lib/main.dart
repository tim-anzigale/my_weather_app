import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/weather_screen.dart';
import 'screens/splash_screen.dart'; // Import your splash screen
import 'services/weather_provider.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        // Add more providers if needed
      ],
      child: MaterialApp(
        theme: customTheme,
        home: SplashScreen(), // Show SplashScreen initially
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
