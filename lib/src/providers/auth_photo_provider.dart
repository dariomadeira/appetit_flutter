import 'package:appetit/constants.dart';
import 'package:appetit/src/apis/imgur_api.dart';
import 'package:appetit/src/helpers/http_responses_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Clase para manejar la autentificación en la app
class AuthPhotoProvider with ChangeNotifier {

  /// Instancias
  final ImagePicker _picker = ImagePicker();
  final ImgurApi _imgurApi = ImgurApi();
  bool isLoadingImg = false;
  String addPhotoUrl = '';

  /// Obtener una foto para registar un usuario
  Future <bool> getPhotoProfile({
    required BuildContext context,
    required bool fromCam,
    bool updateProfile = false
  }) async {
    bool _result = false;
    XFile? image;
    if (fromCam) {
      image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: kDefaultImageQuality,
      );
    } else {
      image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: kDefaultImageQuality,
      );
    }
    isLoadingImg = true;
    // if (updateProfile) {
    //   currentUser.userProfilePicture = '';
    // }
    addPhotoUrl="";
    notifyListeners();
    if (image != null) {
      final HttpResponses _response = await _imgurApi.loadImage(
        context: context,
        filePath: image.path,
      );
      if (_response.data != null) {
        if (_response.data['status'] == 200) {
          addPhotoUrl = _response.data['data']['link'];
          _result = true;
          // if (updateProfile) {
          //   await _auth.currentUser.updatePhotoURL(addPhotoUrl);
          //   getLoginData();
          // }
        }
      }
    }
    isLoadingImg = false;
    notifyListeners();
    return _result;
  }

}