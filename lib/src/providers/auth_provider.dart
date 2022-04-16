// import 'package:appetit/constants.dart';
// import 'package:appetit/src/services/preferences_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// class AuthProvider extends ChangeNotifier {

//   final _prefs = AppPreferences();
//   bool _loggedIn = false;

//   AuthProvider() {
//     loggedIn = _prefs.readPreferenceBool(kStLoggedIn);
//   }

//   bool get loggedIn => _loggedIn;

//   set loggedIn(bool value) {
//     _loggedIn = value;
//     _prefs.savePreferenceBool(kStLoggedIn, value);
//     notifyListeners();
//   }

//   void checkLoggedIn() {
//     loggedIn = _prefs.readPreferenceBool(kStLoggedIn);
//   }
// }



// class AuthProvider extends ChangeNotifier {

//   var _userName = '';

//   String get userName => _userName;
//   bool get loggedIn => _userName.isNotEmpty;

//   void login(String userName) {
//     _userName = userName;
//     notifyListeners();
//     print("se agrega el usuario");
//   }

//   void logout(String userName) {
//     _userName = '';
//     notifyListeners();
//   }

// }
class AuthProvider extends ChangeNotifier {

  final StreamController<bool> _onAuthStateChange = StreamController.broadcast();

  Stream<bool> get onAuthStateChange => _onAuthStateChange.stream;

  Future<bool> login() async {

    // This is just to demonstrate the login process time.
    // In real-life applications, it is not recommended to interrupt the user experience by doing such things.
    await Future.delayed(const Duration(seconds: 1));

    _onAuthStateChange.add(true);
    return true;
  }

  void logOut() {
    _onAuthStateChange.add(false);
  }

}