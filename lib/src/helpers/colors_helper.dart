

import 'package:appetit/src/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Clase para manejo de los colores
class ColorsHelper {

  /// Calcular el color de fondo en base al estado del tema
  Color calculateBGColor({
    Color? color,
    BuildContext? context,
    double opacity = 0.16
  }) {
    final _themeProvider = Provider.of<ThemeProvider>(context!, listen: false);
    if (_themeProvider.darkTheme) {
      return color!;
    } else {
      return color!.withOpacity(opacity);
    }
  }

  /// Calcular el color de los hinText en base al estado del tema
  Color calculateHintColor({
    Color? color,
    BuildContext? context,
    double? opacity = 0.6,
  }) {
    final _themeProvider = Provider.of<ThemeProvider>(context!, listen: false);
    if (_themeProvider.darkTheme) {
      return color!;
    } else {
      return color!.withOpacity(opacity!);
    }
  }

  /// Calcular el color de las iniciales
  Color calculateColorInicials({
    Color? color,
    BuildContext? context,
    double opacity = 0.8
  }) {
    final _themeProvider = Provider.of<ThemeProvider>(context!, listen: false);
    if (_themeProvider.darkTheme) {
      return Colors.white.withOpacity(opacity);
    } else {
      return color!;
    }
  }

  /// Oscurecer un color
  Color darken({
    double amount = 0.1,
    Color? color,
  }) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color!);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  /// Aclarar un color
  Color lighten({
    double amount = .1,
    Color? color,
  }) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color!);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

}