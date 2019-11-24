import 'package:flutter/widgets.dart';

screenHeightOf(BuildContext context) => MediaQuery.of(context).size.height;
screenWidthOf(BuildContext context) => MediaQuery.of(context).size.width;
screenIsLandscape(BuildContext context) => screenWidthOf(context) > screenHeightOf(context);
