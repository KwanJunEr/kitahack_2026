import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00695C); // Teal 800
  static const Color accentColor = Color(0xFF4DB6AC); // Teal 300
  static const Color backgroundColor = Color(0xFFE0F2F1); // Teal 50

  //Gradient 1 
   static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF004D40), // Teal 900
      Color(0xFF00695C), // Teal 800
      Color(0xFF4DB6AC), // Teal 300
    ],
  );

    static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.white70,
          letterSpacing: 2.0, // For "SYSTEM INITIALIZING"
        ),
        labelSmall: TextStyle(
           fontSize: 14,
           color: Colors.white,
           letterSpacing: 1.5
        )
      ),
    );
  }
}