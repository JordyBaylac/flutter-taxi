import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/navigation_notifier.dart';
import 'styles/light_theme.dart';
import 'ui/pages/home/index.dart';
import 'ui/pages/about/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => NavigationNotifier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zito Taxi Cuba',
        theme: lightTheme(),
        home: RoutPage(),
      ),
    );
  }
}

class RoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // title: Text("Zito Taxi in Cuba"),
          // centerTitle: true,
          titleSpacing: 0,
          title: TabBar(
            tabs: [
              Tab(
                // icon: Icon(Icons.home),
                child: Text("Home"),
              ),
              Tab(
                // icon: Icon(Icons.live_help),
                child: Text("Contact us"),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            HomePage(),
            AboutPage(),
          ],
        ),
      ),
    );
  }
}
