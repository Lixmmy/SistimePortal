// lib/config/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  // Warna-warna utama aplikasi
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color primaryLightColor = Color(0xFFBB86FC);
  static const Color accentColor = Color(0xFF03DAC6);
  static const Color errorColor = Color(0xFFB00020);
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Colors.black87;
  static const Color lightGrey = Color(0xFFF5F5F5);

  // Tema terang (Light Theme)
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    primaryColorLight: primaryLightColor,
    hintColor: accentColor, // Warna aksen untuk input, dll.
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      primaryContainer: primaryLightColor,
      secondary: accentColor,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onError: Colors.white,
      onSurface: textColor,
    ),
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      foregroundColor: Colors.white, // Warna teks dan ikon di AppBar
      elevation: 0, // Tanpa bayangan
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.normal, color: textColor),
      displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.normal, color: textColor),
      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.normal, color: textColor),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textColor),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textColor),
      bodyLarge: TextStyle(fontSize: 16, color: textColor),
      bodyMedium: TextStyle(fontSize: 14, color: textColor),
      bodySmall: TextStyle(fontSize: 12, color: textColor),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white), // Untuk tombol
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: textColor),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: textColor),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor, // Background button
        foregroundColor: Colors.white, // Text color button
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightGrey,
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none, // Tanpa border default
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primaryColor, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorColor, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorColor, width: 2.0),
      ),
      labelStyle: const TextStyle(color: textColor),
      hintStyle: TextStyle(color: textColor.withValues()),
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(8.0),
    ),
    // Anda bisa menambahkan properti lain seperti:
    // iconTheme: const IconThemeData(color: primaryColor),
    // sliderTheme: const SliderThemeData(...),
    // bottomNavigationBarTheme: const BottomNavigationBarThemeData(...),
  );

  // Anda juga bisa membuat tema gelap (Dark Theme) di sini
  // static final ThemeData darkTheme = ThemeData(...);
}