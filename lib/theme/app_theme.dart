import 'package:flutter/material.dart';

class AppTheme {
  // Thème clair (si besoin)
  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    useMaterial3: false,
  );

  // Thème sombre personnalisé
  static ThemeData get dark => ThemeData.dark().copyWith(
    // Palette basée sur une seed pour cohérence
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.dark,
    ),

    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
    primaryColor: Colors.teal,
    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.teal.shade900,
      foregroundColor: Colors.white,
    ),
    // FloatingActionButton
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.tealAccent.shade200,
      foregroundColor: Colors.black,
    ),
    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    // Champs de texte
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.withOpacity(0.08),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      floatingLabelStyle: TextStyle(color: Colors.tealAccent.shade100),
    ),
    // Cartes
    cardColor: const Color(0xFF1E1E1E),
    cardTheme: CardTheme(
      color: const Color(0xFF1E1E1E),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    iconTheme: IconThemeData(color: Colors.tealAccent.shade100),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white70),
      titleMedium: TextStyle(color: Colors.white),
    ),
  );
}
