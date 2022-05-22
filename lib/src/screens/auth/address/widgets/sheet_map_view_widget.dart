import 'package:appetit/constants.dart';
import 'package:appetit/src/customs/app_icons_icons.dart';
import 'package:appetit/src/providers/auth_provider.dart';
import 'package:appetit/src/widgets/buttons/big_btn_widget.dart';
import 'package:appetit/src/widgets/states/loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_lng;
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:developer';

class SheetMapViewWidget extends StatefulWidget {
  final String useAddress;
  final Function actionCancel;
  final Function actionOk;
  final GooglePlace googlePlace;
  final String placeId;

  const SheetMapViewWidget({
    Key? key,
    required this.useAddress, 
    required this.actionCancel,
    required this.actionOk, 
    required this.googlePlace, 
    required this.placeId, 
  }) : super(key: key);

  @override
  State<SheetMapViewWidget> createState() => _SheetMapViewWidgetState();
}

class _SheetMapViewWidgetState extends State<SheetMapViewWidget> {

  bool showMap = false;
  double? uselat;
  double? uselong;
  List<Marker> markers = [];
  MapController? _mapController = MapController();

  @override
  void initState() {
    getCords(widget.placeId);
    super.initState();
  }

  void getCords(String value) async {
    var result = await widget.googlePlace.details.get(value);
    if (result != null && mounted) {
      var lat = result.result!.geometry!.location!.lat;
      var long = result.result!.geometry!.location!.lng;
      markers.add(
        Marker(
          point: lat_lng.LatLng(lat!, long!),
          builder: (ctx) => Container(
            child: Icon(
              AppIcons.marker,
              size: 50,
              color: Colors.red[600],
            ),
          ),
        ),
      );
      print("**** MAP MARKER ****");
      inspect(markers);
      setState(() {
        uselat = lat;
        uselong = long;
        showMap = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final _authProvider = Provider.of<AuthProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: showMap
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tr("bottomsheet_address_question", namedArgs: {'address': widget.useAddress}),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                Container(
                  height: 30.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kDefaultPadding+1),
                    border: Border.all(color: Color(0xffebe0cb), width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(kDefaultPadding),
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        center: lat_lng.LatLng(uselat!, uselong!),
                        zoom: kMapBoxZoom,
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate: kMapBoxUrl,
                          tileProvider: const CachedTileProvider(),
                          additionalOptions: {
                            'accessToken': kMapBoxToken,
                            'id': kMapBoxId,
                          },
                        ),
                        MarkerLayerOptions(
                          markers: markers,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BigBtnWidget(
                      btnFirstLine: tr('general_no'),
                      btnAccion: () {
                        Navigator.pop(context);
                        widget.actionCancel();
                      },
                      btnWidth: 41.w,
                      btnColor: Colors.red[600],
                      btnIcon: Icons.cancel_outlined,
                    ),
                    BigBtnWidget(
                      btnFirstLine: tr('general_yes'),
                      btnAccion: () {
                        _authProvider.currentUser.userLat = uselat.toString();
                        _authProvider.currentUser.userLng = uselong.toString();
                        print("**** APP USER ****");
                        inspect(_authProvider.currentUser);
                        Navigator.pop(context);
                        widget.actionOk();
                      },
                      btnWidth: 41.w,
                      btnIcon: Icons.check_circle_outline,
                      btnColor: Colors.green[600],
                    ),
                  ],
                ),
              ],
            )
          : LoadingWidget(
            simpleLoad: true,
            loadingMessage: tr("userAddress_loading_address"),
          ),
    );
  }
}

class CachedTileProvider extends TileProvider {
  const CachedTileProvider();
  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) {
    return CachedNetworkImageProvider(
      getTileUrl(coords, options),
      //Now you can set options that determine how the image gets cached via whichever plugin you use.
    );
  }
}