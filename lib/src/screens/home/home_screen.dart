import 'package:appetit/constants.dart';
import 'package:appetit/src/customs/app_icons_icons.dart';
import 'package:appetit/src/customs/snacks_customs.dart';
import 'package:appetit/src/providers/auth_provider.dart';
// import 'package:appetit/src/customs/appetit_icons.dart';
import 'package:appetit/src/providers/bottom_navigation_provider.dart';
import 'package:appetit/src/screens/home/widgets/app_nav_Item_widget.dart';
import 'package:appetit/src/widgets/appbars/general_appbar_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _showAccountSuccessSnack(authProvider: _authProvider);
    });
    super.initState();
  }

  void _showAccountSuccessSnack({
    required AuthProvider authProvider,
  }) {
    if (authProvider.authStatus == "USER_LOGGED") {
      wSnackSuccess(message: authProvider.currentUser!.statusMessage, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {

    final _bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context);

    return Scaffold(
      appBar: const GeneralAppbarWidget(),
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
              iconNormal: Icon(AppIcons.compass),
              iconSelect: Icon(AppIcons.compass_l),
              bottomNavigationProvider: _bottomNavigationProvider,
              navText: tr("bottom_nav_explorer"),
              navIndex: 0,
            ),
            AppNavItem(
              size: 32,
              iconNormal: Icon(AppIcons.tableware),
              iconSelect: Icon(AppIcons.tableware_l),
              bottomNavigationProvider: _bottomNavigationProvider,
              navText: tr("bottom_nav_news"),
              navIndex: 1,
            ),
            AppNavItem(
              size: 32,
              iconNormal: Icon(AppIcons.heart),
              iconSelect: Icon(AppIcons.heart_l),
              bottomNavigationProvider: _bottomNavigationProvider,
              navText: tr("bottom_nav_favorites"),
              navIndex: 2,
            ),
            AppNavItemWithBadge(
              size: 32,
              iconNormal: Icon(AppIcons.bill),
              iconSelect: Icon(AppIcons.bill_l),
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
