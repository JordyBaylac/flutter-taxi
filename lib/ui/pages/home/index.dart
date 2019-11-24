import 'package:flutter/material.dart';

import 'package:zitotaxi/ui/widgets/topbar.dart';

import 'booking_section.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          BookingSection(),
        ],
      ),
    );
  }
}
