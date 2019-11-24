import 'package:flutter/widgets.dart';
import 'package:sailor/sailor.dart';
import 'package:zitotaxi/ui/pages/about/index.dart';
import 'package:zitotaxi/ui/pages/home/index.dart';

class Routes {
  static final sailor = Sailor(
    options: SailorOptions(
      handleNameNotFoundUI: true,
    ),
  );

  static void createRoutes() {
    sailor
      ..addRoute(SailorRoute(
        name: "/home",
        builder: (context, args, params) {
          return HomePage();
        },
      ))
      ..addRoute(SailorRoute(
        name: "/about",
        builder: (BuildContext context, BaseArguments args, ParamMap params) {
          return AboutPage();
        },
      ));
  }
}
