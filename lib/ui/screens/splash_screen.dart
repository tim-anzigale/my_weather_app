// Suggested code may be subject to a license. Learn more: ~LicenseLog:3446681628.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:889060271.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3758221875.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/ui/screens/weather_screen.dart'; 

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => const WeatherScreen());
    });

    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 110, 59), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Text(
              'Weatherly',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
