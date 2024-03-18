import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logistics_app/config/colors.dart';
class AppTextTheme{
  static TextTheme lightTextTheme = TextTheme(
   //display
   displayLarge: GoogleFonts.montserrat(fontSize: 36, fontWeight: FontWeight.bold, color: lightTextColor),
   displayMedium: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.bold, color: lightTextColor),
   displaySmall: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold, color: lightTextColor),
   //headline
   headlineLarge: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.bold, color: lightTextColor),
   headlineMedium: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: lightTextColor),
   headlineSmall: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, color: lightTextColor),
   //title
   titleLarge: GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.w900, color: lightTextColor),
   titleMedium: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold, color: lightTextColor),
   titleSmall: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, color: lightTextColor),
  //label
  labelLarge: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold, color: lightTextColor),
  labelMedium: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, color: lightTextColor),
  labelSmall: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold, color: lightTextColor),
  //body
  bodyLarge: GoogleFonts.montserrat(fontSize: 18, color: lightTextColor),
  bodyMedium: GoogleFonts.montserrat(fontSize: 16,  color: lightTextColor),  
  bodySmall: GoogleFonts.montserrat(fontSize: 14, color: lightTextColor),
  ) ;
  }