import 'package:appetit/constants.dart';
import 'package:appetit/src/widgets/buttons/circle_btn_widget.dart';
import 'package:flutter/material.dart';

/// Botón de configuración
class SettingsBtnWidget extends StatelessWidget {

  /// Contructor
  const SettingsBtnWidget({
    Key? key,
    required this.textBtn,
    this.btnColor = kPrimaryColor,
    required this.icon,
    required this.accion,
    this.isSolid = false,
  }) : super(key: key);

  /// Texto del botón
  final String textBtn;
  /// Color del botón
  final Color btnColor;
  /// Ícono del botón
  final IconData icon;
  /// Acción al tocar
  final VoidCallback accion;
  /// Color del icono
  final bool isSolid;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        CircleBtnWidget(
          accion: accion,
          btnSize: 56,
          icon: icon,
          backgroundColor: btnColor,
          specialState: true,
          isSolid: isSolid,
        ),
        const SizedBox(height: 4),
        Text(
          textBtn,
          style: TextStyle(
            fontSize: 15,
            height: 1.1,
            color: Colors.black,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}