import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Divisor de áreas
class DividerWidget extends StatelessWidget {

  /// Texto para el divisor
  final String dividerText;
  /// Mostrar linea
  final bool showLines;
  /// Tamaño deñ borde
  final double thicknessBorder;

  /// Constructor
  const DividerWidget({
    Key? key,
    required this.dividerText,
    this.showLines = false,
    this.thicknessBorder = kDefaultBorder,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final _colorsHelper = ColorsHelper();

    return Row(
      children: <Widget>[
        Expanded(
          child: Visibility(
            visible: showLines,
            child: Divider(
              color: kSpecialPrimary,
              thickness: thicknessBorder,
            ),
          )
        ),
        Visibility(
          visible: (dividerText == '') ? false : true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
            child: Text(
              dividerText,
              style: TextStyle(
                fontSize: 11.sp,
                color: _colorsHelper.darken( amount: 0.3, color: kSpecialPrimary),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Expanded(
          child: Visibility(
            visible: showLines,
            child: Divider(
              color: kSpecialPrimary,
              thickness: thicknessBorder,
            ),
          )
        ),
      ]
    );
  }
}