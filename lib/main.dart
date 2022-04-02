import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/auth_photo_provider.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:appetit/src/screens/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:appetit/src/screens/onboarding/onboarding_screen.dart';
import 'package:appetit/src/routers/app_screens.dart';
import 'package:appetit/src/services/preferences_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final _prefs = AppPreferences();
  await _prefs.initPref();
  await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, 'assets/svgs/appLogo.svg'), null);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('es'),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> ThemeProvider()),
          ChangeNotifierProvider(create: (_)=> AuthPhotoProvider()),
        ],    
        child: MyApp()
      ),
    ),
  );
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    Provider.of<ThemeProvider>(context, listen: false).initTheme();
  }

  @override
  Widget build(BuildContext context) {

    final _prefs = AppPreferences();
    final bool showOnboarding = _prefs.readPreferenceBool("userSeeOnboarding");
    final _themeProvider = Provider.of<ThemeProvider>(context);

    WidgetsBinding.instance!.renderView.automaticSystemUiAdjustment=false;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: _themeProvider.darkTheme ? Brightness.light : Brightness.dark,
      statusBarColor: _themeProvider.darkTheme ? kBackgroundDark : kBackgroundLight,
      systemNavigationBarColor: _themeProvider.darkTheme ? kBackgroundDark : kBackgroundLight,
      systemNavigationBarIconBrightness: _themeProvider.darkTheme ? Brightness.light : Brightness.dark,
    ));
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'Appetit',
            theme: ThemeData(
              brightness: Brightness.light,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: kSpecialTextColor,
                selectionColor: kSpecialGray.withOpacity(0.2),
                selectionHandleColor: kSpecialPrimary,
              ),
              textTheme: GoogleFonts.quicksandTextTheme(
                Theme.of(context).textTheme,
              ),
              scaffoldBackgroundColor: Colors.white,
            ),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routes: appRoutes,
            home: showOnboarding ? LoginScreen() : OnboardingScreen(),
          );
        }
      )
    );
  }
}