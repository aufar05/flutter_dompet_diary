import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.black),
      headlineMedium: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      displayMedium: TextStyle(color: Color.fromRGBO(5, 5, 5, 1)),
      bodySmall: TextStyle(color: Color.fromARGB(255, 27, 27, 27)),
    ),
    colorScheme: const ColorScheme.dark(
        primary: Color(0xffFFB3AD),
        onPrimary: Color(0xff68000A),
        primaryContainer: Color(0xff8A191C),
        onPrimaryContainer: Color(0xffFFDAD7),
        secondary: Color(0xff8E7B7B),
        onSecondary: Color(0xffFFFFFF),
        secondaryContainer: Color.fromARGB(255, 77, 69, 69),
        onSecondaryContainer: Color(0xff40000B),
        tertiary: Color(0xffE1C28C),
        onTertiary: Color(0xff402D04),
        tertiaryContainer: Color(0xff584319),
        onTertiaryContainer: Color(0xffFFDEA6),
        background: Color(0xff201A19),
        onBackground: Color(0xffEDE0DE),
        surface: Color(0xff201A19),
        onSurface: Color(0xffEDE0DE),
        surfaceVariant: Color(0xff534342),
        onSurfaceVariant: Color(0xffD8C2BF),
        outline: Color(0xffA08C8A),
        shadow: Color(0xff000000)));
