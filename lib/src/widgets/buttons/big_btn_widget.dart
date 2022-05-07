import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BigBtnWidget extends StatelessWidget {

  /// Texto del botón
  final String btnFirstLine;
  /// Texto del botón
  final String? btnSecondLine;
  /// Asset para el botón
  final String? btnAsset;
  /// Acción del botón
  final VoidCallback btnAccion;
  /// Largo del botón
  final double? btnWidth;
  /// Botón light
  final bool isLighten;
  /// Color del botón
  final Color? btnColor;
  /// Icono del botón
  final IconData? btnIcon;

  const BigBtnWidget({
    Key? key,
    required this.btnFirstLine,
    this.btnSecondLine = "",
    this.btnAsset = "",
    required this.btnAccion,
    this.btnWidth,
    this.isLighten = true,
    this.btnColor = kSpecialPrimary,
    this.btnIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double _btnWith = btnWidth != null ? btnWidth! : 50.w - kDefaultPadding;
    final _colorsHelpers = ColorsHelper();

    return Container(
      width: _btnWith,
      child:ElevatedButton(
        onPressed: btnAccion,
        child: Padding(
          padding: EdgeInsets.only(left: kDefaultPadding-4, top: kDefaultPadding, bottom: kDefaultPadding),
          child: Row(
            children: [
              btnAsset != "" 
                ? Image.asset(
                  btnAsset!,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                ) 
                : Icon(
                  btnIcon,
                  color: isLighten ? btnColor : Colors.white,
                  size: 26,
                ),
              const SizedBox( width: kDefaultPadding/2),
              Expanded(
                child: Column(
                  crossAxisAlignment: btnSecondLine != "" ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                  children: [
                    Text(
                      btnFirstLine,
                      style: TextStyle(
                        fontSize: btnSecondLine != "" ? 11.sp : 13.sp,
                        fontWeight: btnSecondLine != "" ? FontWeight.w500 : FontWeight.w800,
                        color: isLighten ? _colorsHelpers.calculateHintColor(color: btnColor,context: context) : Colors.white,
                      ),
                    ),
                    Visibility(
                      visible: btnSecondLine != "",
                      child: Column(
                        children: [
                          const SizedBox( height: kDefaultPadding/3),
                          Text(
                            btnSecondLine!,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w900,
                              color: isLighten ? btnColor : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: isLighten ? _colorsHelpers.calculateBGColor(context: context, color: btnColor) : kSpecialPrimary,
          onPrimary: isLighten ? _colorsHelpers.calculateColorInicials(context: context, color: btnColor, opacity: 0.96) : Colors.white,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultPadding + kDefaultPadding/2 -8),
          ),
        ),
      ),
    );
  }
}