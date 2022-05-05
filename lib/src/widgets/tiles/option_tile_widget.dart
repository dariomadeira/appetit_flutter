import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:appetit/src/widgets/buttons/circle_btn_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:math';

/// Opción de porfile
class OptionTile extends StatelessWidget {

  /// Constructor
  const OptionTile({
    Key? key,
    required this.btnTitle,
    this.btnSubtitle = '',
    required this.iconBtn,
    this.noBottomSpace = true,
    this.iconColor = kPrimaryColor,
    this.accion, 
    this.showSwich = false,
    this.swichValue = false,
    this.swichAccion = null, 
    this.showEdit = false,
    this.editAccion, 
    this.noEllipsis = false,
    this.ramdomColor = false,
  }) : super(key: key);
  
  /// Título de la opción
  final String btnTitle;
  /// Subtítulo de la opcion
  final String btnSubtitle;
  /// Ícono a usar
  final IconData iconBtn;
  /// Espaciado inferior
  final bool noBottomSpace;
  /// COlor de la opción
  final Color iconColor;
  /// Acción a tocar
  final VoidCallback? accion;
  /// Mostrar el switch
  final bool showSwich;
  /// Valor del swich
  final bool swichValue;
  /// accion del Swich
  final Function? swichAccion;
  /// Valor del swich
  final bool showEdit;
  /// Accion del Swich
  final VoidCallback? editAccion;
  /// Valor del mostrar todo el texto
  final bool noEllipsis;
  /// Usar color aleatorio
  final bool ramdomColor;

  @override
  Widget build(BuildContext context) {
    
    final _colorHelpers = ColorsHelper();
    Color _randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

    return Column(
      children: [
        GestureDetector(
          onTap: accion!,
          child: Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: _colorHelpers.calculateBGColor(color: ramdomColor ? _randomColor : iconColor, context: context),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Center(
                  child: Icon(
                    iconBtn,
                    color: _colorHelpers.calculateColorInicials(color: ramdomColor ? _randomColor : iconColor, context: context, opacity: 0.96),
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: kDefaultPadding - 8),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            btnTitle,
                            style: TextStyle(
                              fontSize: 13.sp,
                              height: 1,
                              color: kTitleLight,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: noEllipsis ? null : TextOverflow.ellipsis,
                          ),
                          Visibility(
                            visible: btnSubtitle != '',
                            child: Text(
                              btnSubtitle,
                              style: TextStyle(
                                height: 1.2,
                                fontSize: 10.sp,
                                color: kTextLight,
                              ),
                              overflow: noEllipsis ? null : TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: showEdit,
                      child: CircleBtnWidget(
                        accion: () {
                          if (editAccion != null) {
                            editAccion!();
                          }
                        },
                        btnSize: 40,
                        icon: Icons.edit,
                      ),
                    ),
                    Visibility(
                      visible: showSwich,
                      child: CupertinoSwitch(
                        activeColor: iconColor,
                        trackColor: kTextLight.withOpacity(0.2),
                        value: swichValue,
                        onChanged: (value) {
                          swichAccion!(value);
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: noBottomSpace,
          child: const SizedBox(height: kDefaultPadding + 4),
        ),
      ],
    );
  }
}
