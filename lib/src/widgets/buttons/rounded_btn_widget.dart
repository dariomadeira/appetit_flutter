import 'package:appetit/constants.dart';
import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {

  final String? btnText;
  final VoidCallback buttonAction;

  RoundedButtonWidget({
    @required this.btnText,
    required this.buttonAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kPrimaryColor, kSecondaryColor],
        ),
      ),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Text(
            this.btnText!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
        ),
        onPressed: buttonAction,
      ),
    );
  }
}