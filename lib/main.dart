import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/weather_screen.dart';
import 'screens/splash_screen.dart'; 
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
        
      ],
      child: MaterialApp(
        theme: customTheme,
        home: SplashScreen(), 
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
