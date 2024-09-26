// Suggested code may be subject to a license. Learn more: ~LicenseLog:3833831877.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:271742894.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:4280560151.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'ui/screens/splash_screen.dart';
import 'theme/theme.dart';
import 'helpers/get_di.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
