import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Botón redondo
class CircleBtnWidget extends StatelessWidget {

  /// Tamaño del círculo del botón
  final double btnSize;
  /// Ícono a usar
  final IconData icon;
  /// Acción al tocar
  final VoidCallback accion;
  /// Color de fondo
  final Color? backgroundColor;
  /// Estado especial
  final bool specialState;
  /// Color del icono
  final Color? iconColor;
  /// Color del icono
  final bool isSolid;

  /// Constructor
  const CircleBtnWidget({
    Key? key,
    this.btnSize = 40,
    required this.icon,
    required this.accion,
    this.backgroundColor,
    this.specialState = false,
    this.iconColor, 
    this.isSolid = false,
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
          shape: const CircleBorder(),
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