import 'package:flutter/material.dart';

enum Page { home, about }

class NavigationNotifier extends ChangeNotifier {
  var selectedPage = Page.home;

  void selectPage(Page page) {
    selectedPage = page;
    notifyListeners();
  }
}
