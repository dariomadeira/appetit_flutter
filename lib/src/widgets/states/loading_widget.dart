import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/image_helper.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

/// ANIMACIÓN DE CARGA
class LoadingWidget extends StatelessWidget {

  final String? loadingMessage;
  final bool noShowMessage;
  final bool simpleLoad;

  const LoadingWidget({
    Key? key,
    this.loadingMessage = "",
    this.noShowMessage = false, 
    this.simpleLoad = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _themeProvider = Provider.of<ThemeProvider>(context);
    final _size = MediaQuery.of(context).size;
    final String _defaultMessage = loadingMessage == "" ? tr('general_loading') : loadingMessage!;
    final String _defaultAnimation = 'assets/animations/loader.json';
    final List<String> _listAnimations = [
      'assets/animations/bbq_l.json',
      'assets/animations/cake_l.json',
      'assets/animations/chicken_l.json',
      'assets/animations/chopping-board_l.json',
      'assets/animations/cooking_l.json',
      'assets/animations/cutlery_l.json',
      'assets/animations/cutting_l.json',
      'assets/animations/dish_l.json',
      'assets/animations/egg_l.json',
      'assets/animations/hat_l.json',
      'assets/animations/knife_l.json',
      'assets/animations/ladle_l.json',
      'assets/animations/mitten_l.json',
      'assets/animations/noodle_l.json',
      'assets/animations/oven_l.json',
      'assets/animations/pepper_l.json',
      'assets/animations/recipe-book_l.json',
      'assets/animations/rolling-pin_l.json',
      'assets/animations/salad_l.json',
      'assets/animations/saucepan_l.json',
      'assets/animations/slow-cooker_l.json',
      'assets/animations/toaster_l.json',
      'assets/animations/coffee-cup_l.json',
      'assets/animations/salt-and-pepper_l.json',
    ];
    final List<String> _listTexts = [
      tr('bbq_l_loading'),
      tr('cake_l_loading'),
      tr('chicken_l_loading'),
      tr('chopping-board_l_loading'),
      tr('cooking_l_loading'),
      tr('cutlery_l_loading'),
      tr('cutting_l_loading'),
      tr('dish_l_loading'),
      tr('egg_l_loading'),
      tr('hat_l_loading'),
      tr('knife_l_loading'),
      tr('ladle_l_loading'),
      tr('mitten_l_loading'),
      tr('noodle_l_loading'),
      tr('oven_l_loading'),
      tr('pepper_l_loading'),
      tr('recipe-book_l_loading'),
      tr('rolling-pin_l_loading'),
      tr('salad_l_loading'),
      tr('saucepan_l_loading'),
      tr('slow-cooker_l_loading'),
      tr('toaster_l_loading'),
      tr('coffe-cup_l_loading'),
      tr('salt-and-pepper_l_loading'),
    ];

    Random random = new Random();
    final int _randomNumber = random.nextInt(_listAnimations.length);
    final _animation = simpleLoad ? _defaultAnimation : _listAnimations[_randomNumber];

    return FutureBuilder<LottieComposition>(
      future: loadComposition(_animation),
      builder: (context, snapshot) {
        var composition = snapshot.data;
        if (composition != null) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Lottie.asset(
                _animation,
                width: simpleLoad ? _size.width/2 : _size.width / 4,
                height: simpleLoad ? _size.width/2 : _size.width / 4,
                fit: BoxFit.fill,
              ),
              Visibility(
                visible: !noShowMessage,
                child: Padding(
                  padding: EdgeInsets.only(top: _size.width / 2.7),
                  child: Text(
                    simpleLoad ? _defaultMessage : _listTexts[_randomNumber],
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: _themeProvider.darkTheme ? kTitleDark : kTitleLight,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
