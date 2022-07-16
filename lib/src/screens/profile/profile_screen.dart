import 'package:appetit/constants.dart';
import 'package:appetit/src/customs/sheets_customs.dart';
import 'package:appetit/src/customs/snacks_customs.dart';
import 'package:appetit/src/providers/auth_photo_provider.dart';
import 'package:appetit/src/providers/auth_provider.dart';
import 'package:appetit/src/screens/profile/widgets/settings_btn_widget.dart';
import 'package:appetit/src/services/preferences_service.dart';
import 'package:appetit/src/widgets/appbars/general_appbar_widget.dart';
import 'package:appetit/src/widgets/areas/divider_title_widget.dart';
import 'package:appetit/src/widgets/commons/avatar_widget.dart';
import 'package:appetit/src/widgets/tiles/option_tile_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

// PANTALLA DE CUENTA
class ProfileScreen extends StatefulWidget {

  // CONSTRUCTOR
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final _prefs = AppPreferences();
    // final _themeProvider = Provider.of<ThemeProvider>(context);
    final _auth = Provider.of<AuthProvider>(context);
    final _authPhoto = Provider.of<AuthPhotoProvider>(context);
    final String _loginType = _prefs.readPreferenceString('authType');

    Future <void> _editPhone () async {
      await Navigator.pushNamed(context, 'userPhone', arguments: {'isEdit': true});
    }

    Future <void> _editAddress () async {
      await Navigator.pushNamed(context, 'userAddress', arguments: {'isEdit': true});
    }

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

    Future <void> takePhoto({required bool fromCam}) async {
      final bool _obtainPhoto = await _authPhoto.getPhotoProfile(
        context: context,
        fromCam: fromCam,
        updateProfile: true,
      );
      _showSnack(
        context: _scaffoldKey.currentContext!,
        evaluate: _obtainPhoto,
        messageError: tr('cam_or_gal_error'),
        messageSuccess: tr('cam_or_gal_success'),
      );
    }

    final List<Map<String, dynamic>> settings = [
      {
        'traduction': 'profile_email',
        'data': _auth.currentUser!.userEmail,
        'icon': Icons.email_outlined,
        'color': const Color(0xFFDD2C00),
      },
      {
        'traduction': 'profile_phone',
        'data': _auth.currentUser!.userPhone == "" ? tr('profile_no_phone') : _auth.currentUser!.userPhone,
        'icon': Icons.phone_android_outlined,
        'color': const Color(0xFF00ACC1),
        "edit": true,
        "editAccion": _editPhone,
      },
      {
        'traduction': 'profile_address',
        'data': _auth.currentUser!.userAddress,
        'icon': Icons.place_outlined,
        'color': const Color(0xFFFF9800),
        "edit": true,
        "editAccion": _editAddress,
      },
      {
        'traduction': 'profile_join_date',
        'data': _auth.currentUser!.userCreation,
        'icon': Icons.calendar_today_outlined,
        'color': const Color(0xFF303F9F),
      },
      {
        'traduction': 'profile_last_access',
        'data': _auth.currentUser!.userLastAccess,
        'icon': Icons.event_available,
        'color': const Color(0xFF43A047),
      },
    ];

    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: _themeProvider.darkTheme 
      //   ? kBackgroundDark 
      //   : kBackgroundLight,
      appBar: GeneralAppbarWidget(
        showAvatar: false,
        showBack: _authPhoto.isLoadingImg ? false : !_authPhoto.isLoadingImg ? true : false,
        appbarTitle: tr('profile_title'),
        backColor: Colors.green,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(kDefaultPadding),
        children: [
          DividerTitleWidget(
            title: tr('profile_hi'),
            subTitle: _auth.currentUser!.userName!,
          ),
          const SizedBox(height: kDefaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 28.w,
                height: 28.w,
                child: AvatarWidget(
                  avatarImage: _auth.currentUser!.userProfilePicture,
                  inicials: tr('general_question'),
                  sizeRadius: 28.w / 1.2,
                  avatarColor: Colors.lime[500],
                  isLoading: _authPhoto.isLoadingImg,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SettingsBtnWidget(
                  icon: Icons.delete_forever_outlined,
                  textBtn: tr('profile_delete_account'),
                  btnColor: const Color(0xFFF4511E),
                  accion: _authPhoto.isLoadingImg
                    ? () {}
                    : () {
                      sheetYesNo(
                        context: context,
                        question: tr('profile_delete_user'),
                        help: tr('profile_warning_delete_account'),
                        actionCANCEL: () {
                        },
                        actionOK: () async {
                          // bool _result = await _auth.singOut();
                          // if (_result) {
                          //   await Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
                          // }
                        },
                      );
                  },
                ),
                const SizedBox(width: kDefaultPadding*2),
                SettingsBtnWidget(
                  icon: Icons.exit_to_app,
                  textBtn: tr('profile_logout'),
                  btnColor: const Color(0xFF90A4AE),
                  accion: _authPhoto.isLoadingImg
                    ? () {}
                    : () {
                      sheetYesNo(
                        context: context,
                        question: tr('profile_logout_hit'),
                        actionCANCEL: () {
                        },
                        actionOK: () async {
                          final bool _result = await _auth.singOut();
                          if (_result) {
                            await Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
                          }
                        },
                      );
                    },
                ),
                Visibility(
                  visible: _loginType == 'MAIL',
                  child: Row(
                    children: [
                      const SizedBox(width: kDefaultPadding*2),
                      SettingsBtnWidget(
                        accion: _authPhoto.isLoadingImg
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
                        icon: Icons.account_circle_outlined,
                        textBtn: tr('profile_change_picture'),
                        btnColor: const Color(0xFF673AB7),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DividerTitleWidget(
                title: tr('profile_about_me'),
              ),
              const SizedBox(height: kDefaultPadding),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: settings.length,
                itemBuilder: (_, index) {
                  return OptionTile(
                    btnTitle: tr(settings[index]['traduction'].toString()),
                    btnSubtitle: settings[index]['data'].toString(),
                    iconBtn: settings[index]['icon'],
                    iconColor: settings[index]['color'],
                    showEdit: settings[index]['edit'] ?? false,
                    editAccion: _authPhoto.isLoadingImg ? null : settings[index]['editAccion'] ?? null,
                    accion: () {}
                  );
                },
              ),
              const SizedBox(height: kDefaultPadding/2),
              DividerTitleWidget(
                title: tr('profile_config'),
              ),
              const SizedBox(height: kDefaultPadding),
              OptionTile(
                // btnTitle: tr(_themeProvider.darkTheme 
                //   ? 'profile_dark_mode_active'
                //   : 'profile_dark_mode_deactive'
                // ),
                // btnSubtitle: tr(_themeProvider.darkTheme 
                //   ? 'profile_dark_mode_light' 
                //   : 'profile_dark_mode_dark'
                // ),
                iconBtn: Icons.brightness_2_outlined,
                noBottomSpace: false,
                iconColor: const Color(0xFF546E7A),
                showSwich: true,
                // swichValue: _themeProvider.darkTheme,
                // swichAccion: (value) {
                //   _themeProvider.darkTheme = value;
                // },
                swichAccion: (value) {
                },
                btnTitle: '',
                accion: () {},
              ),
              const SizedBox(height: kDefaultPadding/2),
            ],
          ),
        ],
      )
    );
  }
}