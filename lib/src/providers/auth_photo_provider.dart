import 'package:appetit/constants.dart';
import 'package:appetit/src/apis/imgur_api.dart';
import 'package:appetit/src/helpers/http_responses_helper.dart';
import 'package:appetit/src/providers/auth_provider.dart';
import 'package:appetit/src/providers/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';

// CLASE PARA MANEJAR LA FOTO DEL USUARIO
class AuthPhotoProvider with ChangeNotifier {

  // CONTRUCTOR FACTORY
  factory AuthPhotoProvider() {
    return _thisInstance;
  }  

  // DEVOLVER SIEMPRE LA MISMA INSTANCIA
  AuthPhotoProvider._internal();

  // PATRÓN SINGLETON
  static final AuthPhotoProvider _thisInstance = AuthPhotoProvider._internal();  

  // INSTANCIAS
  final ImagePicker _picker = ImagePicker();
  final ImgurApi _imgurApi = ImgurApi();
  final AuthProvider _authUser = AuthProvider();
  bool isLoadingImg = false;
  String addPhotoUrl = '';

  // OBTENER UNA FOTO PARA REGISTRAR UN USUARIO
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
    if (updateProfile) {
      _authUser.currentUser!.userProfilePicture = '';
    }
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
          if (updateProfile) {
            _authUser.currentUser!.userProfilePicture = addPhotoUrl;
            print("**** NEW USER PHOTO **** ${addPhotoUrl}");
            print("**** APP USER ****");
            inspect(_authUser.currentUser);
            _authUser.notifyListeners();
            final _userDataProvider = UserDataProvider();
            await _userDataProvider.updateUserData(userData: _authUser.currentUser!, client: _authUser.client);
          }
        }
      }
    }
    isLoadingImg = false;
    notifyListeners();
    return _result;
  }

}