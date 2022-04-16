import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/bottom_navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

BottomNavigationBarItem AppNavItem({
  required double size,
  required Widget iconNormal,
  required Widget iconSelect,
  required BottomNavigationProvider bottomNavigationProvider,
  required String navText,
  required int navIndex,
}) {
  return BottomNavigationBarItem(
    icon: SizedBox(
      height: size,
      width: size,
      child: Center(child: bottomNavigationProvider.currentIndex == navIndex ? iconNormal : iconSelect),
    ),
    label: navText,
  );
}

BottomNavigationBarItem AppNavItemWithBadge({
  required double size,
  required Widget iconNormal,
  required Widget iconSelect,
  required BottomNavigationProvider bottomNavigationProvider,
  required String navText,
  required int navIndex,
  String? navBadge,
}) {
  return BottomNavigationBarItem(
    icon: Container(
      height: size,
      width: size * 2,
      child: Stack(
        children: [
          Center(child: bottomNavigationProvider.currentIndex == navIndex ? iconNormal : iconSelect),
          navBadge != null
            ? Container(
                padding: EdgeInsets.all(navBadge.length >= 3 ? 4 : 0),
                decoration: BoxDecoration(
                  color: kBadgeColor,
                  borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                ),
                constraints: BoxConstraints(
                  minWidth: kDefaultPadding,
                  minHeight: kDefaultPadding,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      navBadge,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 7.sp,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : Container(),
        ],
      ),
    ),
    label: navText,
  );
}
