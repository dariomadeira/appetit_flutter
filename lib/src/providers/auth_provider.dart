import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/formats_helper.dart';
import 'package:appetit/src/providers/auth_photo_provider.dart';
import 'package:appetit/src/providers/user_data_provider.dart';
import 'package:appetit/src/services/preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:appetit/src/models/app_user_model.dart';
import 'dart:developer';

// CLASE PARA MANEJAR LA CUENTA
class AuthProvider with ChangeNotifier {

  // CONTRUCTOR FACTORY
  factory AuthProvider() {
    return _thisInstance;
  }  

  // DEVOLVER SIEMPRE LA MISMA INSTANCIA
  AuthProvider._internal();

  // PATRÓN SINGLETON
  static final AuthProvider _thisInstance = AuthProvider._internal();

  // INSTANCIAS
  late SupabaseClient _client;
  late GoTrueClient _supaClient;
  late String authStatus;
  final _userDataProvider = UserDataProvider();
  final _formatsHelper = FormatsHelper();
  final _prefs = AppPreferences();
  AppUser? currentUser;
  bool isLoading = false;

  SupabaseClient get client => this._client;

  AppUser _authModel(String message) {
    return AppUser(
      statusMessage: message,
      authToken: '',
      userEmail: '',
      userProfilePicture: '', 
      userName: '',
      userAddress: '',
      userLat: '',
      userLng: '',
      userPhone: '',
      userCreation: '',
      userLastAccess: '',
    );
  }

  // INIT DE SUPABASE
  Future<void> initSuperbase() async {
    _client = SupabaseClient(kSupabaseUrl, kSupabaseKey);
    _supaClient = _client.auth;
    authStatus = "INIT_SUPABASE";
    print("**** SUPABASE INIT ****");
  }

  // REGISTRAR UN USUARIO
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
        inspect(response.user);
        _user = AppUser(
          statusMessage: tr('register_success'),
          authToken: response.user!.id,
          userEmail: email,
          userProfilePicture: "",
          userName: "", 
          userAddress: "", 
          userLat: "", 
          userLng: "", 
          userPhone: "",
          userCreation: _formatsHelper.localizeDateTime(dateString: response.user!.createdAt),
          userLastAccess: _formatsHelper.localizeDateTime(dateString: response.user!.updatedAt),
        );
        authStatus = "CREATE_USER_SUCCESS";
        _prefs.savePreferenceString("authType", "MAIL");
      } else {
        print('**** SING UP ERROR - ${response.error!.message} ****');
        inspect(response);
        // TODO esto esta mail, pero supabase no manda un mensaje adecuado cuando el correo está duplicado
        if (response.error!.message == "type 'Null' is not a subtype of type 'Map<String, dynamic>' in type cast") {
          _user = _authModel(tr('register_mail_used'));
        } else {
          _user = _authModel(tr('general_error'));
        }
      }
    } catch(e) {
      print("**** SING UP ERROR - ${e}");
      inspect(e);
      _user = _authModel(tr('general_error'));
    }
    currentUser = _user;
    isLoading = false;
    notifyListeners();
    print("**** APP USER ****");
    inspect(_user);
    return _user;
  }

  // ACTUALIZAR EL NÚMERO DE TELÉFONO
  Future<bool> updateValidatePhone({
    required String userPhone,   
  }) async {
    bool _result = false;
    currentUser!.userPhone = userPhone;
    authStatus = "USER_VALID_PHONE_SUCCESS";
    print("**** APP USER ****");
    inspect(currentUser);
    Map<String, dynamic> _exist = await _userDataProvider.getUserData(userToken: currentUser!.authToken, client: _client);
    print("**** APP USER EXIST ****");
    inspect(_exist);
    if (_exist["result"]) {
      _result = await _userDataProvider.updateUserData(userData: currentUser!, client: _client);
      if (_result) {
        authStatus = "USER_LOGGED_FIRST_TIME";
      }
    } else {
      _result = await _userDataProvider.saveUserData(userData: currentUser!, client: _client);
      if (_result) {
        authStatus = "USER_LOGGED_FIRST_TIME";
      }
    }
    return _result;
  }

  // CERRAR SESION
  Future <bool> singOut() async {
    // loadingText = 'login_process';
    // isLoading = true;
    // notifyListeners();
    bool _result = false;
    final _authPhoto = AuthPhotoProvider();
    await Future.delayed( const Duration(milliseconds: 1), () async {
      try {
        await _supaClient.signOut();
        _prefs.removePreference('authType');
        _authPhoto.addPhotoUrl = '';
        _result = true;
        // isLoading = false;
      } catch (_) {
        // isLoading = false;
        // notifyListeners();
      }
    });
    return _result;
  }

  // LOGIN
  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();
    late AppUser _user;
    try {
      final response = await _supaClient.signIn(email: email, password: password);
      if (response.error == null) {
        print('**** LOGIN SUCCESSS - USER ID: ${response.user!.id} ****');
        inspect(response.user);
        Map<String, dynamic> _existData = await _userDataProvider.getUserData(userToken: response.user!.id, client: _client);
        print('**** GET DATABASE USER DATA ****');
        inspect(_existData);
        _user = AppUser(
          statusMessage: tr('login_success'),
          authToken: response.user!.id,
          userEmail: email,
          userProfilePicture: _existData["profile"],
          userName: _existData["name"], 
          userAddress: _existData["address"], 
          userLat: _existData["lat"], 
          userLng: _existData["lng"], 
          userPhone: _existData["phone"],
          userCreation: _formatsHelper.localizeDateTime(dateString: response.user!.createdAt),
          userLastAccess: _formatsHelper.localizeDateTime(dateString: response.user!.updatedAt),
        );
        authStatus = "USER_LOGGED";
        _prefs.savePreferenceString("authType", "MAIL");
      } else {
        print('**** LOGIN ERROR - ${response.error!.message} ****');
        if (response.error!.message == 'Email not confirmed') {
          _user = _authModel(tr('general_error_mail_not_confirmed'));
        } else if (response.error!.message == 'Invalid login credentials') {
          _user = _authModel(tr('login_wrong'));
        } else {
          _user = _authModel(tr('general_error'));
        }
      }
    } catch(e) {
      print("**** LOGIN ERROR - ${e}");
      _user = _authModel(tr('general_error'));
    }
    currentUser = _user;
    isLoading = false;
    notifyListeners();
    print("**** APP USER ****");
    inspect(_user);
    return _user;
  }

}