// lib/core/themes/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: Color(0xFF6B21A8),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF6B21A8),
      foregroundColor: Colors.white,
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: Color(0xFF6B21A8),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF6B21A8),
      foregroundColor: Colors.white,
    ),
  );
}
