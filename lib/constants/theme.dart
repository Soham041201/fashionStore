import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData customTheme() {
  return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFFE5E5E5),
      backgroundColor: const Color(0xFFE5E5E5),
      fontFamily: 'Poppins',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headline1: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 24 / 16,
            color: const Color(0xFF1C1C19),
            letterSpacing: 0.05),
        headline2: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 21 / 14,
          color: const Color(0xFF1C1C19),
          letterSpacing: 0.05,
        ),
        bodyText1: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 21 / 14,
          color: const Color(0xFF4B4A5A),
        ),
        bodyText2: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          height: 15 / 14,
          color: const Color(0xFF7154B8),
        ),
      ));
}
