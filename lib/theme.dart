import 'package:flutter/material.dart';

class GlobalThemeData {
  static final ColorScheme  colorScheme= 
  ColorScheme.fromSeed(seedColor: Colors.purple, 
  brightness: Brightness.light);

  static final ThemeData lightThemeData = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary, 
      foregroundColor: colorScheme.onPrimary
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: 
          WidgetStatePropertyAll(
            colorScheme.onPrimaryContainer),
            backgroundColor: 
            WidgetStatePropertyAll(colorScheme.primaryContainer)),
      ),
    );

}