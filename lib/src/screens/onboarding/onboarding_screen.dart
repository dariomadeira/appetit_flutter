import 'package:flutter/material.dart';
import 'package:appetit/src/widgets/commons/preload_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:appetit/src/widgets/commons/slideshow_widget.dart';
import 'package:appetit/src/helpers/helpers.dart';
import 'package:appetit/src/services/preferences_service.dart';
import 'package:appetit/src/widgets/commons/background_widget.dart';
import 'package:appetit/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: kDetaitNavbarColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: PreloadWidget(
        loadingFutures: [
          loadSvg(context, "assets/svgs/background.svg"),
          loadSvg(context, "assets/svgs/1.svg"),
          loadSvg(context, "assets/svgs/2.svg"),
          loadSvg(context, "assets/svgs/3.svg"),
          Future.delayed(Duration(seconds: kLoaderTime)),
        ],
        backgroundColor: kDetaitNavbarColor,
        child: Stack(
          children: <Widget>[
            BackgroundApp(
              svgAsset: "assets/svgs/background.svg",
              useLoader: false,
            ),
            SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Container(
                    width: double.infinity,
                    height: kDefaultPadding + kDefaultPadding/2,
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
    return Slideshow(
      dotColorSelect: kPrimaryColor,
      dotsColor: kGeneralGray,
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
        _prefs.savePreferenceBool('viewOnboarding', true);
        await Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      }
    );
  }
}