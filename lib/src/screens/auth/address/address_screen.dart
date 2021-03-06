import 'dart:developer';
import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/auth_provider.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:appetit/src/providers/user_data_provider.dart';
import 'package:appetit/src/screens/auth/address/widgets/sheet_map_view_widget.dart';
import 'package:appetit/src/widgets/appbars/general_appbar_widget.dart';
import 'package:appetit/src/widgets/areas/divider_title_widget.dart';
import 'package:appetit/src/widgets/inputs/simple_input_widget.dart';
import 'package:appetit/src/widgets/tiles/option_tile_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';

// AGREGAR LA DIRECCIÓN DEL USUARIO
class UserAddressScreen extends StatefulWidget {
  @override
  State<UserAddressScreen> createState() => _UserAddressScreenState();
}

class _UserAddressScreenState extends State<UserAddressScreen> {

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  final TextEditingController _placeController = TextEditingController();

  @override
  void initState() {
    googlePlace = GooglePlace(kGooglePlacesApiKey);
    super.initState();
  }

  @override
  void dispose() {
    _placeController.dispose();
    super.dispose();
  }  

  @override
  Widget build(BuildContext context) {

    final _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final _authProvider = Provider.of<AuthProvider>(context);
    final _arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    Future <void> _saveData({
      required String address,
    }) async {
      final dynamic _result = _arguments['isEdit'];
      if (_result != null && _result) {
        _authProvider.updateAddress(newAddress: address);
        final _userDataProvider = UserDataProvider();
        await _userDataProvider.updateUserData(userData: _authProvider.currentUser!, client: _authProvider.client);
        Navigator.pop(context);
      } else {
        _authProvider.currentUser!.userAddress = address;
        _authProvider.authStatus = "USER_ADDRESS_SUCCESS";
        await Navigator.pushNamed(context, 'userPhone');
      }
    }

    return FocusDetector(
      onVisibilityGained: () {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
        );
      },
      child: Scaffold(
        appBar: GeneralAppbarWidget(
          showAvatar: false,
          showBack: true,
          appbarTitle: tr('userAddress_appbar_title'),
          backColor: Colors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding, top: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DividerTitleWidget(
                title: tr('userAddress_area_title'),
                subTitle: tr('userAddress_area_subtitle'),
              ),
              const SizedBox(height: kDefaultPadding),
              SimpleInputWidget(
                label: tr('register_address_label'),
                placeholder: tr('general_type_here'),
                textController: _placeController,
                onChanged: (String value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.isNotEmpty && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: kDefaultPadding),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    return OptionTile(
                      btnTitle: predictions[index].structuredFormatting!.mainText!,
                      btnSubtitle: predictions[index].structuredFormatting!.secondaryText ?? "",
                      iconBtn: Icons.pin_drop_outlined,
                      noEllipsis: true,
                      ramdomColor: true,
                      accion: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(kDefaultPadding),
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          backgroundColor: _themeProvider.darkTheme ? kBackgroundDark : kBackgroundLight,
                          context: context,
                          builder: (_) => SheetMapViewWidget(
                            useAddress: predictions[index].structuredFormatting!.mainText!,
                            placeId: predictions[index].placeId!,
                            googlePlace: googlePlace,
                            actionOk: () {
                              _saveData(address: predictions[index].structuredFormatting!.mainText!);
                            },
                            actionCancel: () {
                            }
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future <void> autoCompleteSearch(String value) async {
    final result = await googlePlace.autocomplete.get(value, language: "es", );
    print("**** PLACE RESULT ****");
    inspect(result);
    if (result != null && result.predictions != null && mounted) {
      if (predictions.isEmpty) {
        setState(() {
          predictions = result.predictions!;
        });
      } else {
        if (result.predictions!.length < predictions.length) {
          setState(() {
            predictions = result.predictions!;
          });
        } else {
          final set1 = Set.from(predictions);
          final set2 = Set.from(result.predictions!);
          final List <AutocompletePrediction> newPredictions = List.from(set2.difference(set1));
          setState(() {
            predictions = newPredictions;
          });
        }
      }
    }
  }

}