import 'package:flutter/material.dart';
import 'package:zitotaxi/services/screen_service.dart';
import 'package:zitotaxi/services/theme_service.dart';
import 'package:zitotaxi/ui/widgets/topbar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = screenHeightOf(context);
    final width = screenWidthOf(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: TopBar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: colorSchemeOf(context).primary,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: colorSchemeOf(context).secondary,
            ),
          )
        ],
      ),
    );
  }
}
