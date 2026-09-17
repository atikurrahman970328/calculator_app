import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette
  static const Color backgroundColor = Color(0xFF17171C);
  static const Color displayAreaColor = Color(0xFF2E2F38);
  static const Color primaryButtonColor = Color(0xFF2E2F38);
  static const Color secondaryButtonColor = Color(0xFF4E505F);
  static const Color accentButtonColor = Color(0xFF4B5EAA);
  static const Color textColorPrimary = Colors.white;
  static const Color textColorSecondary = Color(0xFF747477);

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: accentButtonColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textColorPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}