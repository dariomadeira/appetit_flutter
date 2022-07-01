import 'package:appetit/constants.dart';
import 'package:appetit/src/widgets/buttons/circle_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// BOTÓN DE CONFIGURACIÓN
class SettingsBtnWidget extends StatelessWidget {

  // CONSTRUCTOR
  const SettingsBtnWidget({
    Key? key,
    required this.textBtn,
    this.btnColor = kPrimaryColor,
    required this.icon,
    required this.accion,
    this.isSolid = false,
  }) : super(key: key);

  // TEXTO DEL BOTÓN
  final String textBtn;
  // COLOR DEL BOTÓN
  final Color btnColor;
  // ÍCONO DEL BOTÓN
  final IconData icon;
  // ACCIÓN AL TOCAR
  final VoidCallback accion;
  // COLOR DEL ICONO
  final bool isSolid;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        CircleBtnWidget(
          accion: accion,
          btnSize: 14.w,
          icon: icon,
          backgroundColor: btnColor,
          specialState: true,
          isSolid: isSolid,
        ),
        const SizedBox(height: 4),
        Text(
          textBtn,
          style: TextStyle(
            fontSize: 11.sp,
            height: 1.05,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}