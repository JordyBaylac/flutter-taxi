import 'package:flutter/material.dart';
import 'package:zitotaxi/services/screen_service.dart';
import 'package:zitotaxi/services/theme_service.dart';

import 'booking_section.dart';
import 'explore_section.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
                Colors.white,
                colorSchemeOf(context).secondary,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Align(
          alignment: screenIsLandscape(context) ? Alignment.bottomLeft : Alignment.center,
          child: Image.asset(
            "assets/cars/chevy56_2.png",
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: ExploreSection(),
        ),
        BookingSection(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
