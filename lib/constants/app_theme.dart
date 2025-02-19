import 'package:flutter/material.dart';

class AppTheme {
  
  static const Color background = Color(0xFF1F1D2B);  
  static const Color white = Colors.white;
  static const Color accent = Color(0xFF4A80F0);  

  
  static const Color textLight = Colors.white;
  static const Color textGrey = Colors.white70;


  static ThemeData darkTheme = ThemeData(

    scaffoldBackgroundColor: background,
    primaryColor: accent,
    
    brightness: Brightness.dark,
    useMaterial3: true,

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: textLight,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textGrey,
        height: 1.5,
      ),
    ),
  );
}