import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Crea un botón con border
class BorderBtnWidget extends StatelessWidget {

  /// Constructor
  const BorderBtnWidget({
    Key? key,
    required this.btnText,
    required this.btnAccion,
    this.btnWidth = 0,
    this.btnAsset = '',
  }) : super(key: key);

  /// Texto del botón
  final String btnText;
  /// Asset para el botón
  final String btnAsset;
  /// Acción del botón
  final VoidCallback? btnAccion;
  /// Largo del botón
  final double btnWidth;

  @override
  Widget build(BuildContext context) {

    final _themeProvider = Provider.of<ThemeProvider>(context);

    return OutlinedButton(
      onPressed: btnAccion,
      style: OutlinedButton.styleFrom(
        primary: kTextLight,
        minimumSize: btnWidth != 0 ? Size(btnWidth, 48) : null,
        side: BorderSide(
          color: _themeProvider.darkTheme ? kTextDark.withOpacity(0.2) : kTextLight.withOpacity(0.2),
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
            fontWeight: FontWeight.w400,
            color: _themeProvider.darkTheme ? kTextDark : kTextLight,
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
                fontWeight: FontWeight.w400,
                color: _themeProvider.darkTheme ? kTextDark : kTextLight,
              ),
            ),
          ],
      ),
    );
  }
}