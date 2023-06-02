import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFFFE3E6D);
  static const accentColor = Color(0xFF192F44);
  static const backgroundColor = Color(0xFFF5F5F5);
  static const lightBlueColor = Color.fromARGB(255, 200, 222, 236);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFBD0044),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFFD9DC),
    onPrimaryContainer: Color(0xFF400012),
    secondary: Color(0xFF00629E),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFCFE5FF),
    onSecondaryContainer: Color(0xFF001D34),
    tertiary: Color(0xFF006684),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFBDE9FF),
    onTertiaryContainer: Color(0xFF001F2A),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFFFBFF),
    onBackground: Color(0xFF410005),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF410005),
    surfaceVariant: Color(0xFFF4DDDE),
    onSurfaceVariant: Color(0xFF524344),
    outline: Color(0xFF847374),
    onInverseSurface: Color(0xFFFFEDEB),
    inverseSurface: Color(0xFF5F1416),
    inversePrimary: Color(0xFFFFB2BB),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFBD0044),
  );

  static final darkColorScheme = lightColorScheme.copyWith(
    brightness: Brightness.dark,
    primary: const Color(0xFFFFB2BB),
    onPrimary: const Color(0xFF670021),
    primaryContainer: const Color(0xFF910032),
    onPrimaryContainer: const Color(0xFFFFD9DC),
    secondary: const Color(0xFF9ACBFF),
    onSecondary: const Color(0xFF003355),
    secondaryContainer: const Color(0xFF004A79),
    onSecondaryContainer: const Color(0xFFCFE5FF),
    tertiary: const Color(0xFF67D3FF),
    onTertiary: const Color(0xFF003546),
    tertiaryContainer: const Color(0xFF004D64),
    onTertiaryContainer: const Color(0xFFBDE9FF),
    error: const Color(0xFFFFB4AB),
    errorContainer: const Color(0xFF93000A),
    onError: const Color(0xFF690005),
    onErrorContainer: const Color(0xFFFFDAD6),
    background: const Color(0xFF410005),
    onBackground: const Color(0xFFFFDAD7),
    surface: const Color(0xFF410005),
    onSurface: const Color(0xFFFFDAD7),
    surfaceVariant: const Color(0xFF524344),
    onSurfaceVariant: const Color(0xFFD7C1C3),
    outline: const Color(0xFF9F8C8D),
    onInverseSurface: const Color(0xFF410005),
    inverseSurface: const Color(0xFFFFDAD7),
    inversePrimary: const Color(0xFFBD0044),
    shadow: const Color(0xFF000000),
    surfaceTint: const Color(0xFFFFB2BB),
  );
}
