import 'package:appetit/src/helpers/http_responses_helper.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// clase para manejar la api de Imgur
class ImgurApi {

  final Dio _dio = Dio();
  final Logger _logger = Logger();
  final String _authID = '41f027e06084c3e';

  /// Cargar la imágen
  Future<HttpResponses> loadImage({
    required BuildContext context,
    required String filePath
  }) async {
    try {
      FormData _formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(filePath, filename: 'dp')
      });
      final response = await _dio.post('https://api.imgur.com/3/image', 
        options: Options(
          headers: {
            'Authorization': 'Client-ID $_authID'
          },
        ),
        data: _formData,
      );
      _logger.i(response.data);
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
      _logger.e (e);
      return HttpResponses.fail(
        statusCode: statusCode,
        message: message,
        data: data
      );
    }
  }

}