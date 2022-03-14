
import 'package:flutter/material.dart';
import 'package:appetit/src/widgets/commons/preload_widget.dart';
import 'package:appetit/src/helpers/helpers.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return Container(
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