import 'package:appetit/constants.dart';
import 'package:appetit/src/customs/snacks_customs.dart';
import 'package:appetit/src/helpers/validations_helper.dart';
import 'package:appetit/src/providers/phone_provider.dart';
import 'package:appetit/src/widgets/appbars/general_appbar_widget.dart';
import 'package:appetit/src/widgets/areas/divider_title_widget.dart';
import 'package:appetit/src/widgets/buttons/rounded_btn_widget.dart';
import 'package:appetit/src/widgets/inputs/simple_input_widget.dart';
import 'package:appetit/src/widgets/states/loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/// Pantalla verificarión de teléfono
class UserPhoneScreen extends StatefulWidget {

  /// Constructor
  const UserPhoneScreen({
    Key? key
  }) : super(key: key);

  @override
  _UserPhoneScreenState createState() => _UserPhoneScreenState();
}

class _UserPhoneScreenState extends State<UserPhoneScreen> {

  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _validationsHelper = ValidationsHelper();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _authPhone = Provider.of<PhoneProvider>(context);

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

    void _validatePhone() async {
      bool _obtainPhoto = await _authPhone.verifyIsValidPhone(
        phoneNumber: _phoneController.text
      );
      _showSnack(
        context: _scaffoldKey.currentContext!,
        evaluate: _obtainPhoto,
        messageError: tr('phone_verify_error'),
        messageSuccess: tr('phone_verify_success'),
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
        appBar: GeneralAppbarWidget(
          showAvatar: false,
          appbarTitle: tr('phone_appbar_title'),
          showBack: !_authPhone.isLoading,
          hideTitle: _authPhone.isLoading,
        ),
        body: _authPhone.isLoading
        ? Center(
            child: LoadingWidget(
              simpleLoad: true,
              loadingMessage: tr("phone_verify_loading"),
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
                  title: tr('phone_area_title'),
                  subTitle: tr('phone_area_subtitle'),
                ),
                const SizedBox(height: kDefaultPadding),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: SimpleInputWidget(
                    placeholder: tr('general_type_here'),
                    label: tr('general_phone'),
                    keyboardType: TextInputType.number,
                    textInputFormatter: FilteringTextInputFormatter.digitsOnly,
                    textController: _phoneController,
                    inputValidate: (value) {
                      bool _valid = _validationsHelper.isValidPhone(phone: value);
                      if (_valid) {
                        return {"status": true };
                      } else {
                        return {"status": false, "message" : tr('phone_invalid')};
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
                        if (_formKey.currentState!.validate()) {
                          _validatePhone();
                        }              
                      },
                      btnText: tr('phone_btn_send'),
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