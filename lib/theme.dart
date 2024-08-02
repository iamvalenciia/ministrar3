import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeDataStyle {
  static final TextTheme _socialMediaTextTheme = TextTheme(
    headlineSmall: GoogleFonts.openSans(
      fontWeight: FontWeight.w700,
      color: Colors.teal,
    ),
    titleMedium: GoogleFonts.openSans(
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleSmall: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      color: Colors.black54,
    ),
    bodyLarge: GoogleFonts.openSans(
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodyMedium: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodySmall: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
  );

  static ThemeData light = ThemeData(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    useMaterial3: true,
    textTheme: _socialMediaTextTheme,
  );

  static ThemeData dark = ThemeData(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.teal, brightness: Brightness.dark),
    useMaterial3: true,
    textTheme: _socialMediaTextTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  );
}
