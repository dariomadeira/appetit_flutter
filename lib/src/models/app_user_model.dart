import 'dart:convert';

AppUser appUserFromJson(String str) => AppUser.fromJson(json.decode(str));

String appUserToJson(AppUser data) => json.encode(data.toJson());

// CLASE PARA MENJAR LOS DATOS DEL USUARIO
class AppUser {

  AppUser({
    this.statusMessage,
    required this.authToken,
    required this.userEmail,
    this.userProfilePicture,
    this.userName,
    this.userAddress,
    this.userLat,
    this.userLng,
    this.userPhone,
    this.userCreation,
    this.userLastAccess,
  });

  String? statusMessage;
  final String authToken;
  final String userEmail;
  String? userProfilePicture;
  String? userName;
  String? userAddress;
  String? userLat;
  String? userLng;
  String? userPhone;
  String? userCreation;
  String? userLastAccess;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    statusMessage: json["statusMessage"],
    authToken: json["authToken"],
    userEmail: json["userEmail"],
    userProfilePicture: json["userProfilePicture"],
    userName: json["userName"],
    userAddress: json["userAddress"],
    userLat: json["userLat"],
    userLng: json["userLng"],
    userPhone: json["userPhone"],
    userCreation: json["userCreation"],
    userLastAccess: json["userLastAccess"],
  );

  Map<String, dynamic> toJson() => {
    "statusMessage": statusMessage,
    "authToken": authToken,
    "userEmail": userEmail,
    "userProfilePicture": userProfilePicture,
    "userName": userName,
    "userAddress": userAddress,
    "userLat": userLat,
    "userLng": userLng,
    "userPhone": userPhone,
    "userCreation": userCreation,
    "userLastAccess": userLastAccess,
  };

}
