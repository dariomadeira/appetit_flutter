
import 'package:appetit/src/apis/abstract_api.dart';
import 'package:appetit/src/helpers/http_responses_helper.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

/// Clase para manejar la autentificación del teéfono
class PhoneProvider with ChangeNotifier {

  /// Instancias
  final AbstractApi _abstractApi = AbstractApi();
  bool isLoading = false;

  /// Verificar el teléfono
  Future <bool> verifyIsValidPhone({
    required String phoneNumber,
  }) async {
    bool _result = false;
    isLoading = true;
    notifyListeners();
    final HttpResponses _response = await _abstractApi.verifyPhone(
      phone: phoneNumber.trim()
    );
    print("**** PHONE PROVIDER ****");
    inspect(_response);
    if (_response.data != null) {
      // print(_response.data["valid"]);
      if (_response.data["valid"] == true) {
        _result = true;
      }
    }
    isLoading = false;
    notifyListeners();
    return _result;
  }

}