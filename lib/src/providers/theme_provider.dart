import 'package:appetit/src/services/preferences_service.dart';
import 'package:flutter/material.dart';

/// Clase para manejar el tema
class ThemeProvider with ChangeNotifier {
  
  final _prefs = AppPreferences();
  bool _darkTheme = false;

  /// Traer las configuraciones almacenadas
  void initTheme() async {
    final bool isDark = _prefs.readPreferenceBool('darkMode');
    if (isDark == false) {
      _darkTheme = false;
    } else if (isDark == true) {
      _darkTheme = true;
    }
  }

  /// Get del estado del tema
  bool get darkTheme => _darkTheme;

  /// Set del modo del tema
  set darkTheme(bool value) {
    _darkTheme = value;
    _prefs.savePreferenceBool('darkMode', value);
    notifyListeners();
  }
}
