import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

/// Botón redondeado especial
class RoundedBtnWidget extends StatelessWidget {

  /// Constructor
  const RoundedBtnWidget({
    Key? key,
    required this.btnText,
    required this.btnAccion,
    this.btnColor = kSpecialPrimary,
    this.btnIcon,
    this.isLighten = false,
    this.variation = 1,
  }) : super(key: key);

  /// Texto del botón
  final String btnText;
  /// Acción del botón
  final VoidCallback btnAccion;
  /// Color del botón
  final Color? btnColor;
  /// Icono del botón
  final IconData? btnIcon;
  /// Botón light
  final bool isLighten;
  /// Variaciones
  final int variation;
  
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
                borderRadius: BorderRadius.circular(_btnHeight/2),
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
                borderRadius: BorderRadius.circular(_btnHeight/3),
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