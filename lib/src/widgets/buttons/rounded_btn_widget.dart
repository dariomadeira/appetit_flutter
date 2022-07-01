import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

/// BOTÓN REDONDEADO
class RoundedBtnWidget extends StatelessWidget {

  // CONSTRUCTOR
  const RoundedBtnWidget({
    Key? key,
    required this.btnText,
    required this.btnAccion,
    this.btnColor = kSpecialPrimary,
    this.btnIcon,
    this.isLighten = false,
    this.variation = 1,
    this.noRounded = true,
  }) : super(key: key);

  // TEXTO DEL BOTÓN
  final String btnText;
  // ACCIÓN DEL BOTÓN
  final VoidCallback btnAccion;
  // COLOR DEL BOTÓN
  final Color? btnColor;
  // ICONO DEL BOTÓN
  final IconData? btnIcon;
  // BOTÓN LIGHT
  final bool isLighten;
  // VARIACIONES
  final int variation;
  // BOTÓN NO REDONDEADO
  final bool noRounded;
  
  @override
  Widget build(BuildContext context) {

    final _colorsHelpers = ColorsHelper();
    double _btnHeight = 52;

    if (variation == 1) {
      _btnHeight = 52;
    }
    if (variation == 2) {
      _btnHeight = 42;
    }

    return Container(
      height: _btnHeight,
      child: btnIcon != null 
        ? ElevatedButton.icon(
            icon: Icon(btnIcon),
            label: Text(btnText),
            onPressed: btnAccion,
            style: ElevatedButton.styleFrom(
              primary: isLighten ? _colorsHelpers.calculateBGColor(context: context, color: btnColor) : kSpecialPrimary,
              onPrimary: isLighten ? _colorsHelpers.calculateColorInicials(context: context, color: btnColor, opacity: 0.96) : Colors.white,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: noRounded ? BorderRadius.circular(_btnHeight/3.6) : BorderRadius.circular(_btnHeight/2),
              ),
              textStyle: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  fontSize: variation == 2 ? 9.sp : 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        : ElevatedButton(
            onPressed: btnAccion,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: variation == 2 ? 0 : kDefaultPadding/2),
              child: Text(btnText)
            ),
            style: ElevatedButton.styleFrom(
              primary: isLighten ? _colorsHelpers.calculateBGColor(context: context, color: btnColor) : kSpecialPrimary,
              onPrimary: isLighten ? _colorsHelpers.calculateColorInicials(context: context, color: btnColor, opacity: 0.96) : Colors.white,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: noRounded ? BorderRadius.circular(_btnHeight/4.8) : BorderRadius.circular(_btnHeight/3.2),
              ),
              textStyle: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  fontSize: variation == 2 ? 9.sp : 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        )
    );
  }
}