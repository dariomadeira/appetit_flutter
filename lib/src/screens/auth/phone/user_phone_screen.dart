import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/validations_helper.dart';
import 'package:appetit/src/providers/phone_provider.dart';
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

// PANTALLA DE VALIDACIÓN DE TELÉFONO
class UserPhoneScreen extends StatefulWidget {

  // CONSTRUCTOR
  const UserPhoneScreen({
    Key? key,
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
    final _arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    Future <void> _validatePhone() async {
      dynamic _result = _arguments['isEdit'];
      final bool _isValidPhone = await _authPhone.verifyIsValidPhone(
        phoneNumber: _phoneController.text,
        notificate: (_result != null && _result) ? true : false,
      );
      if (_isValidPhone) {
        if (_result != null && _result) {
          Navigator.pop(context);
        } else {
          await Navigator.pushNamedAndRemoveUntil(context, 'successUserCreate', (route) => false);
        }
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
        appBar: GeneralAppbarWidget(
          showAvatar: false,
          appbarTitle: tr('phone_appbar_title'),
          showBack: !_authPhone.isLoading,
          hideTitle: _authPhone.isLoading,
          backColor: Colors.green,
        ),
        body: _authPhone.isLoading
        ? Center(
            child: LoadingWidget(
              simpleLoad: true,
              loadingMessage: _authPhone.loadingMessage,
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
                    inputValidate: (String value) {
                      final bool _valid = _validationsHelper.isValidPhone(phone: value);
                      if (_valid) {
                        return {"status": true };
                      } else {
                        return {"status": false, "message" : tr('phone_invalid')};
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