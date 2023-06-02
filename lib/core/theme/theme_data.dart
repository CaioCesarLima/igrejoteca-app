import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: AppColors.lightColorScheme,
    ).copyWith(
      scaffoldBackgroundColor: Colors.white
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: AppColors.darkColorScheme,
    );
  }
}