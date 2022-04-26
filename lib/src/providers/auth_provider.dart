import 'package:appetit/constants.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:appetit/src/models/app_user_model.dart';

class AuthProvider with ChangeNotifier {

  late SupabaseClient _client;
  late GoTrueClient _supaClient;
  late AppUser currentUser;
  bool isLoading = false;
  late String authStatus;

  SupabaseClient get client => this._client;

  AppUser _authError(String message) {
    return AppUser(
      authMessage: message,
      authToken: '',
      userEmail: '', 
      userName: '',
      userProfilePicture: '', 
      userCreation: '',
      userLastAccess: '',
      userPhone: '',   
    );
  }

  Future<void> initSuperbase() async {
    _client = SupabaseClient(kSupabaseUrl, kSupabaseKey);
    _supaClient = _client.auth;
    authStatus = "INIT";
    print('Supabase init');
  }

  Future<AppUser> registerUser({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();
    late AppUser _user;
    try {
      final response = await _supaClient.signUp(email, password);
      if (response.error == null) {
        print('Sign up was successful for user ID: ${response.user!.id}');
        _user = AppUser(
          authMessage: tr('register_success'),
          authToken: response.user!.id,
          userEmail: email, 
          userName: "", 
          userProfilePicture: "",
          userCreation: "",
          userLastAccess: "",
          userPhone: "",
        );
        authStatus = "CREATE_USER_SUCCESS";
      } else {
        print('Sign up error: ${response.error!.message}');
        _user = _authError(tr('general_error'));
      }
    } catch(e) {
      print(e);
      _user = _authError(tr('general_error'));
    }
    currentUser = _user;
    isLoading = false;
    notifyListeners();
    print(json.encode(_user));
    return _user;
  }

}