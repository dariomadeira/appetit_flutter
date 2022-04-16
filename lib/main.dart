import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/auth_photo_provider.dart';
import 'package:appetit/src/providers/auth_provider.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:appetit/src/routers/routes.dart';
import 'package:appetit/src/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:appetit/src/services/preferences_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'dart:async';

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
          ChangeNotifierProvider(
            lazy: false,
            create: (_)=> ThemeProvider(),
          ),
        ],    
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late AppService appService;
  late AuthProvider authProvider;
  late StreamSubscription<bool> authSubscription;

  @override
  void initState() {
    Provider.of<ThemeProvider>(context, listen: false).initTheme();
    appService = AppService();
    authProvider = AuthProvider();
    authSubscription = authProvider.onAuthStateChange.listen(onAuthStateChange);
    onStartUp();
    super.initState();
  }

  @override
  void dispose() {
    authSubscription.cancel();
    super.dispose();
  }

  void onStartUp() async {
    await appService.onAppStart();
  }  

  void onAuthStateChange(bool login) {
    appService.isLoggedUser = login;
  }  

  @override
  Widget build(BuildContext context) {

    final _themeProvider = Provider.of<ThemeProvider>(context);

    WidgetsBinding.instance!.renderView.automaticSystemUiAdjustment=false;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: _themeProvider.darkTheme ? Brightness.light : Brightness.dark,
      statusBarColor: _themeProvider.darkTheme ? kBackgroundDark : kBackgroundLight,
      systemNavigationBarColor: _themeProvider.darkTheme ? kBackgroundDark : kBackgroundLight,
      systemNavigationBarIconBrightness: _themeProvider.darkTheme ? Brightness.light : Brightness.dark,
    ));
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_)=> AuthPhotoProvider(),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (BuildContext createContext) => appService,
        ),
        Provider<AppRoutes>(
          lazy: false,
          create: (BuildContext createContext) => AppRoutes(appService),
        ),
        ChangeNotifierProvider<AuthProvider>(
          lazy: false,
          create: (BuildContext createContext) => authProvider,
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Sizer(
          builder: (context, orientation, deviceType) {
            final router = Provider.of<AppRoutes>(context, listen: false).router;
            return MaterialApp.router(
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
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
            );
          }
        )
      ),
    );
  }
}