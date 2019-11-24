import 'package:flutter/material.dart';
import 'package:zitotaxi/services/screen_service.dart';
import 'package:zitotaxi/services/theme_service.dart';

class ExploreSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = screenHeightOf(context);
    final width = screenWidthOf(context);
    final isLandscape = screenIsLandscape(context);
    final sectionHeight = isLandscape ? height * .37 : height * .25;
    final cardHeight = sectionHeight * .60;
    final cardWidth = width * .25;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: (isLandscape ? 50 : 20), vertical: (isLandscape ? 20 : 10)),
      height: sectionHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Explore Cuba with us",
            style: primaryTextThemeOf(context).title,
          ),
          Row(
            children: <Widget>[
              _buildCard(context),
            ],
          )
        ],
      ),
    );
  }

  _buildCard(BuildContext context) {
    final height = screenHeightOf(context);
    final width = screenWidthOf(context);
    final isLandscape = screenIsLandscape(context);
    final sectionHeight = isLandscape ? height * .37 : height * .25;
    final cardHeight = sectionHeight * .60;
    final cardWidth = width * .25;

    final image = Container(
      child: Image.asset(
        "assets/cuba/capitolio.jpg",
        height: isLandscape ? cardHeight : cardHeight * .75,
        width: isLandscape ? cardWidth * .60 : cardWidth,
        fit: BoxFit.fitHeight,
      ),
    );

    final content = Container(
      width: isLandscape ? cardWidth * .40 : cardWidth,
      height: isLandscape ? cardHeight : cardHeight * 0.25,
      padding: EdgeInsets.all(isLandscape ? 10 : 3),
      color: colorSchemeOf(context).primary.withOpacity(.9),
      child: Column(
        children: <Widget>[
          Text(
            "Capitolio",
            style: primaryTextThemeOf(context).headline.apply(fontSizeFactor: .75),
          ),
          SizedBox(height: isLandscape ? 10 : 0),
          isLandscape
              ? Text(
                  "El Capitolio, or the National Capitol Building (Capitolio Nacional de La Habana) is a public edifice and one of the most visited sites in Havana, capital of Cuba. ",
                  style: primaryTextThemeOf(context).body2,
                  maxLines: 6,
                  softWrap: true,
                )
              : SizedBox(),
        ],
      ),
    );

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        child: isLandscape
            ? Row(
                children: <Widget>[image, content],
              )
            : Column(
                children: <Widget>[image, content],
              ),
      ),
    );
  }
}
