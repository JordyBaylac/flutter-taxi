import 'package:flutter/material.dart';

enum Page { home, about }

class NavigationNotifier extends ChangeNotifier {
  var selectedPage = Page.home;

  void selectPage(Page page) {
    if (selectedPage != page) {
      print("changed to page $page");
      selectedPage = page;
      notifyListeners();
    }
  }
}
