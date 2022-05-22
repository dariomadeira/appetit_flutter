import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/http_responses_helper.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:developer';

/// clase para manejar la api de Abstract
class AbstractApi {

  final Dio _dio = Dio();
  final String _authID = kAbstractApiKey;
  final String _countryCode = kAbstractApiCountryCode;

  /// Verificar el número
  Future<HttpResponses> verifyPhone({
    required String phone
  }) async {
    try {
      String _useUrl = "https://phonevalidation.abstractapi.com/v1/?api_key=${_authID}&phone=${_countryCode}${phone}";
      print("**** URL ****");
      print("${_useUrl}");
      final response = await _dio.get(_useUrl);
      print("**** ABSTRACT API RESPONSE ****");
      inspect(response.data);
      return HttpResponses.success(response.data);
    } catch(e) {
      int statusCode = -1;
      String message = tr('general_http_strange_error');
      dynamic data;
      if (e is DioError) {
        message = e.message;
        if (e.response != null) {
          statusCode = e.response?.statusCode ?? statusCode;
          message = e.response?.statusMessage ?? message;
          data = e.response?.data;
        }
      }
      print("**** ERROR - ${e}");
      return HttpResponses.fail(
        statusCode: statusCode,
        message: message,
        data: data
      );
    }
  }

}