import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeDataStyle {
  static ThemeData light = ThemeData(
    fontFamily: GoogleFonts.notoSans().fontFamily,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    useMaterial3: true,
  );

  static ThemeData dark = ThemeData(
    fontFamily: GoogleFonts.notoSans().fontFamily,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.teal, brightness: Brightness.dark),
    useMaterial3: true,
  );
}
