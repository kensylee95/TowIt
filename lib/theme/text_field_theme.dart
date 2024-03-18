
import 'package:flutter/material.dart';
import 'package:logistics_app/config/colors.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();
  static InputDecorationTheme lightInputDecorationTheme =
      InputDecorationTheme(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10)
      ),
    border: OutlineInputBorder(
       borderRadius: BorderRadius.circular(10),
      borderSide:BorderSide.none
    ),
    hintStyle: TextStyle(color: Colors.grey.shade400),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        width: 4.0,
        color: primary,
      ),
    ),
  );
}