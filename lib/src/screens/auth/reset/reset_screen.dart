import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/validations_helper.dart';
import 'package:appetit/src/widgets/appbars/general_appbar_widget.dart';
import 'package:appetit/src/widgets/areas/divider_title_widget.dart';
import 'package:appetit/src/widgets/buttons/rounded_btn_widget.dart';
import 'package:appetit/src/widgets/inputs/simple_input_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:flutter/services.dart';

/// Pantalla de reseteo de contraseña
class ResetScreen extends StatefulWidget {

  /// Constructor
  const ResetScreen({
    Key? key
  }) : super(key: key);

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _validationsHelper = ValidationsHelper();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // final tr = AppLocalizations.of(context).translate;
    // final _auth = Provider.of<AuthProvider>(context);

    // void _sendMail() async {
    //   Map<String, String> _resetAction = await _auth.resetPassword(
    //     email: _emailController.text.trim(),
    //     context: context
    //   );
    //   if (_resetAction['type'] == 'SUCCESS') {
    //     wSnackSuccess(
    //       message: _resetAction['authMessage'],
    //       context: context
    //     );
    //     Navigator.pop(context);
    //   } else {
    //     wSnackError(
    //       message: _resetAction['authMessage'],
    //       context: context
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
        appBar: GeneralAppbarWidget(
          showAvatar: false,
          showBack: true,
          appbarTitle: tr('reset_appbar_title'),
        ),
        body: SingleChildScrollView(
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
                    inputValidate: (value) {
                      bool _valid = _validationsHelper.isValidEmail(value: value);
                      if (_valid) {
                          return {"status": true };
                      } else {
                          return {"status": false, "message" : tr('register_invalid_email')};
                      }
                    }
                  ),
                ),
                const SizedBox(height: kDefaultPadding*3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedBtnWidget(
                      btnAccion: () {
                        // if (_formKey.currentState.validate()) {
                        //   _sendMail();
                        // }                      
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
