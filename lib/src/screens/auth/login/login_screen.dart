import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:appetit/src/helpers/validations_helper.dart';
import 'package:appetit/src/widgets/areas/divider_title_widget.dart';
import 'package:appetit/src/widgets/buttons/big_btn_widget.dart';
import 'package:appetit/src/widgets/buttons/rounded_btn_widget.dart';
import 'package:appetit/src/widgets/inputs/simple_input_password_widget.dart';
import 'package:appetit/src/widgets/inputs/simple_input_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _validationHelper = ValidationsHelper();
  ScrollController _scrollController = ScrollController();
  bool _handleStatusBarColor = false;
  double _decorationHeight = 100.w/2;

  _scrollListener() {
    if (_scrollController.offset >= _decorationHeight - kDefaultPadding/2) {
      if (_handleStatusBarColor != true) {
        setState(() {
          _handleStatusBarColor = true;
        });
      }
    } else {
      if (_handleStatusBarColor != false) {
        setState(() {
          _handleStatusBarColor = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final _colorsHelper = ColorsHelper();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: _handleStatusBarColor ? kSpecialPrimary : Colors.transparent,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));     

    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification? overscroll) {
            overscroll!.disallowIndicator();
            return true;
          },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: _decorationHeight + kDefaultPadding*2,
                        width: 100.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Svg('assets/svgs/login.svg'),
                            fit: BoxFit.cover
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              kPrimaryColor,
                              kSecondaryColor,
                            ]
                          )
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DividerTitleWidget(
                          title: tr('login_area_title'),
                          subTitle: tr('login_area_subtitle'),
                        ),
                        const SizedBox(height: kDefaultPadding),
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              SimpleInputWidget(
                                textController: _emailController,
                                placeholder: tr('general_email_hint'),
                                inputValidate: (value) {
                                  bool _valid = _validationHelper.isValidEmail(value: value);
                                  if (_valid) {
                                    return {
                                      "status": true
                                    };
                                  } else {
                                    return {
                                      "status": false,
                                      "message" : tr('register_invalid_email')
                                    };
                                  }
                                }
                              ),
                              const SizedBox(height: kDefaultPadding),
                              SimpleInputPasswordWidget(
                                textController: _passwordController,
                                placeholder: tr('register_password_hint'),
                                inputValidate: (value) {
                                  bool _valid = _validationHelper.isValidPassword(value: value);
                                  if (_valid) {
                                    return {
                                      "status": true
                                    };
                                  } else {
                                    return {
                                      "status": false,
                                      "message" : tr('register_invalid_password')
                                    };
                                  }
                                }
                              ),
                            ]
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding*2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedBtnWidget(
                              btnAccion: () {
                                if (_formKey.currentState!.validate()) {
                                  // _loginNow();
                                }
                              },
                              btnText: tr('login_btn'),
                            ),
                          ],
                        ),
                        const SizedBox(height: kDefaultPadding*2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr('login_not_account'),
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: _colorsHelper.darken( amount: 0.3, color: kSpecialPrimary),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: kDefaultPadding/2),
                            RoundedBtnWidget(
                              btnAccion: () {
                                Navigator.pushNamed(context, 'register');
                              },
                              btnText: tr('login_register_btn'),
                              isLighten: true,
                              btnColor: Colors.green,
                              variation: 2,
                            ),
                          ],
                        ),
                        const SizedBox(height: kDefaultPadding),
                        Center(
                          child: RoundedBtnWidget(
                            btnAccion: () {
                              Navigator.pushNamed(context, 'reset');
                            },
                            btnText: tr('login_reset_link'),
                            isLighten: true,
                            btnColor: Colors.teal[400],
                            variation: 2,
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding*2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            BigBtnWidget(
                              btnAsset: 'assets/images/googleLogo.png',
                              btnSecondLine: tr('general_google'),
                              btnFirstLine: tr('general_start_from'),
                              btnAccion: () {
                                // _loginWithServices(authService: "GOOGLE");
                              },
                              btnWidth: 40.w,
                              btnColor: Color(0xffc59326),
                            ),
                            BigBtnWidget(
                              btnAsset: 'assets/images/facebookLogo.png',
                              btnSecondLine: tr('general_facebook'),
                              btnFirstLine: tr('general_start_from'),
                              btnAccion: () {
                                // _loginWithServices(authService: "FACEBOOK");
                              },
                              btnWidth: 40.w,
                              btnColor: Color(0xff3278ef),
                            ),
                          ],
                        ),
                        const SizedBox(height: kDefaultPadding),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: _decorationHeight + kDefaultPadding,
                child: Container(
                  width: 100.w,
                  height: kDefaultPadding + 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(_handleStatusBarColor ? 0 : 20)),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}