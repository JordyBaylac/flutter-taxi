import 'package:flutter/material.dart';

import 'package:zitotaxi/ui/widgets/topbar.dart';

import 'booking_section.dart';
import 'explore_section.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: ExploreSection(),
          ),
          BookingSection(),
        ],
      ),
    );
  }
}
