import 'package:appetit/constants.dart';
import 'package:flutter/material.dart';

/// Crea un botón con border
class BorderBtnWidget extends StatelessWidget {

  /// Constructor
  const BorderBtnWidget({
    required this.btnText,
    required this.btnAccion,
    this.btnWidth = 0,
    this.btnAsset = '',
  });

  /// Texto del botón
  final String btnText;
  /// Asset para el botón
  final String btnAsset;
  /// Acción del botón
  final Function btnAccion;
  /// Largo del botón
  final double btnWidth;

  @override
  Widget build(BuildContext context) {

    return OutlinedButton(
      onPressed: () {
        btnAccion();
      },
      style: OutlinedButton.styleFrom(
        primary: Color(0xFF757575),
        minimumSize: btnWidth != 0 ? Size(btnWidth, 48) : null,
        side: BorderSide(
          color: Colors.black.withOpacity(0.2),
          width: kDefaultBorder
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: (btnAsset == '') 
        ? Text(
          btnText,
          style: TextStyle(
            fontSize: 16,
            // fontFamily: 'ProductSans',
            fontWeight: FontWeight.w400,
            color: Colors.white,
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
                fontSize: 16,
                // fontFamily: 'ProductSans',
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
      ),
    );
  }
}