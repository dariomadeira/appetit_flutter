import 'package:appetit/constants.dart';
import 'package:appetit/src/customs/appetit_icons.dart';
import 'package:appetit/src/providers/bottom_navigation_provider.dart';
import 'package:appetit/src/screens/home/widgets/app_nav_Item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: _bottomNavigationProvider.callScreen(_bottomNavigationProvider.currentIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 86,
        child: BottomNavigationBar(
          backgroundColor: kBackgroundLight,
          fixedColor: kPrimaryColor,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 11.sp,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 11.sp,
          ),
          elevation: 0,
          currentIndex: _bottomNavigationProvider.currentIndex,
          onTap: (index) {
            _bottomNavigationProvider.changeBottomBarIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          items: [
            AppNavItem(
              size: 32,
              iconNormal: Icon(Appetit.compass),
              iconSelect: Icon(Appetit.compass2),
              bottomNavigationProvider: _bottomNavigationProvider,
              navText: tr("bottom_nav_explorer"),
              navIndex: 0,
            ),
            AppNavItem(
              size: 32,
              iconNormal: Icon(Appetit.tableware2),
              iconSelect: Icon(Appetit.tableware),
              bottomNavigationProvider: _bottomNavigationProvider,
              navText: tr("bottom_nav_news"),
              navIndex: 1,
            ),
            AppNavItem(
              size: 32,
              iconNormal: Icon(Appetit.heart2),
              iconSelect: Icon(Appetit.heart),
              bottomNavigationProvider: _bottomNavigationProvider,
              navText: tr("bottom_nav_favorites"),
              navIndex: 2,
            ),
            AppNavItemWithBadge(
              size: 32,
              iconNormal: Icon(Appetit.bill2),
              iconSelect: Icon(Appetit.bill),
              bottomNavigationProvider: _bottomNavigationProvider,
              navText: tr("bottom_nav_cart"),
              navIndex: 3,
              // navBadge: "1"
            )
          ],
        ),
      ),
    );
  }
}
