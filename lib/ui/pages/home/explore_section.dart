import 'package:flutter/material.dart';
import 'package:zitotaxi/models/place.dart';
import 'package:zitotaxi/services/places_service.dart';
import 'package:zitotaxi/services/screen_service.dart';
import 'package:zitotaxi/services/theme_service.dart';

class ExploreSection extends StatelessWidget {
  _sectionHeight(BuildContext context) =>
      screenIsLandscape(context) ? screenHeightOf(context) * .37 : screenHeightOf(context) * .30;

  _sectionWidth(BuildContext context) => screenWidthOf(context);

  _cardHeight(BuildContext context) => _sectionHeight(context) * .60;

  _cardWidth(BuildContext context) => _sectionWidth(context) * .25;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorSchemeOf(context).primary,
      padding: EdgeInsets.symmetric(
        horizontal: (screenIsLandscape(context) ? 50 : 25),
        vertical: (screenIsLandscape(context) ? 25 : 15),
      ),
      height: _sectionHeight(context),
      width: _sectionWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Explore Cuba with us",
            style: primaryTextThemeOf(context).title.apply(fontSizeFactor: .85),
          ),
          FutureBuilder(
            future: placesGetIconic(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container();
              } else if (!snapshot.hasData) {
                return Container();
              }

              final places = snapshot.data as List<Place>;
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: _cardHeight(context),
                ),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: places.length,
                  separatorBuilder: (context, idx) {
                    return SizedBox(width: 20);
                  },
                  itemBuilder: (context, idx) {
                    return _buildCard(context, places[idx]);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _buildCard(BuildContext ctx, Place place) {
    final image = Container(
      child: Image.asset(
        place.imageUrl,
        height: screenIsLandscape(ctx) ? _cardHeight(ctx) : _cardHeight(ctx) * .70,
        width: screenIsLandscape(ctx) ? _cardWidth(ctx) * .60 : _cardWidth(ctx),
        fit: BoxFit.fitHeight,
      ),
    );

    final content = Container(
      width: screenIsLandscape(ctx) ? _cardWidth(ctx) * .40 : _cardWidth(ctx),
      padding: EdgeInsets.all(screenIsLandscape(ctx) ? 10 : 0),
      color: colorSchemeOf(ctx).secondary.withOpacity(.9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(),
          Text(
            place.name,
            style: primaryTextThemeOf(ctx).headline.apply(fontSizeFactor: .75),
          ),
          SizedBox(height: screenIsLandscape(ctx) ? 10 : 0),
          screenIsLandscape(ctx)
              ? Text(
                  place.description,
                  style: primaryTextThemeOf(ctx).body2,
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
        width: _cardWidth(ctx),
        height: _cardHeight(ctx),
        child: screenIsLandscape(ctx)
            ? Row(
                children: <Widget>[image, content],
              )
            : Column(
                children: <Widget>[
                  Expanded(flex: 2, child: image),
                  Expanded(
                    flex: 1,
                    child: content,
                  ),
                ],
              ),
      ),
    );
  }
}
