import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'screens/weather_screen.dart';
import 'screens/splash_screen.dart';
import 'services/weather_provider.dart';
import 'theme/theme.dart';
import 'helpers/get_di.dart' as di; // Import the dependency injection file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the dependencies
  await di.init();

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
      child: GetMaterialApp( // Use GetMaterialApp for GetX navigation
        theme: customTheme,
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
