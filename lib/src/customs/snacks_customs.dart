import 'package:another_flushbar/flushbar.dart';
import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Snack normal
void wSnackNormal({
  String? message,
  BuildContext? context,
  ThemeProvider? themeProvider
}) async{
  await Flushbar(
    flushbarPosition: FlushbarPosition.BOTTOM,
    messageText: Text(
      message!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
    duration: Duration(seconds: 4),
    margin: EdgeInsets.all(kDefaultPadding),
    borderRadius: BorderRadius.circular(kDefaultPadding/1.4),
    backgroundColor: themeProvider!.darkTheme ? kSnackDark : kSnackLight,
  ).show(context!);
}

/// Snack de error
void wSnackError({
  String? message,
  BuildContext? context
}) async {
  await Flushbar(
    flushbarPosition: FlushbarPosition.BOTTOM,
    messageText: Text(
      message!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
    duration: Duration(seconds: 4),
    margin: EdgeInsets.all(kDefaultPadding),
    borderRadius: BorderRadius.circular(kDefaultPadding/1.4),
    backgroundColor: kSnackError,
  ).show(context!);
}

/// Snack completado
void wSnackSuccess({
  String? message,
  BuildContext? context
}) async {
  await Flushbar(
    flushbarPosition: FlushbarPosition.BOTTOM,
    messageText: Text(
      message!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
    duration: Duration(seconds: 4),
    margin: EdgeInsets.all(kDefaultPadding),
    borderRadius: BorderRadius.circular(kDefaultPadding/1.4),
    backgroundColor: kSnackSuccess,
  ).show(context!);
}