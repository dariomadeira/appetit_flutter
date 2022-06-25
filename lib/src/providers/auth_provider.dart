import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:appetit/src/models/app_user_model.dart';
import 'dart:developer';

class AuthProvider with ChangeNotifier {

  /// CONTRUCTOR FACTORY
  factory AuthProvider() {
    return _thisInstance;
  }  

  // DEVOLVBER SIEMPRE LA MISMA INSTANCIA
  AuthProvider._internal();

  // PATRÓN SINGLETON
  static final AuthProvider _thisInstance = AuthProvider._internal();

  late SupabaseClient _client;
  late GoTrueClient _supaClient;
  late AppUser currentUser;
  bool isLoading = false;
  late String authStatus;
  final _dataProvider = DataProvider();

  SupabaseClient get client => this._client;

  AppUser _authError(String message) {
    return AppUser(
      authMessage: message,
      authToken: '',
      userEmail: '',
      userProfilePicture: '', 
      userName: '',
      userAddress: '',
      userLat: '',
      userLng: '',
      userPhone: '',
      userPhoneValid: '',
      userCreation: '',
      userLastAccess: '',
    );
  }

  Future<void> initSuperbase() async {
    _client = SupabaseClient(kSupabaseUrl, kSupabaseKey);
    _supaClient = _client.auth;
    authStatus = "INIT";
    print("**** SUPABASE INIT ****");
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
        print('**** SIGN UP SUCCESSS - USER ID: ${response.user!.id} ****');
        _user = AppUser(
          authMessage: tr('register_success'),
          authToken: response.user!.id,
          userEmail: email,
          userProfilePicture: "",
          userName: "", 
          userAddress: "", 
          userLat: "", 
          userLng: "", 
          userPhone: "",
          userPhoneValid: "",
          userCreation: DateTime.now().toString(),
          userLastAccess: DateTime.now().toString(),
        );
        authStatus = "CREATE_USER_SUCCESS";
      } else {
        print('**** SING UP ERROR - ${response.error!.message} ****');
        _user = _authError(tr('general_error'));
      }
    } catch(e) {
      print("**** ERROR - ${e}");
      _user = _authError(tr('general_error'));
    }
    currentUser = _user;
    isLoading = false;
    notifyListeners();
    print("**** APP USER ****");
    inspect(_user);
    return _user;
  }

  Future<bool> updateValidatePhone({
    required String userPhone,   
  }) async {
    bool _result = false;
    currentUser.userPhone = userPhone;
    currentUser.userPhoneValid = true.toString();
    authStatus = "USER_VALID_PHONE_SUCCESS";
    print("**** APP USER ****");
    inspect(currentUser);
    bool _exist = await _dataProvider.userExist(userToken: currentUser.authToken, client: _client);
    if (_exist) {
      _result = await _dataProvider.updateUserData(userData: currentUser, client: _client);
    } else {
      _result = await _dataProvider.saveUserData(userData: currentUser, client: _client);
    }
    return _result;
  }

}