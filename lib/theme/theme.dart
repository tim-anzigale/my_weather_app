import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemUiOverlayStyle

// Define your custom theme
final ThemeData customTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white, // White scaffold background
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent, // Transparent app bar background color
    foregroundColor: Colors.grey[800], // Text color
    elevation: 0, // No shadow
    iconTheme: IconThemeData(color: Colors.grey[800]), // Icon color
    titleTextStyle: TextStyle(
      color: Colors.grey[800],
      fontWeight: FontWeight.bold,
      fontSize: 18, // Adjust size if necessary
    ),
    systemOverlayStyle: SystemUiOverlayStyle.dark, // Dark status bar text color
    scrolledUnderElevation: 0, // Ensure no change in elevation when scrolled
  ),
);

// Define a custom Card widget with a sky blue gradient
class GradientCard extends StatelessWidget {
  final Widget child;

  const GradientCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          colors: [
            Color(0xFF64B5F6), // Start color - sky blue
            Color(0xFF42A5F5), // End color - lighter blue
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF64B5F6).withOpacity(0.4),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: child,
      ),
    );
  }
}
