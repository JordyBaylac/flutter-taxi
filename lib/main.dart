import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

import 'styles/light_theme.dart';
import 'ui/pages/home/index.dart';
import 'ui/pages/routes.dart';

void main() {
  Routes.createRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zito Taxi Cuba',
      theme: lightTheme(),
      navigatorKey: Routes.sailor.navigatorKey,
      onGenerateRoute: Routes.sailor.generator(),
      navigatorObservers: [
        SailorLoggingObserver(),
      ],
      home: HomePage(),
    );
  }
}
