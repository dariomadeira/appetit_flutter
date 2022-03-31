import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BigBtnWidget extends StatelessWidget {

  /// Texto del botón
  final String btnFirstLine;
  /// Texto del botón
  final String btnSecondLine;
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
    required this.btnSecondLine,
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

    return ClipRRect(
      borderRadius: BorderRadius.circular(kDefaultPadding + kDefaultPadding/2 -8),
      child: Material(
        color: isLighten ? _colorsHelpers.calculateBGColor(context: context, color: btnColor) : kSpecialPrimary,
        child: InkWell(
          splashColor: isLighten ? btnColor!.withOpacity(0.2) : Colors.white.withOpacity(0.2),
          child: Container(
            width: _btnWith,
            padding: EdgeInsets.all(kDefaultPadding),
            child: Row(
              children: [
                btnAsset != "" 
                  ? Image.asset(
                    btnAsset!,
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                  ) 
                  : Icon(
                    btnIcon,
                    color: isLighten ? btnColor : Colors.white,
                    size: 20,
                  ),
                const SizedBox( width: kDefaultPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        btnFirstLine,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w900,
                          color: isLighten ? _colorsHelpers.calculateHintColor(color: btnColor,context: context) : Colors.white,
                        ),
                      ),
                      const SizedBox( height: kDefaultPadding/3),
                      Text(
                        btnSecondLine,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w900,
                          color: isLighten ? btnColor : Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ),
          onTap: btnAccion,
        ),
      ),
    );
  }
}