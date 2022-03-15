import 'package:appetit/src/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:appetit/src/screens/onboarding/onboarding_screen.dart';
import 'package:appetit/src/routers/app_screens.dart';
import 'package:appetit/src/services/preferences_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {

    final _prefs = AppPreferences();
    final bool showOnboarding = _prefs.readPreferenceBool("userSeeOnboarding");

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
        theme: ThemeData(
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routes: appRoutes,
        home: showOnboarding ? LoginScreen() : OnboardingScreen(),
      ),
    );
  }
}