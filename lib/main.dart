import 'package:appetit/src/screens/auth/login_screen.dart';
import 'package:appetit/src/widgets/states/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:appetit/src/screens/onboarding/onboarding_screen.dart';
import 'package:appetit/src/routers/app_screens.dart';
// import 'package:appetit/src/screens/home/home_screen.dart';
import 'package:appetit/src/services/preferences_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final _prefs = AppPreferences();
  await _prefs.initPref();
  await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, 'assets/svgs/appLogo.svg'), null);
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('es'),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
        title: 'Appetit',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routes: appRoutes,
        home: OnboardingScreen(),
        // home: Scaffold (
        //   body: Center(
        //     child: LoadingWidget(),
        //   ),
        // ),
        // home: LoginScreen(),
        // home: OnboardingScreen(),
      ),
    );
  }
}