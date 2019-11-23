import 'package:flutter/material.dart';

import 'ui/pages/home.dart';
import 'styles/light_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme(),
      home: HomePage(),
    );
  }
}
