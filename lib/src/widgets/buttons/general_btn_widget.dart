import 'package:appetit/constants.dart';
import 'package:flutter/material.dart';

class GeneralButtonWidget extends StatelessWidget {

  final String? btnText;
  final int? styleBtn;
  final VoidCallback buttonAction;

  GeneralButtonWidget({
    @required this.btnText,
    this.styleBtn = 0,
    required this.buttonAction,
  });


  @override
  Widget build(BuildContext context) {
    BorderRadius theBorder = BorderRadius.circular(5);
    if (this.styleBtn == 0) {
      theBorder = BorderRadius.circular(30);
    }
    return ElevatedButton(
      onPressed: this.buttonAction,
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        shadowColor: Colors.transparent,
        elevation: 0,
        primary: kPrimaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: theBorder,
        ),
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 15,
        ),
      ),
      child: Text(this.btnText!),
    );
  }
}