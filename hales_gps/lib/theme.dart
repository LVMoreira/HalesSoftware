import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Definição das cores principais
  static const Color backgroundColor = Colors.black;
  static const Color primaryColor = Color.fromARGB(255, 30, 30, 30);
  static const Color secondaryColor = Color(0xFF252A34);
  static const Color greenPastel = Color(0xFF3d584f);
  static const Color greenPastelText = Color.fromARGB(255, 138, 232, 199);
  static const Color accentColor = Color(0xFF08D9D6);
  static const Color textColor = Colors.white;
  static const Color textSecondaryColor = Colors.grey;

  // Definição do tema
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: primaryColor,
      textTheme: GoogleFonts.poppinsTextTheme(),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secondaryColor,
        labelStyle: TextStyle(color: textColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
