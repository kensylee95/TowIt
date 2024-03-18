import 'package:flutter/material.dart';
import 'package:logistics_app/theme/app_color_scheme.dart';
import 'package:logistics_app/theme/app_text_theme.dart';
import 'package:logistics_app/theme/text_field_theme.dart';

class AppTheme{
  static ThemeData appThemeData = ThemeData(
        textTheme: AppTextTheme.lightTextTheme,
        colorScheme: AppColorScheme.lightColorScheme,
        inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
        useMaterial3: true,
      );
}