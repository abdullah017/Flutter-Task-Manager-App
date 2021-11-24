
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.red,
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[200],
    shadowColor: Colors.grey, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
  );
  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.grey[900],
    cardColor: Colors.grey[900],
    scaffoldBackgroundColor: Colors.grey[800],
    shadowColor: Colors.grey, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.grey[300]),
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.grey[400] : Colors.grey),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : Colors.black),
  );
}

TextStyle get dateStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.grey,
    ),
  );
}

TextStyle get dayStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.grey,
    ),
  );
}

TextStyle get monthStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.grey,
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 14,
        color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600]),
  );
}
