import 'package:flutter/material.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color primaryColor = Color.fromARGB(255, 193, 33, 21);
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
        backgroundColor: primaryColor, iconTheme: IconThemeData(color: white)),
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
      primaryColor: darkGreyClr,
      scaffoldBackgroundColor: darkHeaderClr,
      brightness: Brightness.dark);
}
