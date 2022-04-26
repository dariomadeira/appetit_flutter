import 'dart:convert';

AppUser appUserFromJson(String str) => AppUser.fromJson(json.decode(str));

String appUserToJson(AppUser data) => json.encode(data.toJson());

class AppUser {
  AppUser({
    required this.authMessage,
    required this.authToken,
    required this.userName,
    required this.userProfilePicture,
    required this.userEmail,
    required this.userCreation,
    required this.userLastAccess,
    required this.userPhone,
  });

  final String authMessage;
  final String authToken;
  final String userName;
  final String userProfilePicture;
  final String userEmail;
  final String userCreation;
  final String userLastAccess;
  final String userPhone;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    authMessage: json["authMessage"],
    authToken: json["authToken"],
    userName: json["userName"],
    userProfilePicture: json["userProfilePicture"],
    userEmail: json["userEmail"],
    userCreation: json["userCreation"],
    userLastAccess: json["userLastAccess"],
    userPhone: json["userPhone"],
  );

  Map<String, dynamic> toJson() => {
    "authMessage": authMessage,
    "authToken": authToken,
    "userName": userName,
    "userProfilePicture": userProfilePicture,
    "userEmail": userEmail,
    "userCreation": userCreation,
    "userLastAccess": userLastAccess,
    "userPhone": userPhone,
  };
}