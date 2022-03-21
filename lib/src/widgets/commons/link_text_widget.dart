import 'package:appetit/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Texto con link
class LinkTextWidget extends StatelessWidget {

  /// Constructor
  const LinkTextWidget({
    Key? key, 
    required this.onTap,
    required this.btnText,
    this.linkColor = kPrimaryColor,
  }) : super(key: key);  

  /// Acción al tocar
  final VoidCallback onTap;
  /// Texto a mostrar
  final String btnText;
  /// Colors del link
  final Color linkColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: btnText,
            style: TextStyle(
              fontSize: 14,
              color: linkColor,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w400,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = onTap,
          ),
        ],
      ),
    );
  }
}