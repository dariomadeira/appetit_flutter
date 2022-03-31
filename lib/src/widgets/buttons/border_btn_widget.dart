import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Crea un botón con border
class BorderBtnWidget extends StatelessWidget {

  /// Constructor
  const BorderBtnWidget({
    Key? key,
    required this.btnText,
    required this.btnAccion,
    this.btnWidth = 0,
    this.btnAsset = '',
    this.backColor = Colors.transparent,
  }) : super(key: key);

  /// Texto del botón
  final String btnText;
  /// Asset para el botón
  final String btnAsset;
  /// Acción del botón
  final VoidCallback? btnAccion;
  /// Largo del botón
  final double btnWidth;
  /// color de fondo
  final Color backColor;

  @override
  Widget build(BuildContext context) {

    final _colorsHelper = ColorsHelper();

    return OutlinedButton(
      onPressed: btnAccion,
      style: OutlinedButton.styleFrom(
        backgroundColor: backColor,
        primary: kTextLight,
        minimumSize: btnWidth != 0 ? Size(btnWidth, 48) : null,
        side: BorderSide(
          color: _colorsHelper.lighten(amount: 0.6, color: kSpecialGray),
          width: kDefaultBorder + 0.2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: (btnAsset == '') 
        ? Text(
          btnText,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            color: kSpecialGray,
          ),
        )
        : Row(
          children: [
            Image.asset(
              btnAsset,
              height: 20,
              width: 20,
              fit: BoxFit.cover,
            ),
            const SizedBox( width: kDefaultPadding/3),
            Text(
              btnText,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: kSpecialGray,
              ),
            ),
          ],
      ),
    );
  }
}