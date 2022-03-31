import 'package:appetit/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RoundedGradientButtonWidget extends StatelessWidget {

  final String? btnText;
  final VoidCallback buttonAction;
  final double? usePadding;

  RoundedGradientButtonWidget({
    @required this.btnText,
    required this.buttonAction,
    this.usePadding = kDefaultPadding,
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
          padding: EdgeInsets.all(usePadding!),
          child: Text(
            this.btnText!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 11.sp,
            ),
          ),
        ),
        onPressed: buttonAction,
      ),
    );
  }
}