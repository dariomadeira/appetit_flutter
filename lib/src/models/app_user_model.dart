import 'dart:convert';

AppUser appUserFromJson(String str) => AppUser.fromJson(json.decode(str));

String appUserToJson(AppUser data) => json.encode(data.toJson());

class AppUser {
  AppUser({
    this.authMessage,
    required this.authToken,
    required this.userEmail,
    this.userProfilePicture,
    this.userName,
    this.userAddress,
    this.userLat,
    this.userLng,
    this.userPhone,
    this.userPhoneValid,
    this.userCreation,
    this.userLastAccess,
  });

  String? authMessage;
  final String authToken;
  final String userEmail;
  String? userProfilePicture;
  String? userName;
  String? userAddress;
  String? userLat;
  String? userLng;
  String? userPhone;
  String? userPhoneValid;
  String? userCreation;
  String? userLastAccess;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    authMessage: json["authMessage"],
    authToken: json["authToken"],
    userEmail: json["userEmail"],
    userProfilePicture: json["userProfilePicture"],
    userName: json["userName"],
    userAddress: json["userAddress"],
    userLat: json["userLat"],
    userLng: json["userLng"],
    userPhone: json["userPhone"],
    userPhoneValid: json["userPhoneValid"],
    userCreation: json["userCreation"],
    userLastAccess: json["userLastAccess"],
  );

  Map<String, dynamic> toJson() => {
    "authMessage": authMessage,
    "authToken": authToken,
    "userEmail": userEmail,
    "userProfilePicture": userProfilePicture,
    "userName": userName,
    "userAddress": userAddress,
    "userLat": userLat,
    "userLng": userLng,
    "userPhone": userPhone,
    "userPhoneValid": userPhoneValid,
    "userCreation": userCreation,
    "userLastAccess": userLastAccess,
  };
}
