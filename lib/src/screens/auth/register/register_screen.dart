import 'package:appetit/constants.dart';
import 'package:appetit/src/customs/sheets_customs.dart';
import 'package:appetit/src/customs/snacks_customs.dart';
import 'package:appetit/src/helpers/validations_helper.dart';
import 'package:appetit/src/providers/auth_photo_provider.dart';
import 'package:appetit/src/widgets/appbars/general_appbar_widget.dart';
import 'package:appetit/src/widgets/areas/divider_title_widget.dart';
import 'package:appetit/src/widgets/buttons/rounded_btn_widget.dart';
import 'package:appetit/src/widgets/commons/avatar_widget.dart';
import 'package:appetit/src/widgets/inputs/simple_input_password_widget.dart';
import 'package:appetit/src/widgets/inputs/simple_input_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

/// Pantalla de registrar un nuevo usuario
class RegisterScreen extends StatefulWidget {

  /// Constructor
  const RegisterScreen({
    Key? key
  }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordVerificationController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _validationsHelper = ValidationsHelper();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _authPhoto = Provider.of<AuthPhotoProvider>(context);

    void _showSnack({
      required BuildContext context,
      required bool evaluate,
      required String messageSuccess,
      required String messageError
    }) {
      if (evaluate) {
        wSnackSuccess(
          message: messageSuccess, 
          context: context
        );
      } else {
        wSnackError(
          message: messageError, 
          context: context
        );
      }
    }

    void takePhoto({
      required bool fromCam
    }) async {
      bool _obtainPhoto = await _authPhoto.getPhotoProfile(
        context: context,
        fromCam: fromCam,
      );
      _showSnack(
        context: _scaffoldKey.currentContext!,
        evaluate: _obtainPhoto,
        messageError: tr('cam_or_gal_error'),
        messageSuccess: tr('cam_or_gal_success'),
      );
    }

    // void _showPassword() {
    //   setState(() {
    //     _obscureText = !_obscureText;  
    //   });
    // }

    // void _saveData() async {
    //   if (_authPhoto.addPhotoUrl != '') {
    //     AuthUser _loginResult = await _authPhoto.registerUser(
    //       email: _emailController.text.trim(),
    //       password: _passwordController.text.trim(),
    //       context: context,
    //       name: _nameController.text.trim().capitalizeFirstofEach,
    //     );
    //     _showSnack(
    //       context: context,
    //       evaluate: _loginResult.authToken != null,
    //       messageError: _loginResult.authMessage,
    //       messageSuccess: _loginResult.authMessage,
    //     );
    //     if (_loginResult.authToken != null) {
    //       if (_loginResult.userPhone == "") {
    //         await Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    //       } else {
    //         await Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    //       }
    //     }
    //   } else {
    //     wSnackNormal(
    //       message: tr('register_no_photo'),
    //       context: context,
    //       themeProvider: _themeProvider,
    //     );
    //   }
    // }

    return FocusDetector(
      onVisibilityGained: () {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ));
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: GeneralAppbarWidget(
          showAvatar: false,
          showBack: !_authPhoto.isLoadingImg,
          appbarTitle: tr('register_appbar_title'),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DividerTitleWidget(
                  title: tr('register_photo_area_title'),
                  subTitle: tr('register_photo_area_subtitle'),
                ),
                const SizedBox(height: kDefaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 28.w,
                      height: 28.w,
                      child: AvatarWidget(
                        avatarImage: _authPhoto.addPhotoUrl,
                        inicials: tr('general_question'),
                        sizeRadius: 28.w/1.2,
                        avatarColor: Colors.lime[500],
                        isLoading: _authPhoto.isLoadingImg,
                      ),
                    ),
                    const SizedBox(width: kDefaultPadding),
                    RoundedBtnWidget(
                      btnAccion: _authPhoto.isLoadingImg 
                        ? () {}
                        : () {
                          sheetSelectphoto(
                            context: context,
                            actionCamera: () {
                              takePhoto(fromCam: true);
                            },
                            actionGallery: () {
                              takePhoto(fromCam: false);
                            }
                          );
                        },
                      btnIcon: Icons.account_circle_outlined,
                      btnText: tr('register_search_photo'),
                      btnColor: Colors.deepPurple,
                      isLighten: true,
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                DividerTitleWidget(
                  title: tr('register_data_area_title'),
                  subTitle: tr('register_data_area_subtitle'),
                ),
                const SizedBox(height: kDefaultPadding),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      SimpleInputWidget(
                        placeholder: tr('register_name_hint'),
                        textController: _nameController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(height: kDefaultPadding),
                      SimpleInputWidget(
                        placeholder: tr('general_email_hint'),
                        keyboardType: TextInputType.emailAddress,
                        textController: _emailController,
                        inputValidate: (value) {
                          bool _valid = _validationsHelper.isValidEmail(value: value);
                          if (_valid) {
                            return {"status": true };
                          } else {
                            return {"status": false, "message" : tr('register_invalid_email')};
                          }
                        }
                      ),
                      const SizedBox(height: kDefaultPadding),
                      SimpleInputPasswordWidget(
                        textController: _passwordController,
                        placeholder: tr('register_password_hint'),
                        inputValidate: (value) {
                          bool _valid = _validationsHelper.isValidPassword(value: value);
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
                      const SizedBox(height: kDefaultPadding),
                      SimpleInputPasswordWidget(
                        textController: _passwordVerificationController,
                        placeholder: tr('register_password_verification'),
                        inputValidate: (value) {
                          bool _valid = _validationsHelper.isValidPassword(value: value);
                          bool _validVerification = _validationsHelper.isPasswordsSame(
                            pass1: _passwordController.text.trim(), 
                            pass2: value,
                          );
                          if (_valid && _validVerification) {
                            return {
                              "status": true
                            };
                          } else {
                            if (!_valid) {
                              return {
                                "status": false,
                                "message" : tr('register_invalid_password'),
                              };
                            }
                            if (!_validVerification) {
                              return {
                                "status": false,
                                "message" : tr('register_invalid_same'),
                              };
                            }
                          }
                        }
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding*3),
                Center(
                  child: RoundedBtnWidget(
                    btnAccion: _authPhoto.isLoadingImg 
                      ? () {}
                      : () {


                      },
                    btnText: tr('register_btn_create'),
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
