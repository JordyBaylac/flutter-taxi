import 'package:flutter/material.dart';

ColorScheme colorSchemeOf(BuildContext context) => Theme.of(context).colorScheme;

TextTheme primaryTextThemeOf(BuildContext context) => Theme.of(context).primaryTextTheme;

TextTheme secondaryTextThemeOf(BuildContext context) => Theme.of(context).accentTextTheme;
