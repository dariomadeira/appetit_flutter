import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

// SIMPLE INPUT
class SimpleInputWidget extends StatelessWidget {

  // CONTROLADOR
  final TextEditingController textController;
  // AYUDA DEL CAMPO
  final String? placeholder;
  // AUTORRECCIÓN
  final bool autoCorrect;
 // TIPO DE TECLADO
  final TextInputType keyboardType;
  // CAPITALIZACIONES DEL TEXTO
  final TextCapitalization textCapitalization;
  // FUNCION DE VALIDAR
  final Function? inputValidate;
  // FORMATEADOR DE TEXTO
  final TextInputFormatter? textInputFormatter;
  // FUNCION DE CAMBIO
  final Function? onChanged;
  // ETIQUETA
  final String label;

  const SimpleInputWidget({
    Key? key,
    required this.textController,
    this.placeholder, 
    this.autoCorrect = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.inputValidate,
    this.textInputFormatter,
    this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const BorderRadius _useThisRadius = BorderRadius.only(
      topRight: Radius.circular(kDefaultPadding-6),
      bottomRight: Radius.circular(kDefaultPadding-6),
      bottomLeft: Radius.circular(kDefaultPadding-6)
    );
    final _colorsHelper = ColorsHelper();

    dynamic _handleValidate(String value) {
      final String result = tr("general_empty");
      if (value.isNotEmpty) {
        if (inputValidate != null) {
          final Map _validations = inputValidate!(value);
          if (_validations["status"]) {
            return null;
          } else {
            return _validations["message"];
          }
        } else {
          return null;
        }
      }
      return result;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: kDefaultPadding-4, right: kDefaultPadding-4, top: kDefaultPadding/2.5),
          height: kDefaultPadding+4,
          decoration: BoxDecoration(
            color: _colorsHelper.calculateBGColor(context: context, color: kSpecialGray),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(kDefaultPadding-6),
              topRight: Radius.circular(kDefaultPadding-6)
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 8.4.sp,
              color: _colorsHelper.darken(color: kSpecialGray, amount: 0.1 ),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextFormField(
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!(value);
            }
          },
          controller:  textController,
          autocorrect: autoCorrect,
          textCapitalization: textCapitalization,
          keyboardType: keyboardType,
          validator: (value) => _handleValidate(value!),
          inputFormatters: (textInputFormatter != null) ? [
            textInputFormatter!
          ] : [],
          style: TextStyle(
            color: kSpecialTextColor,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: _colorsHelper.calculateHintColor(context: context, color: kSpecialGray, opacity: 0.3),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
            hintText: placeholder,
            filled: true,
            fillColor: _colorsHelper.calculateBGColor(context: context, color: kSpecialGray),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: _useThisRadius,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: _useThisRadius,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: _useThisRadius,
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: _useThisRadius,
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: _useThisRadius,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding - 2,
              horizontal: kDefaultPadding - 2,
            ),
            errorStyle: TextStyle (
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
              color: kSpecialError,
            ),
          ),
        ),
      ],
    );
  }
}