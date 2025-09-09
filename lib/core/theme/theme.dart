// lib/config/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColorA0,
      foregroundColor: textDarkColor, // Warna teks dan ikon di AppBar
      elevation: 0, // Tanpa bayangan
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        color: textDarkColor,
        fontSize: 24,
        fontWeight: FontWeight.normal,
      ),
      toolbarHeight: 150,
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black38,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.green, width: 2.0),
        insets: const EdgeInsets.symmetric(horizontal: 40, vertical: 4.0),
      ),
      labelStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.normal,
        color: textLightColor,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.normal,
        color: textLightColor,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.normal,
        color: textLightColor,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: textLightColor,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textLightColor,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textLightColor,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textLightColor,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: textLightColor,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textLightColor,
      ),
      bodyLarge: GoogleFonts.inter(fontSize: 18, color: textLightColor),
      bodyMedium: GoogleFonts.inter(fontSize: 16, color: textLightColor),
      bodySmall: GoogleFonts.inter(fontSize: 12, color: textLightColor),
      labelLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ), // Untuk tombol
      labelMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: textLightColor,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: textLightColor,
      ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primayColorA30,
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: textLightColor,
        side: const BorderSide(color: primaryColorA0, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceLightColorA0,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
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
      hintStyle: GoogleFonts.inter(color: textLightColor.withValues()),
    ),

    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.all(8.0),
    ),

    drawerTheme: DrawerThemeData(
      backgroundColor: primaryColorA0,
      elevation: 4,
      shadowColor: textLightColor.withAlpha(150),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: primaryColorA0,
      indicatorColor: Colors.white70,
      height: 65,
      labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.white,
          );
        }
        return GoogleFonts.inter(
          fontWeight: FontWeight.normal,
          fontSize: 12,
          color: Colors.black54,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: primaryColorA0, size: 26);
        }
        return IconThemeData(color: primayColorA50);
      }),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      overlayColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.amber;
      }),
    ),
    dataTableTheme: DataTableThemeData(
      dataRowColor: WidgetStateProperty.all(surfaceLightColorA10),
      headingRowColor: WidgetStateProperty.all(primaryColorA0),
      headingTextStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: textDarkColor,
      ),
      dataRowMinHeight: 40,
      dataRowMaxHeight: 50,
      columnSpacing: 10,
      dataTextStyle: GoogleFonts.inter(fontSize: 14, color: textLightColor),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: surfaceLightColorA0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textLightColor,
      ),
      contentTextStyle: GoogleFonts.inter(fontSize: 16, color: textLightColor),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      elevation: 3,
      shadowColor: textLightColor.withAlpha(150),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.light,
    primaryColor: primaryColorA0,
    primaryColorLight: primayColorA30,
    hintColor: accentColor, // Warna aksen untuk input, dll.
    scaffoldBackgroundColor: surfaceDarkColorA0,
    colorScheme: ColorScheme.dark(
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
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.normal,
        color: textDarkColor,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.normal,
        color: textDarkColor,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.normal,
        color: textDarkColor,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: textDarkColor,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textDarkColor,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textDarkColor,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textDarkColor,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: textDarkColor,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: textDarkColor,
      ),
      bodyLarge: GoogleFonts.inter(fontSize: 18, color: textLightColor),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16,
        color: const Color.fromRGBO(0, 0, 0, 0.867),
      ),
      bodySmall: GoogleFonts.inter(fontSize: 12, color: textLightColor),
      labelLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ), // Untuk tombol
      labelMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: textLightColor,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: textLightColor,
      ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: surfaceDarkColorA40,
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: textLightColor,
        side: const BorderSide(color: surfaceDarkColorA40, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceDarkColorA10,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
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
      hintStyle: GoogleFonts.inter(color: textDarkColor.withValues()),
    ),

    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.all(8.0),
    ),

    drawerTheme: DrawerThemeData(
      backgroundColor: surfaceDarkColorA10,
      elevation: 4,
      shadowColor: textLightColor.withAlpha(150),
    ),
  );
}
