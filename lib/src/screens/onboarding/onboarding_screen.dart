import 'package:appetit/src/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:appetit/src/widgets/commons/preload_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:appetit/src/widgets/commons/slideshow_widget.dart';
import 'package:appetit/src/helpers/image_helper.dart';
import 'package:appetit/src/services/preferences_service.dart';
import 'package:appetit/src/widgets/commons/background_widget.dart';
import 'package:appetit/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _themeProvider = Provider.of<ThemeProvider>(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: _themeProvider.darkTheme ? Brightness.light : Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: _themeProvider.darkTheme ? kDetaitNavbarColorDark : kDetaitNavbarColorLight,
      systemNavigationBarIconBrightness: _themeProvider.darkTheme ? Brightness.light : Brightness.dark,
    ));

    return Scaffold(
      body: PreloadWidget(
        loadingFutures: [
          loadSvg(context, _themeProvider.darkTheme ? "assets/svgs/background_d.svg" : "assets/svgs/background_l.svg"),
          loadSvg(context, "assets/svgs/1.svg"),
          loadSvg(context, "assets/svgs/2.svg"),
          loadSvg(context, "assets/svgs/3.svg"),
          Future.delayed(Duration(seconds: kLoaderTime)),
        ],
        backgroundColor: _themeProvider.darkTheme ? kDetaitNavbarColorDark : kDetaitNavbarColorLight,
        child: Stack(
          children: <Widget>[
            BackgroundApp(
              svgAsset: _themeProvider.darkTheme ? "assets/svgs/background_d.svg" : "assets/svgs/background_l.svg",
              useLoader: false,
            ),
            SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Container(
                    width: 100.w,
                    height: 3.5.h,
                    child: SvgPicture.asset("assets/svgs/appLogo.svg"),
                  ),
                  Expanded(
                    child: Container(
                      child: _OnboardingSlider(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final _prefs = AppPreferences();
    final _themeProvider = Provider.of<ThemeProvider>(context);

    return Slideshow(
      dotColorSelect: kPrimaryColor,
      dotsColor: _themeProvider.darkTheme ? kTitleDark : kTitleLight,
      dotSizeSelect: 14,
      dotSizeNormal: 10,
      dotsTop: false,
      slides: <Widget>[
        SvgPicture.asset("assets/svgs/1.svg"),
        SvgPicture.asset("assets/svgs/2.svg"),
        SvgPicture.asset("assets/svgs/3.svg"),
      ],
      titles: <String>[
        tr('onboarding_slider1_title'),
        tr('onboarding_slider2_title'),
        tr('onboarding_slider3_title'),
      ],
      descriptions: <String>[
        tr('onboarding_slider1_description'),
        tr('onboarding_slider2_description'),
        tr('onboarding_slider3_description'),
      ],
      finalsliderbutton: () async {
        _prefs.savePreferenceBool(kShowOnboarding, true);
        context.pushNamed(loginRouteName);

        // await Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
      }
    );
  }
}