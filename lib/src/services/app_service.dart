import 'dart:async';
import 'package:appetit/constants.dart';
import 'package:appetit/src/services/preferences_service.dart';
import 'package:flutter/cupertino.dart';

class AppService with ChangeNotifier {

  final _prefs = AppPreferences();

  // Estados
  bool _isLoggedUser = false;
  bool _appInitialized = false;
  bool _showOnboarding = false;

  // Getters
  bool get isloggedUser => _isLoggedUser;
  bool get appInitialized => _appInitialized;
  bool get showOnboarding => _showOnboarding;

  // Setters
  set isLoggedUser(bool state) {
    _isLoggedUser = state;
    _prefs.savePreferenceBool(kIsLoggedUser, state);
    notifyListeners();
  }

  set appInitialized(bool value) {
    _appInitialized = value;
    notifyListeners();
  }

  set showOnboarding(bool value) {
    showOnboarding = value;
    _prefs.savePreferenceBool(kShowOnboarding, value);
    notifyListeners();
  }

  // Funciones
  Future<void> onAppStart() async {
    _showOnboarding = _prefs.readPreferenceBool(kShowOnboarding);
    _isLoggedUser = _prefs.readPreferenceBool(kIsLoggedUser);
    _appInitialized = true;
    notifyListeners();
  }
  
}