import 'package:appetit/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Texto con link
class LinkTextWidget extends StatelessWidget {

  /// Constructor
  const LinkTextWidget({
    Key? key, 
    required this.onTap,
    required this.btnText,
    this.linkColor = kTextLight,
  }) : super(key: key);  

  /// Acción al tocar
  final VoidCallback onTap;
  /// Texto a mostrar
  final String btnText;
  /// Colors del link
  final Color linkColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        btnText,
        style: TextStyle(
          fontSize: 11.sp,
          color: kSpecialPrimary,
          fontWeight: FontWeight.w600,
          // decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}