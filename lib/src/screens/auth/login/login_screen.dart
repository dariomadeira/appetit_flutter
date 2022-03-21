import 'package:appetit/constants.dart';
// import 'package:appetit/src/customs/snacks_customs.dart';
// import 'package:appetit/src/helpers/colors_helper.dart';
// import 'package:appetit/src/helpers/validations_helper.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:appetit/src/widgets/appbars/general_appbar_widget.dart';
import 'package:appetit/src/widgets/areas/divider_title_widget.dart';
import 'package:appetit/src/widgets/areas/divider_widget.dart';
import 'package:appetit/src/widgets/buttons/border_btn_widget.dart';
import 'package:appetit/src/widgets/buttons/rounded_btn_widget.dart';
import 'package:appetit/src/widgets/commons/link_text_widget.dart';
// import 'package:appetit/src/widgets/states/loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


/// Pantalla de iniciar sesión
class LoginScreen extends StatefulWidget {

  /// Constructor
  const LoginScreen({
    Key? key
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final _validationHelper = ValidationsHelper();
  // final _colorsHelper = ColorsHelper();
  // bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }  
  
  @override
  Widget build(BuildContext context) {
    
    // final _translate = AppLocalizations.of(context).translate;
    // final _auth = Provider.of<AuthProvider>(context);
    final _themeProvider = Provider.of<ThemeProvider>(context);

    // void _showPassword() {
    //   setState(() {
    //     _obscureText = !_obscureText;  
    //   });
    // }

    // void _loginWithServices({String authService}) async {
    //   AuthUser _loginResult;
    //   if (authService == "GOOGLE") {
    //     _loginResult = await _auth.googleLogin(context: context);
    //   } else if (authService == "FACEBOOK") {
    //     _loginResult = await _auth.facebookLogin(context: context);
    //   }
    //   if (_loginResult.authToken == null) {
    //     wSnackError(
    //       message: _loginResult.authMessage,
    //       context: context
    //     );
    //   } else {
    //     wSnackSuccess(
    //       message: _loginResult.authMessage,
    //       context: context
    //     );
    //     if (_loginResult.userPhone == "") {
    //       await Navigator.pushNamedAndRemoveUntil(context, 'phone', (route) => false);
    //     } else {
    //       await Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    //     }
    //   }
    // }

    // void _loginNow() async {
    //   AuthUser _loginResult = await _auth.singIn(
    //     email: _emailController.text.trim(),
    //     password: _passwordController.text.trim(),
    //     context: context
    //   );
    //   if (_loginResult.authToken == null) {
    //     wSnackError(
    //       message: _loginResult.authMessage,
    //       context: context
    //     );
    //   } else {
    //     wSnackSuccess(
    //       message: _loginResult.authMessage,
    //       context: context
    //     );
    //     if (_loginResult.userPhone == "") {
    //       await Navigator.pushNamedAndRemoveUntil(context, 'phone', (route) => false);
    //     } else {
    //       await Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    //     }
    //   }
    // }

    // return Scaffold(
    //   appBar: GeneralAppbarWidget(
    //     showAvatar: false,
    //     showLogo: false,
    //     backgroundColor: kPrimaryColor,
    //   ),
    //   body:Container(
    //     width: MediaQuery.of(context).size.width,
    //     height: MediaQuery.of(context).size.height,
    //     child: Stack(
    //       children: [
    //         Container(
    //           height: 170,
    //           width: MediaQuery.of(context).size.width,
    //           child: Container(),
              
    //           // FadeIn(
    //           //   child:
    //           //   Image.asset("assets/images/rest.png")
    //           // ),

    //           decoration: BoxDecoration(
    //             gradient: LinearGradient(
    //               begin: Alignment.topCenter,
    //               end: Alignment.bottomCenter,
    //               colors: [
    //                 kPrimaryColor,
    //                 _colorsHelper.darken(color: kPrimaryColor, amount: 0.3),
    //               ]
    //             )
    //           ),
    //         ),
    //         Positioned.fill(
    //           top: 150,
    //           child: Container(
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(kDefaultPadding),
    //               color: kBackgroundLight,
    //             ),
    //             child: _auth.isLoading
    //               ? const LoadingWidget(
    //                 loadingMessage: 'login_process',
    //               )
    //               : SingleChildScrollView(
    //                   physics: const BouncingScrollPhysics(),
    //                   child: Padding(
    //                     padding: EdgeInsets.only(
    //                       bottom: kDefaultPadding,
    //                       left: kDefaultPadding,
    //                       right: kDefaultPadding,
    //                     ),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         const SizedBox(height: kDefaultPadding*2),
    //                         Center(
    //                           child: DividerTitleWidget(
    //                             title: tr('login_area_title'),
    //                             subTitle: tr('login_area_subtitle'),
    //                             alignmentText: CrossAxisAlignment.center,
    //                           ),
    //                         ),
    //                         const SizedBox(height: kDefaultPadding),
    //                         Form(
    //                           key: _formKey,
    //                           child: Column(
    //                             children: [
    //                               SimpleInput(
    //                                 icon: Icons.alternate_email,
    //                                 placeholder: tr('general_email_hint'),
    //                                 keyboardType: TextInputType.emailAddress,
    //                                 textController: _emailController,
    //                                 inputValidate: (value) {
    //                                   bool _valid = _validationHelper.isValidEmail(value: value);
    //                                   if (_valid) {
    //                                     return {"status": true };
    //                                   } else {
    //                                     return {"status": false, "message" : tr('register_invalid_email')};
    //                                   }
    //                                 }
    //                               ),
    //                               const SizedBox(height: kDefaultPadding),
    //                               SimpleInput(
    //                                 icon: Icons.visibility_outlined,
    //                                 placeholder: tr('register_password_hint'),
    //                                 textController: _passwordController,
    //                                 isPassword: _obscureText,
    //                                 showPassword: _showPassword,
    //                                 obscureText: true,
    //                                 inputValidate: (value) {
    //                                   bool _valid = _validationHelper.isValidPassword(value: value);
    //                                   if (_valid) {
    //                                     return {"status": true };
    //                                   } else {
    //                                     return {"status": false, "message" : tr('register_invalid_password')};
    //                                   }
    //                                 }
    //                               ),
    //                             ]
    //                           ),
    //                         ),
    //                         const SizedBox(height: kDefaultPadding),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.end,
    //                           children: [
    //                             LinkTextWidget(
    //                               btnText: tr('login_reset_link'),
    //                               onTap: () {
    //                                 Navigator.pushNamed(context, 'reset');
    //                               },
    //                             ),
    //                           ],
    //                         ),
    //                         const SizedBox(height: kDefaultPadding*3),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             RoundedBtnWidget(
    //                               btnAccion: () {
    //                                 if (_formKey.currentState.validate()) {
    //                                   _loginNow();
    //                                 }
    //                               },
    //                               // btnIcon: Icons.login,
    //                               btnText: tr('login_btn'),
    //                             ),
    //                           ],
    //                         ),
    //                         const SizedBox(height: kDefaultPadding*3),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Text(
    //                               tr('login_not_account'),
    //                               style: TextStyle(
    //                                 fontSize: 16,
    //                                 color: _themeProvider.darkTheme ? kTextDark : kTextLight,
    //                               ),
    //                             ),
    //                             const SizedBox(width: kDefaultPadding/2),
    //                             RoundedBtnWidget(
    //                               btnAccion: () {
    //                                 Navigator.pushNamed(context, 'register');
    //                               },
    //                               btnText: tr('login_register_btn'),
    //                             ),
    //                           ],
    //                         ),
    //                         const SizedBox(height: kDefaultPadding),
    //                         DividerWidget(
    //                           dividerText: tr('login_alternative'),
    //                         ),
    //                         const SizedBox(height: kDefaultPadding),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                           children: [
    //                             BorderBtnWidget(
    //                               btnText: tr('general_google'),
    //                               btnAccion: () {
    //                                 _loginWithServices(authService: "GOOGLE");
    //                               },
    //                               btnWidth: MediaQuery.of(context).size.width/2.6,
    //                               btnAsset: 'assets/images/googleLogo.png',
    //                             ),
    //                             BorderBtnWidget(
    //                               btnText: tr('general_facebook'),
    //                               btnAccion: () {
    //                                 _loginWithServices(authService: "FACEBOOK");
    //                               },
    //                               btnWidth: MediaQuery.of(context).size.width/2.6,
    //                               btnAsset: 'assets/images/facebookLogo.png',
    //                             ),
    //                           ],
    //                         ),
    //                         const SizedBox(height: kDefaultPadding),
    //                       ],
    //                     ),
    //                   ),
    //               ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );












    return Scaffold(
      appBar: GeneralAppbarWidget(
        showAvatar: false,
        showLogo: false,
      ),
      // body: _auth.isLoading
      //   ? const LoadingWidget()
      //   : SingleChildScrollView(
      body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: kDefaultPadding,
                left: kDefaultPadding,
                right: kDefaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width/2.6,
                    child: Placeholder(),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  DividerTitleWidget(
                    title: tr('login_area_title'),
                    subTitle: tr('login_area_subtitle'),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // SimpleInput(
                        //   icon: Icons.alternate_email,
                        //   placeholder: tr('general_email_hint'),
                        //   keyboardType: TextInputType.emailAddress,
                        //   textController: _emailController,
                        //   inputValidate: (value) {
                        //     bool _valid = _validationHelper.isValidEmail(value: value);
                        //     if (_valid) {
                        //       return {"status": true };
                        //     } else {
                        //       return {"status": false, "message" : tr('register_invalid_email')};
                        //     }
                        //   }
                        // ),
                        const SizedBox(height: kDefaultPadding),
                        // SimpleInput(
                        //   icon: Icons.visibility_outlined,
                        //   placeholder: tr('register_password_hint'),
                        //   textController: _passwordController,
                        //   isPassword: _obscureText,
                        //   showPassword: _showPassword,
                        //   obscureText: true,
                        //   inputValidate: (value) {
                        //     bool _valid = _validationHelper.isValidPassword(value: value);
                        //     if (_valid) {
                        //       return {"status": true };
                        //     } else {
                        //       return {"status": false, "message" : tr('register_invalid_password')};
                        //     }
                        //   }
                        // ),
                      ]
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LinkTextWidget(
                        btnText: tr('login_reset_link'),
                        onTap: () {
                          Navigator.pushNamed(context, 'reset');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding*3),
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
                  const SizedBox(height: kDefaultPadding*3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tr('login_not_account'),
                        style: TextStyle(
                          fontSize: 16,
                          color: _themeProvider.darkTheme ? kTextDark : kTextLight,
                        ),
                      ),
                      const SizedBox(width: kDefaultPadding/2),
                      RoundedBtnWidget(
                        btnAccion: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        btnText: tr('login_register_btn'),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                  DividerWidget(
                    dividerText: tr('login_alternative'),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BorderBtnWidget(
                        btnText: tr('general_google'),
                        btnAccion: () {
                          // _loginWithServices(authService: "GOOGLE");
                        },
                        btnWidth: MediaQuery.of(context).size.width/2.6,
                        btnAsset: 'assets/images/googleLogo.png',
                      ),
                      BorderBtnWidget(
                        btnText: tr('general_facebook'),
                        btnAccion: () {
                              _themeProvider.darkTheme = true;
                          // _loginWithServices(authService: "FACEBOOK");
                        },
                        btnWidth: MediaQuery.of(context).size.width/2.6,
                        btnAsset: 'assets/images/facebookLogo.png',
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                ],
              ),
            ),
        ),
    );





  }
}
