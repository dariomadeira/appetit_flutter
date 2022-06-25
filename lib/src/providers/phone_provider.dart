
import 'package:appetit/src/apis/abstract_api.dart';
import 'package:appetit/src/helpers/http_responses_helper.dart';
import 'package:appetit/src/providers/auth_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

// CLASE PARA MANEJAR LA VERIFICACIÓN DEL NÚMERO DE TELÉFONO
class PhoneProvider with ChangeNotifier {

  // INSTANCIAS
  final AbstractApi _abstractApi = AbstractApi();
  final _authProvider = AuthProvider();
  bool isLoading = false;
  late String loadingMessage;

  // VERIFICAR SI UN TELÉFONO ES VÁLIDO
  Future <bool> verifyIsValidPhone({
    required String phoneNumber,
  }) async {
    bool _result = false;
    loadingMessage = tr("phone_verify_loading");
    isLoading = true;
    notifyListeners();
    final HttpResponses _response = await _abstractApi.verifyPhone(
      phone: phoneNumber.trim()
    );
    print("**** PHONE PROVIDER ****");
    inspect(_response);
    if (_response.data != null) {
      if (_response.data["valid"] == true) {
        loadingMessage = tr("phone_save_data");
        notifyListeners();
        _result = await _authProvider.updateValidatePhone(userPhone: _response.data["format"]["international"]);
        isLoading = false;
      } else {
        isLoading = false;
      }
    } else {
      isLoading = false;
    }
    notifyListeners();
    return _result;
  }

}