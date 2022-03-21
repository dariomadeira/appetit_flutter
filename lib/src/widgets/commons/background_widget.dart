
import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:appetit/src/widgets/commons/preload_widget.dart';
import 'package:appetit/src/helpers/image_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BackgroundApp extends StatelessWidget {

  final String? svgAsset;
  final bool? useLoader;

  const BackgroundApp({
    @required this.svgAsset,
    this.useLoader = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: useLoader! 
        ? PreloadWidget(
            loadingFutures: [
              loadSvg(context, svgAsset!),
            ],
            child: _CreateBackground(
              svgAsset: svgAsset,
            ),
          )
        : _CreateBackground(
          svgAsset: svgAsset,
        ),
    );
  }
}

class _CreateBackground extends StatelessWidget {

  final String? svgAsset;

  const _CreateBackground({
    @required this.svgAsset,
  });

  @override
  Widget build(BuildContext context) {

    final _themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      color: _themeProvider.darkTheme ? kBackgroundDark : kBackgroundLight,
      width: double.infinity,
      height: double.infinity,
      child: SvgPicture.asset(
        svgAsset!,
        fit: BoxFit.fill,
        allowDrawingOutsideViewBox: true,
        matchTextDirection: true,
      ),
    );
  }
}