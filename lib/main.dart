import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv
import 'ui/screens/weather_screen.dart';
import 'ui/screens/splash_screen.dart';
import 'theme/theme.dart';
import 'helpers/get_di.dart' as di; // Import the dependency injection file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize the dependencies
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      theme: customTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
