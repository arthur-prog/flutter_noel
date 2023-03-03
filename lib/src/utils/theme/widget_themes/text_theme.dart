import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    headline1: GoogleFonts.poppins(
      color: darkColor,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    headline2: GoogleFonts.poppins(
      color: darkColor,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    headline3: GoogleFonts.poppins(
      color: darkColor,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    headline4: GoogleFonts.poppins(
      color: darkColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    headline5: GoogleFonts.poppins(
      color: darkColor,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    bodyText1: GoogleFonts.poppins(
      color: darkColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodyText2: GoogleFonts.poppins(
      color: darkColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    subtitle1: GoogleFonts.poppins(
      color: darkColor,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    headline1: GoogleFonts.poppins(
      color: lightColor,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    headline2: GoogleFonts.poppins(
      color: lightColor,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    headline3: GoogleFonts.poppins(
      color: lightColor,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    headline4: GoogleFonts.poppins(
      color: lightColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    headline5: GoogleFonts.poppins(
      color: lightColor,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    bodyText1: GoogleFonts.poppins(
      color: lightColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodyText2: GoogleFonts.poppins(
      color: lightColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    subtitle1: GoogleFonts.poppins(
      color: lightColor,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  );
}