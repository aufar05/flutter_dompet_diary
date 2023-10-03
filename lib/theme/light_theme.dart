import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  iconTheme: const IconThemeData(color: Color(0xffFFFFFF)),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Colors.black),
    titleMedium: TextStyle(color: Colors.black),
    headlineSmall: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
    ),
    displayMedium: TextStyle(color: Color(0xffFFFFFF)),
    bodySmall: TextStyle(color: Color(0xffFFFFFF)),
  ),
  colorScheme: const ColorScheme.light(
      primary: Color(0xffAC3230),
      onPrimary: Color(0xffFFFFFF),
      primaryContainer: Color(0xffFFDAD7),
      onPrimaryContainer: Color(0xff410004),
      secondary: Color(0xff8E7B7B),
      onSecondary: Color(0xffFFFFFF),
      secondaryContainer: Color.fromARGB(255, 255, 230, 230),
      onSecondaryContainer: Color(0xff40000B),
      tertiary: Color(0xff725B2E),
      onTertiary: Color(0xffFFFFFF),
      tertiaryContainer: Color(0xffFFDEA6),
      onTertiaryContainer: Color(0xff271900),
      background: Color(0xffFFFBFF),
      onBackground: Color(0xff201A19),
      surface: Color(0xffFFFBFF),
      onSurface: Color(0xff201A19),
      surfaceVariant: Color(0xffF5DDDB),
      onSurfaceVariant: Color(0xff534342),
      outline: Color(0xff857371),
      shadow: Color(0xff000000)),
);
