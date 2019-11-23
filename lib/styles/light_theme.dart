import 'package:flutter/material.dart';

lightTheme() {
  return ThemeData(
    colorScheme: ColorScheme.light(
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.yellow[400],
        onSecondary: Colors.black87,
        secondaryVariant: Colors.yellow[300]),
  );
}
