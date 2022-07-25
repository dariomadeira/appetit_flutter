import 'package:appetit/constants.dart';
import 'package:appetit/src/customs/snacks_customs.dart';
import 'package:appetit/src/helpers/validations_helper.dart';
import 'package:appetit/src/providers/auth_provider.dart';
import 'package:appetit/src/widgets/appbars/general_appbar_widget.dart';
import 'package:appetit/src/widgets/areas/divider_title_widget.dart';
import 'package:appetit/src/widgets/buttons/rounded_btn_widget.dart';
import 'package:appetit/src/widgets/inputs/simple_input_widget.dart';
import 'package:appetit/src/widgets/states/loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:provider/provider.dart';

// PANTALLA DE RESETEO DE CONTRASEÑA
class ResetScreen extends StatefulWidget {

  // CONSTRUCTOR
  const ResetScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _validationsHelper = ValidationsHelper();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _authProvider = Provider.of<AuthProvider>(context);

    void _showSnack({
      required BuildContext context,
      required bool evaluate,
      required String messageSuccess,
      required String messageError
    }) {
      if (evaluate) {
        wSnackSuccess(message: messageSuccess, context: context);
      } else {
        wSnackError(message: messageError, context: context);
      }
    }

    void _sendMail() async {
      bool _result = await _authProvider.resetUser(email: _emailController.text.trim());
      _showSnack(
        context: _scaffoldKey.currentContext!,
        evaluate: _result,
        messageError: tr('reset_send_error'),
        messageSuccess: tr('reset_send_success'),
      );
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
            appbarTitle: tr('reset_appbar_title'),
            backColor: Colors.teal[400],
          )
          : null,
        body: _authProvider.isLoading
          ? Center(
            child: LoadingWidget(
              simpleLoad: true,
              loadingMessage: tr('general_send_mail'),
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
                    title: tr('reset_area_title'),
                    subTitle: tr('reset_area_subtitle'),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Form(
                    key: _formKey,
                    child: SimpleInputWidget(
                      placeholder: tr('general_type_here'),
                      label: tr('general_email_label'),
                      keyboardType: TextInputType.emailAddress,
                      textController: _emailController,
                      inputValidate: (String value) {
                        final bool _valid = _validationsHelper.isValidEmail(value: value);
                        if (_valid) {
                            return {"status": true };
                        } else {
                            return {"status": false, "message" : tr('register_invalid_email')};
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding*3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedBtnWidget(
                        btnAccion: () {
                          if (_formKey.currentState!.validate()) {
                            _sendMail();
                          }                      
                        },
                        btnText: tr('reset_btn_sendmail'),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
