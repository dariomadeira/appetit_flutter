import 'package:appetit/constants.dart';
import 'package:appetit/src/widgets/tiles/option_tile_widget.dart';
import 'package:appetit/src/widgets/appbars/general_appbar_widget.dart';
import 'package:appetit/src/widgets/areas/divider_title_widget.dart';
import 'package:appetit/src/widgets/inputs/simple_input_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:flutter/services.dart';
import 'package:google_place/google_place.dart';
import 'dart:developer';

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
  Widget build(BuildContext context) {
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
          appbarTitle: tr('userAddress_appbar_title'),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding, top: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DividerTitleWidget(
                title: tr('userAddress_area_title'),
                subTitle: tr('userAddress_area_subtitle'),
              ),
              const SizedBox(height: kDefaultPadding),
              SimpleInputWidget(
                placeholder: tr('general_type_here'),
                textController: _placeController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.length > 0 && mounted) {
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
                      accion: () {},
                    );
                  },
                ),
              ),
            ]
          )
        )
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value, language: "es", );
    inspect(result);
    if (result != null && result.predictions != null && mounted) {
      if (predictions.length == 0) {
        setState(() {
          predictions = result.predictions!;
        });
      } else {
        if (result.predictions!.length < predictions.length) {
          setState(() {
            predictions = result.predictions!;
          });
        } else {
          var set1 = Set.from(predictions);
          var set2 = Set.from(result.predictions!);
          List <AutocompletePrediction> newPredictions = List.from(set2.difference(set1));
          setState(() {
            predictions = newPredictions;
          });
        }
      }
    }
  }

}
