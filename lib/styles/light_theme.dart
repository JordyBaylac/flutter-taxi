import 'package:flutter/material.dart';

lightTheme() {
  final primary = Colors.grey[200];
  final onPrimary = Colors.black;
  final primaryVariant = Colors.white;

  final secondary = Colors.teal[400];
  final onSecondary = Colors.black87;
  final secondaryVariant = Colors.teal[300];

  final primaryTextTheme = TextTheme(
    button: TextStyle(color: onPrimary),
    title: TextStyle(color: onPrimary, fontSize: 24, fontWeight: FontWeight.bold),
    subtitle: TextStyle(color: onPrimary, fontSize: 14, fontStyle: FontStyle.italic),
    headline: TextStyle(color: onPrimary, fontSize: 18, fontWeight: FontWeight.bold),
    body1: TextStyle(color: onPrimary, fontSize: 16),
    body2: TextStyle(color: onPrimary, fontSize: 14),
    display1: TextStyle(color: onPrimary, fontSize: 16),
    display2: TextStyle(color: onPrimary, fontSize: 14),
  );

  return ThemeData(
    primaryColor: primary,
    accentColor: secondary,

    colorScheme: ColorScheme.light(
      primary: primary,
      onPrimary: onPrimary,
      primaryVariant: primaryVariant,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryVariant: secondaryVariant,
    ),

    // text
    textTheme: primaryTextTheme,
    primaryTextTheme: primaryTextTheme,
    accentTextTheme: TextTheme(
      button: TextStyle(color: onSecondary),
      title: TextStyle(color: onSecondary, fontSize: 24, fontWeight: FontWeight.bold),
      subtitle: TextStyle(color: onSecondary, fontSize: 14, fontStyle: FontStyle.italic),
      headline: TextStyle(color: onSecondary, fontSize: 18, fontWeight: FontWeight.bold),
      body1: TextStyle(color: onSecondary, fontSize: 16),
      body2: TextStyle(color: onSecondary, fontSize: 14),
      display1: TextStyle(color: onSecondary, fontSize: 16),
      display2: TextStyle(color: onSecondary, fontSize: 14),
    ),

    // elements
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: secondaryVariant,
    ),

    inputDecorationTheme: InputDecorationTheme(
        labelStyle: primaryTextTheme.display1,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: secondaryVariant,
            width: 1,
          ),
        )),
  );
}
