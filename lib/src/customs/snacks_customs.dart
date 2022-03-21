import 'package:another_flushbar/flushbar.dart';
import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:flutter/material.dart';

/// Snack normal
void wSnackNormal({
  String? message,
  BuildContext? context,
  ThemeProvider? themeProvider
}) async{
  await Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    messageText: Text(
      message!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15
      ),
    ),
    duration: Duration(seconds: 2),
    margin: EdgeInsets.all(kDefaultPadding/2),
    borderRadius: BorderRadius.circular(kDefaultPadding/2),
    backgroundColor: themeProvider!.darkTheme ? kSnackDark : kSnackLight,
  ).show(context!);
}

/// Snack de error
void wSnackError({
  String? message,
  BuildContext? context
}) async {
  await Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    messageText: Text(
      message!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15
      ),
    ),
    duration: Duration(seconds: 2),
    margin: EdgeInsets.all(kDefaultPadding/2),
    borderRadius: BorderRadius.circular(kDefaultPadding/2),
    backgroundColor: kSnackError,
  ).show(context!);
}

/// Snack completado
void wSnackSuccess({
  String? message,
  BuildContext? context
}) async {
  await Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    messageText: Text(
      message!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15
      ),
    ),
    duration: Duration(seconds: 2),
    margin: EdgeInsets.all(kDefaultPadding/2),
    borderRadius: BorderRadius.circular(kDefaultPadding/2),
    backgroundColor: kSnackSuccess,
  ).show(context!);
}