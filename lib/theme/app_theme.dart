import 'package:flutter/material.dart';

class AppTheme {
  // ============ COULEURS PERSONNALISÉES ============
  static const Color primaryColor = Colors.teal;
  static const Color accentColor = Color(0xFF64FFDA);
  static const Color darkBackground = Color(0xFF1E1E1E);
  static const Color darkSurface = Color(0xFF2A2A2A);
  static const Color lightBackground = Color(0xFFF5F5F5);

  // ============ THÈME CLAIR ============
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    useMaterial3: false,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ),

    scaffoldBackgroundColor: lightBackground,
    primaryColor: primaryColor,

    // IMPORTANT: Définir explicitement la typographie
    typography: Typography.material2021(platform: TargetPlatform.android),

    appBarTheme: AppBarTheme(
      backgroundColor: lightBackground,
      foregroundColor: Colors.black,

      elevation: 0,
      // Forcer la même hauteur
      toolbarHeight: kToolbarHeight,
    ),

    // Désactiver le facteur d'échelle du texte
    // textTheme: ThemeData.light().textTheme.apply(fontSizeFactor: 1.0),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
  );

  // ============ THÈME SOMBRE ============
  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    useMaterial3: false,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ),

    scaffoldBackgroundColor: darkBackground,
    primaryColor: primaryColor,
    cardColor: darkSurface,

    // IMPORTANT: Utiliser la MÊME typographie que le thème clair
    typography: Typography.material2021(platform: TargetPlatform.android),

    // Désactiver le facteur d'échelle du texte
    // textTheme: ThemeData.dark().textTheme.apply(fontSizeFactor: 1.0),
    appBarTheme: AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: Colors.white,
      elevation: 0,
      // Forcer la même hauteur
      toolbarHeight: kToolbarHeight,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: Colors.black,
    ),

    // MÊME configuration que le thème clair
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: accentColor, width: 2),
      ),
    ),

    cardTheme: CardThemeData(
      color: darkSurface,
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
  );
}
