import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/colors.dart';

class MyOutlinedButtonTheme{
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      foregroundColor: secondaryColor,
      side: const BorderSide(color: secondaryColor),
      padding: const EdgeInsets.symmetric(vertical: 15),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      foregroundColor: lightColor,
      side: const BorderSide(color: lightColor),
      padding: const EdgeInsets.symmetric(vertical: 15),
    ),
  );
}