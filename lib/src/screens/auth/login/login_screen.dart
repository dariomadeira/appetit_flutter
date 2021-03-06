import 'dart:math';
import 'package:appetit/constants.dart';
import 'package:appetit/src/customs/snacks_customs.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:appetit/src/helpers/validations_helper.dart';
import 'package:appetit/src/models/app_user_model.dart';
import 'package:appetit/src/providers/auth_provider.dart';
import 'package:appetit/src/widgets/areas/divider_title_widget.dart';
import 'package:appetit/src/widgets/buttons/big_btn_widget.dart';
import 'package:appetit/src/widgets/buttons/rounded_btn_widget.dart';
import 'package:appetit/src/widgets/inputs/simple_input_password_widget.dart';
import 'package:appetit/src/widgets/inputs/simple_input_widget.dart';
import 'package:appetit/src/widgets/states/loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _validationHelper = ValidationsHelper();
  final ScrollController _scrollController = ScrollController();
  bool _handleStatusBarColor = false;
  final double _decorationHeight = 100.w/2;
  final Color _randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  final _colorsHelper = ColorsHelper();

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

    final _authProvider = Provider.of<AuthProvider>(context);

    Future <void> _loginNow() async {
      final AppUser _loginResult = await _authProvider.login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (_loginResult.authToken != '') {
        await Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      } else {
        wSnackError(
          message: _loginResult.statusMessage,
          context: context
        );
      }
    }    

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: _handleStatusBarColor ? Colors.white : Colors.transparent,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return FocusDetector(
      onVisibilityGained: () {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: _handleStatusBarColor ? Colors.white : Colors.transparent,
        ));
      },
      child: Scaffold(
        body: _authProvider.isLoading
          ? Center(
            child: LoadingWidget(
              simpleLoad: true,
              loadingMessage: tr('login_process'),
            ),
          ) 
          : NotificationListener<OverscrollIndicatorNotification>(
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
                            image: const DecorationImage(
                              image: Svg('assets/svgs/login.svg'),
                              fit: BoxFit.cover
                            ),
                            color: _colorsHelper.calculateBGColor(color: _randomColor, context: context, opacity: 0.4),
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
                                  placeholder: tr('general_type_here'),
                                  label: tr('general_email_label'),
                                  inputValidate: (String value) {
                                    final bool _valid = _validationHelper.isValidEmail(value: value);
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
                                  placeholder: tr('general_type_here'),
                                  label: tr('register_password_label'),
                                  inputValidate: (String value) {
                                    final bool _valid = _validationHelper.isValidPassword(value: value);
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
                          const SizedBox(height: kDefaultPadding*2.2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundedBtnWidget(
                                btnAccion: () {
                                  if (_formKey.currentState!.validate()) {
                                    _loginNow();
                                  }
                                },
                                btnText: tr('login_btn'),
                              ),
                            ],
                          ),
                          const SizedBox(height: kDefaultPadding*2.2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BigBtnWidget(
                                btnIcon: Icons.key,
                                btnFirstLine: tr('login_reset_fl'),
                                btnSecondLine: tr('login_reset_sl'),
                                btnAccion: () {
                                  Navigator.pushNamed(context, 'reset');
                                },
                                btnWidth: 41.w,
                                btnColor: Colors.teal[400],
                              ),
                              BigBtnWidget(
                                btnFirstLine: tr('login_register_btn_fl'),
                                btnSecondLine: tr('login_register_btn_sl'),
                                btnIcon: Icons.person_add_alt,
                                btnAccion: () {
                                  Navigator.pushNamed(context, 'register');
                                },
                                btnWidth: 41.w,
                                btnColor: Colors.green,
                              ),
                            ],
                          ),
                          const SizedBox(height: kDefaultPadding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BigBtnWidget(
                                btnAsset: 'assets/images/googleLogo.png',
                                btnFirstLine: tr('general_start_from'),
                                btnSecondLine: tr('general_google'),
                                btnAccion: () {
                                  // _loginWithServices(authService: "GOOGLE");
                                },
                                btnWidth: 41.w,
                                btnColor: const Color(0xffFFAB00),
                              ),
                              BigBtnWidget(
                                btnAsset: 'assets/images/facebookLogo.png',
                                btnFirstLine: tr('general_start_from'),
                                btnSecondLine: tr('general_facebook'),
                                btnAccion: () {
                                  // _loginWithServices(authService: "FACEBOOK");
                                },
                                btnWidth: 41.w,
                                btnColor: const Color(0xff3278ef),
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
      ),
    );
  }
}