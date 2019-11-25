import 'package:flutter/material.dart';
import 'package:zitotaxi/services/screen_service.dart';
import 'package:zitotaxi/services/theme_service.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        Positioned(
          // alignment: Alignment.topCenter,
          top: 50,

          child: _buildAboutContent(context),
        ),
        Align(
          alignment: screenIsLandscape(context) ? Alignment.bottomLeft : Alignment.bottomCenter,
          child: Image.asset(
            "assets/cars/chevy56.png",
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }

  _buildAboutContent(BuildContext context) {
    final content = <Widget>[
      Spacer(),
      CircleAvatar(
        backgroundImage: AssetImage(
          "assets/zito.jpg",
        ),
        minRadius: screenIsLandscape(context) ? 90 : 20,
        maxRadius: screenIsLandscape(context) ? 150 : 50,
      ),
      SizedBox(width: 20),
      Expanded(
        flex: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "My name is Alejandro Zito, I have been a taxi driver in Cuba for almost 10 years. I am 28 years old and I enjoy doing the best in my job.",
              style: primaryTextThemeOf(context).headline,
            ),
            SizedBox(height: 20),
            Text(
              "You can reach me anytime at zitotaxi@gmail.com, or call us at +5350000000",
              style: primaryTextThemeOf(context).body1,
            )
          ],
        ),
      ),
      Spacer(),
    ];

    Widget layout;

    if (screenIsLandscape(context)) {
      layout = Row(
        children: content,
      );
    } else {
      layout = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: content,
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      width: screenWidthOf(context),
      child: SingleChildScrollView(
        child: Container(
          height: screenHeightOf(context) * .6,
          child: layout,
        ),
      ),
    );
  }
}
