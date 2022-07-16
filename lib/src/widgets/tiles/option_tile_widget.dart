import 'dart:math';
import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:appetit/src/widgets/buttons/circle_btn_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// WIDGET DE OPCIÓN
class OptionTile extends StatelessWidget {

  // CONSTRUCTOR
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
  
  // TÍTULO DE LA OPCIÓN
  final String btnTitle;
  // SUBTÍTULO DE LA OPCIÓN
  final String btnSubtitle;
  // ÍCONO A USAR
  final IconData iconBtn;
  // ESPACIADO INFERIOR
  final bool noBottomSpace;
  // COLOR DE LA OPCIÓN
  final Color iconColor;
  // ACCIÓN A TOCAR
  final VoidCallback? accion;
  // MOSTRAR EL SWITCH
  final bool showSwich;
  // VALOR DEL SWICH
  final bool swichValue;
  // ACCION DEL SWICH
  final Function? swichAccion;
  // MOSTRAR EL EDIT
  final bool showEdit;
  // ACCION DEL EDIT
  final VoidCallback? editAccion;
  // QUITAR ELLIPSIS
  final bool noEllipsis;
  // USAR COLOR ALEATORIO
  final bool ramdomColor;


  @override
  Widget build(BuildContext context) {
    
    final _colorHelpers = ColorsHelper();
    final Color _randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

    return Column(
      children: [
        GestureDetector(
          onTap: accion,
          child: Row(
            children: [
              Container(
                height: 13.w,
                width: 13.w,
                decoration: BoxDecoration(
                  color: _colorHelpers.calculateBGColor(color: ramdomColor ? _randomColor : iconColor, context: context),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Center(
                  child: Icon(
                    iconBtn,
                    color: _colorHelpers.calculateColorInicials(color: ramdomColor ? _randomColor : iconColor, context: context, opacity: 0.96),
                    size: 7.w,
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
                        // btnSize: 40,
                        btnSize: 13.w,
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
