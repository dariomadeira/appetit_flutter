import 'package:appetit/constants.dart';
import 'package:appetit/src/customs/snacks_customs.dart';
import 'package:appetit/src/helpers/validations_helper.dart';
import 'package:appetit/src/models/app_user_model.dart';
import 'package:appetit/src/providers/auth_provider.dart';
import 'package:appetit/src/widgets/appbars/general_appbar_widget.dart';
import 'package:appetit/src/widgets/areas/divider_title_widget.dart';
import 'package:appetit/src/widgets/buttons/rounded_btn_widget.dart';
import 'package:appetit/src/widgets/inputs/simple_input_password_widget.dart';
import 'package:appetit/src/widgets/inputs/simple_input_widget.dart';
import 'package:appetit/src/widgets/states/loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:provider/provider.dart';

// CLASE PARA REGISTRAR UN USUARIO
class RegisterScreen extends StatefulWidget {

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _authProvider = Provider.of<AuthProvider>(context);

    Future <void> _saveData() async {
      final AppUser _loginResult = await _authProvider.registerUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (_loginResult.authToken != '') {
        await Navigator.pushNamedAndRemoveUntil(context, 'userData', (route) => false);
      } else {
        wSnackError(message: _loginResult.statusMessage, context: context);
      }
    }

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
        appBar: !_authProvider.isLoading 
          ? GeneralAppbarWidget(
            showAvatar: false,
            showBack: true,
            appbarTitle: tr('register_appbar_title'),
            backColor: Colors.green,
          ) : null,
        body: _authProvider.isLoading
        ? Center(
            child: LoadingWidget(
              simpleLoad: true,
              loadingMessage: tr("register_loading"),
            ),
          )
        : SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        label: tr('general_email_label'),
                        placeholder: tr('general_type_here'),
                        keyboardType: TextInputType.emailAddress,
                        textController: _emailController,
                        inputValidate: (String value) {
                          final bool _valid = _validationsHelper.isValidEmail(value: value);
                          if (_valid) {
                            return {"status": true};
                          } else {
                            return {"status": false, "message": tr('register_invalid_email')};
                          }
                        }
                      ),
                      const SizedBox(height: kDefaultPadding),
                      SimpleInputPasswordWidget(
                        textController: _passwordController,
                        label: tr('register_password_label'),
                        placeholder: tr('general_type_here'),
                        inputValidate: (String value) {
                          final bool _valid = _validationsHelper.isValidPassword(value: value);
                          if (_valid) {
                            return {"status": true};
                          } else {
                            return {"status": false, "message": tr('register_invalid_password')};
                          }
                        },
                      ),
                      const SizedBox(height: kDefaultPadding),
                      SimpleInputPasswordWidget(
                        textController: _passwordVerificationController,
                        label: tr('register_password_verification_label'),
                        placeholder: tr('general_type_here'),
                        inputValidate: (String value) {
                          final bool _valid = _validationsHelper.isValidPassword(value: value);
                          final bool _validVerification = _validationsHelper.isPasswordsSame(
                            pass1: _passwordController.text.trim(),
                            pass2: value,
                          );
                          if (_valid && _validVerification) {
                            return {"status": true};
                          } else {
                            if (!_valid) {
                              return {
                                "status": false,
                                "message": tr('register_invalid_password'),
                              };
                            }
                            if (!_validVerification) {
                              return {
                                "status": false,
                                "message": tr('register_invalid_same'),
                              };
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding * 3),
                Center(
                  child: RoundedBtnWidget(
                    btnAccion: () {
                      if (_formKey.currentState!.validate()) {
                        _saveData();
                      }
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
