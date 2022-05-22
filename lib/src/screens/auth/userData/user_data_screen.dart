import 'package:appetit/constants.dart';
import 'package:appetit/src/customs/sheets_customs.dart';
import 'package:appetit/src/customs/snacks_customs.dart';
import 'package:appetit/src/providers/auth_photo_provider.dart';
import 'package:appetit/src/providers/auth_provider.dart';
import 'package:appetit/src/widgets/appbars/general_appbar_widget.dart';
import 'package:appetit/src/widgets/areas/divider_title_widget.dart';
import 'package:appetit/src/widgets/buttons/rounded_btn_widget.dart';
import 'package:appetit/src/widgets/commons/avatar_widget.dart';
import 'package:appetit/src/widgets/inputs/simple_input_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:developer';

class UserDataScreen extends StatefulWidget {
  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {

  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _showAccountSuccessSnack(authProvider: _authProvider);
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showAccountSuccessSnack({
    required AuthProvider authProvider,
  }) {
    if (authProvider.authStatus == "CREATE_USER_SUCCESS") {
      wSnackSuccess(message: authProvider.currentUser.authMessage, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {

    final _authPhoto = Provider.of<AuthPhotoProvider>(context);
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

    void takePhoto({required bool fromCam}) async {
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

    void _navLogin() async {
      await Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    }

    void _saveData() async {
      _authProvider.authStatus = "ADD_USER_DATA_SUCCESS";
      _authProvider.currentUser.userName = _nameController.text;
      _authProvider.currentUser.userProfilePicture = _authPhoto.addPhotoUrl;
      print("**** APP USER ****");
      inspect(_authProvider.currentUser);
      Navigator.pushNamed(context, 'userAddress');
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
          showBack: !_authPhoto.isLoadingImg ? true : false,
          appbarTitle: tr('userData_appbar_title'),
          accionBack: _navLogin,
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
                        sizeRadius: 28.w / 1.2,
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
                                  });
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
                  title: tr('register_data_area_profile_title'),
                  subTitle: tr('register_data_area_profile_subtitle'),
                ),
                const SizedBox(height: kDefaultPadding),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      SimpleInputWidget(
                        label: tr('register_name_label'),
                        placeholder: tr('general_type_here'),
                        textController: _nameController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding * 3),
                Center(
                  child: RoundedBtnWidget(
                    btnAccion: _authPhoto.isLoadingImg
                        ? () {}
                        : () {
                          if (_formKey.currentState!.validate() && _authPhoto.addPhotoUrl != '') {
                            _saveData();
                          }
                        },
                    btnText: tr('userData_btn_next'),
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
