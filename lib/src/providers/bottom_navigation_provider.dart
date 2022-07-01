import 'package:appetit/src/screens/home/navs/cart/cart_nav.dart';
import 'package:appetit/src/screens/home/navs/explore/explore_nav.dart';
import 'package:appetit/src/screens/home/navs/favorites/favorites_nav.dart';
import 'package:appetit/src/screens/home/navs/feeds/feeds_navs.dart';
import 'package:flutter/material.dart';

class BottomNavigationProvider with ChangeNotifier {
  
  int currentIndex = 0;

  // CAMBIO DE LA BOTTOMBAR
  void changeBottomBarIndex(index) async {
    currentIndex = index;
    notifyListeners();
  }

  // MANEJO DE LAS TABS
  Widget callScreen(int index) {
    switch (index) {
      case 0:
        return ExploreNav();
      case 1:
        return FeedsNav();
      case 2:
        return FavoritesNav();
      case 3:
        return CartNav();
      default:
        return ExploreNav();
    }
  }
}
