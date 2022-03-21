import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:flutter/material.dart';

/// Botón redondeado especial
class RoundedBtnWidget extends StatelessWidget {

  /// Constructor
  const RoundedBtnWidget({
    Key? key,
    required this.btnText,
    required this.btnAccion,
    this.btnColor = kPrimaryColor,
    this.btnIcon,
    this.isLighten = false,
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
  
  @override
  Widget build(BuildContext context) {

    final _colorsHelpers = ColorsHelper();

    return Container(
      height: 48,
      child: btnIcon != null 
        ? ElevatedButton.icon(
            icon: Icon(btnIcon),
            label: Text(btnText),
            onPressed: btnAccion,
            style: ElevatedButton.styleFrom(
              primary: isLighten ? _colorsHelpers.calculateBGColor(context: context, color: btnColor) : kPrimaryColor,
              onPrimary: isLighten ? _colorsHelpers.calculateColorInicials(context: context, color: btnColor, opacity: 0.96) : Colors.white,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        : ElevatedButton(
            onPressed: btnAccion,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
              child: Text(btnText)
            ),
            style: ElevatedButton.styleFrom(
              primary: isLighten ? _colorsHelpers.calculateBGColor(context: context, color: btnColor) : kPrimaryColor,
              onPrimary: isLighten ? _colorsHelpers.calculateColorInicials(context: context, color: btnColor, opacity: 0.96) : Colors.white,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
        )
    );
  }
}