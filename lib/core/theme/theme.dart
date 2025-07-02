// lib/config/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  // Warna-warna utama aplikasi
  static const Color primaryColorA0 = Color(0xff60befc);
  static const Color primayColorA30 = Color(0xff74a9d1);
  static const Color primayColorA50 = Color(0xff7b9bb6);
  static const Color surfaceLightColorA0 = Color(0xfffcfdff);
  static const Color surfaceLightColorA10 = Color(0xffedeef0);
  static const Color surfaceLightColorA40 = Color(0xffc3c4c5);
  static const Color surfaceDarkColorA0 = Color(0xff121212);
  static const Color surfaceDarkColorA10 = Color(0xff282828);
  static const Color surfaceDarkColorA40 = Color(0xff717171);
  static const Color accentColor = Color(0xFF0d3753);
  static const Color errorColor = Color(0xFFB00020);
  static const Color textLightColor = Colors.black87;
  static const Color textDarkColor = Colors.white;

  // Tema terang (Light Theme)
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.light,
    primaryColor: primaryColorA0,
    primaryColorLight: primayColorA30,
    hintColor: accentColor, // Warna aksen untuk input, dll.
    scaffoldBackgroundColor: surfaceLightColorA0,
    colorScheme: ColorScheme.light(
      primary: primaryColorA0,
      primaryContainer: primayColorA30,
      secondary: accentColor,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onError: Colors.white,
      onSurface: textLightColor,
    ),
    appBarTheme: const AppBarTheme(
      color: primaryColorA0,
      foregroundColor: textDarkColor, // Warna teks dan ikon di AppBar
      elevation: 0, // Tanpa bayangan
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: textDarkColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.normal, color: textLightColor),
      displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.normal, color: textLightColor),
      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.normal, color: textLightColor),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textLightColor),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textLightColor),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textLightColor),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textLightColor),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textLightColor),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textLightColor),
      bodyLarge: TextStyle(fontSize: 16, color: textLightColor),
      bodyMedium: TextStyle(fontSize: 14, color: textLightColor),
      bodySmall: TextStyle(fontSize: 12, color: textLightColor),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white), // Untuk tombol
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: textLightColor),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: textLightColor),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: primayColorA30,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primayColorA30, // Background button
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
        foregroundColor: primayColorA30,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: textLightColor,
        side: const BorderSide(color: primaryColorA0,width: 2),
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
      fillColor: surfaceLightColorA0,
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none, // Tanpa border default
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primaryColorA0, width: 2.0),
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
      labelStyle: const TextStyle(color: textLightColor),
      hintStyle: TextStyle(color: textLightColor.withValues()),
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(8.0),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: primaryColorA0,
      elevation: 4,
      shadowColor: textLightColor.withAlpha(150),
    )
  );

  static final ThemeData darkTheme = ThemeData(
     useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.light,
    primaryColor: primaryColorA0,
    primaryColorLight: primayColorA30,
    hintColor: accentColor, // Warna aksen untuk input, dll.
    scaffoldBackgroundColor: surfaceDarkColorA0,
    colorScheme: ColorScheme.light(
      primary: primaryColorA0,
      primaryContainer: primayColorA30,
      secondary: accentColor,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onError: Colors.white,
      onSurface: textLightColor,
    ),
    appBarTheme: const AppBarTheme(
      color: surfaceDarkColorA10,
      foregroundColor: textDarkColor, // Warna teks dan ikon di AppBar
      elevation: 0, // Tanpa bayangan
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: textDarkColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.normal, color: textDarkColor),
      displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.normal, color: textDarkColor),
      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.normal, color: textDarkColor),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textDarkColor),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textDarkColor),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textDarkColor),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textDarkColor),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textDarkColor),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textDarkColor),
      bodyLarge: TextStyle(fontSize: 16, color: textDarkColor),
      bodyMedium: TextStyle(fontSize: 14, color: textDarkColor),
      bodySmall: TextStyle(fontSize: 12, color: textDarkColor),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textLightColor), // Untuk tombol
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: textDarkColor),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: textDarkColor),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: surfaceDarkColorA40,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: surfaceDarkColorA40, // Background button
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
        foregroundColor: surfaceDarkColorA40,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: textLightColor,
        side: const BorderSide(color: surfaceDarkColorA40,width: 2),
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
      fillColor: surfaceDarkColorA10,
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none, // Tanpa border default
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: surfaceDarkColorA40, width: 2.0),
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
      labelStyle: const TextStyle(color: textDarkColor),
      hintStyle: TextStyle(color: textDarkColor.withValues()),
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(8.0),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: surfaceDarkColorA10,
      elevation: 4,
      shadowColor: textLightColor.withAlpha(150),
    )
    
  );
}
