import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.light,
  primaryColor: Colors.green,
  primarySwatch: Colors.green,
  textTheme:  TextTheme(
      bodyLarge: const TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.grey.shade500),
      bodySmall: const TextStyle(color: Colors.white)),
  elevatedButtonTheme: const ElevatedButtonThemeData(
      style:
          ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.white))),
 
  scaffoldBackgroundColor: Colors.grey.shade50,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.black)),
  cardColor: Colors.white,
  navigationBarTheme:
      const NavigationBarThemeData(backgroundColor: Colors.white),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.dark,
  primaryColor: Colors.green,
  primarySwatch: Colors.green,
  textTheme: TextTheme(
    bodyLarge: const TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.grey.shade500),
    bodySmall: const TextStyle(color: Colors.black),
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
      style:
          ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.white))),
  scaffoldBackgroundColor: const Color(0xFF212121),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF424242),
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white)),
  cardColor: const Color(0xFF424242),
  navigationBarTheme:
      const NavigationBarThemeData(backgroundColor: Color(0xFF424242)),
);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.green,
  onPrimary: Colors.white,
  secondary: Colors.green,
  onSecondary: Colors.white,
  error: Colors.red,
  onError: Color(0xFFFFFFFF),
  background: Color(0xFFFAFAFA),
  onBackground: Color(0xFFFAFAFA),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFFFFFFFF),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.green,
  onPrimary: Color.fromARGB(255, 156, 77, 77),
  secondary: Colors.green,
  onSecondary: Colors.white,
  error: Color.fromARGB(255, 170, 31, 21),
  onError: Color(0xFFFFFFFF),
  background: Colors.blue,
  onBackground: Color(0xFFE6E1E5),
  surface: Colors.blue,
  onSurface: Color(0xFFE6E1E5),
);
