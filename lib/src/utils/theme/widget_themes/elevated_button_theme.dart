import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/colors.dart';

class MyElevatedButtonTheme {
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      foregroundColor: lightColor,
      backgroundColor: secondaryColor,
      side: const BorderSide(color: secondaryColor),
      padding: const EdgeInsets.symmetric(vertical: 15),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      foregroundColor: secondaryColor,
      backgroundColor: lightColor,
      side: const BorderSide(color: lightColor),
      padding: const EdgeInsets.symmetric(vertical: 15),
    ),
  );
}
