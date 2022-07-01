import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// BOTÓN REDONDO
class CircleBtnWidget extends StatelessWidget {

  // TAMAÑO DEL CÍRCULO DEL BOTÓN
  final double btnSize;
  // ÍCONO A USAR
  final IconData icon;
  // ACCIÓN AL TOCAR
  final VoidCallback accion;
  // COLOR DE FONDO
  final Color? backgroundColor;
  // ESTADO ESPECIAL
  final bool specialState;
  // COLOR DEL ICONO
  final Color? iconColor;
  // COLOR DEL ICONO
  final bool isSolid;
  // NO REDONDO
  final bool noRounded;

  // CONTRUCTOR
  const CircleBtnWidget({
    Key? key,
    this.btnSize = 40,
    required this.icon,
    required this.accion,
    this.backgroundColor,
    this.specialState = false,
    this.iconColor, 
    this.isSolid = false,
    this.noRounded = true,
  }) : super(key: key);


  Color _calculateBgColor(ThemeProvider _themeProvider) {
    Color result;
    if (backgroundColor != null) {
      if (specialState) {
        if(_themeProvider.darkTheme) {
          result = backgroundColor!;
        } else {
          result = backgroundColor!.withOpacity(0.2);
        }
      } else {
        result = backgroundColor!;
      }
    } else {
      result = Colors.transparent;
    }
    return result;
  }

  Color _calculateIconColor(ThemeProvider _themeProvider) {
    Color result;
    if (backgroundColor != null) {
      if (specialState) {
        if(_themeProvider.darkTheme) {
          result = Colors.white.withOpacity(0.96);
        } else {
          result = backgroundColor!;
        }
      } else {
        result = Colors.white;
      }
    } else {
      if(_themeProvider.darkTheme) {
        result = kTextDark;
      } else {
        result = kTextLight;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      width: btnSize,
      height: btnSize,
      child: TextButton(
        onPressed: accion,
        style: TextButton.styleFrom(
          backgroundColor: isSolid ? kPrimaryColor : _calculateBgColor(_themeProvider),
          shape: noRounded
            ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding/2+4),
            )
            : const CircleBorder(),
          primary: (backgroundColor != null) 
            ? Colors.white 
            : (_themeProvider.darkTheme 
              ? Colors.white 
              : iconColor != null 
                ? Colors.white 
                : Colors.black
            ),
        ),
        child: Icon(
          icon,
          color: isSolid ? Colors.white : iconColor != null ? iconColor : _calculateIconColor(_themeProvider),
          size: specialState ? btnSize - 24 : null,
        ),
      ),
    );
  }
}