import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BigBtnWidget extends StatelessWidget {

  // TEXTO DEL BOTÓN
  final String btnFirstLine;
  // TEXTO DEL BOTÓN
  final String? btnSecondLine;
  // ASSET PARA EL BOTÓN
  final String? btnAsset;
  // ACCIÓN DEL BOTÓN
  final VoidCallback btnAccion;
  // LARGO DEL BOTÓN
  final double? btnWidth;
  // BOTÓN LIGHT
  final bool isLighten;
  // COLOR DEL BOTÓN
  final Color? btnColor;
  // ICONO DEL BOTÓN
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
            borderRadius: BorderRadius.circular(kDefaultPadding-2),
          ),
        ),
      ),
    );
  }
}