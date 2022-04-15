import 'package:appetit/constants.dart';
import 'package:appetit/src/services/preferences_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {

  final _prefs = AppPreferences();
  bool _loggedIn = false;

  AuthProvider() {
    loggedIn = _prefs.readPreferenceBool(kStLoggedIn);
  }

  bool get loggedIn => _loggedIn;

  set loggedIn(bool value) {
    _loggedIn = value;
    _prefs.savePreferenceBool(kStLoggedIn, value);
    notifyListeners();
  }

  void checkLoggedIn() {
    loggedIn = _prefs.readPreferenceBool(kStLoggedIn);
  }
}