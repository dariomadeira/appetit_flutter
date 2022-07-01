import 'package:appetit/src/services/preferences_service.dart';
import 'package:flutter/material.dart';

// CLASE PARA MANEJAR EL THEME
class ThemeProvider with ChangeNotifier {
  
  final _prefs = AppPreferences();
  bool _darkTheme = false;

  // TRAER LA CONFIGURACION GUARDADA
  void initTheme() async {
    final bool isDark = _prefs.readPreferenceBool('darkMode');
    if (isDark == false) {
      _darkTheme = false;
    } else if (isDark == true) {
      _darkTheme = true;
    }
  }

  // GET PARA SAVER EL VALOR DEL DARKTHEME
  bool get darkTheme => _darkTheme;

  // SET DEL THEME
  set darkTheme(bool value) {
    _darkTheme = value;
    _prefs.savePreferenceBool('darkMode', value);
    notifyListeners();
  }
}
