import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
    scaffoldBackgroundColor: white,
    appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        backgroundColor: white,
        iconTheme: IconThemeData(color: Colors.black)),
    
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
      primaryColor: darkGreyClr,
      appBarTheme:
          AppBarTheme(surfaceTintColor: Colors.transparent, color: darkGreyClr),
      scaffoldBackgroundColor: darkGreyClr,
      brightness: Brightness.dark);
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.grey[600] : Colors.grey));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get subtitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.grey[300] : Colors.grey[600]));
}
