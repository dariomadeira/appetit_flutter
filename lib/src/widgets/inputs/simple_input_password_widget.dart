import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:appetit/src/widgets/buttons/circle_btn_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

// INPUT DE CONTRASEÑA
class SimpleInputPasswordWidget extends StatefulWidget {

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

  const SimpleInputPasswordWidget({
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
  State<SimpleInputPasswordWidget> createState() => _SimpleInputPasswordWidgetState();
}

class _SimpleInputPasswordWidgetState extends State<SimpleInputPasswordWidget> {
  
  final BorderRadius _useThisRadius = const BorderRadius.only(
    topRight: Radius.circular(kDefaultPadding-6),
    bottomRight: Radius.circular(kDefaultPadding-6),
    bottomLeft: Radius.circular(kDefaultPadding-6),
  );
  final _colorsHelper = ColorsHelper();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {

    void _showPassword() {
      setState(() {
        _obscureText = !_obscureText;  
      });
    } 

    dynamic _handleValidate(String value) {
      final String result = tr("general_empty");
      if (value.isNotEmpty) {
        if (widget.inputValidate != null) {
          final Map _validations = widget.inputValidate!(value);
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
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kDefaultPadding-6),
              topRight: Radius.circular(kDefaultPadding-6)
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 8.4.sp,
              color: _colorsHelper.darken(color: kSpecialGray),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextFormField(
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          obscureText: _obscureText,
          controller:  widget.textController,
          autocorrect: widget.autoCorrect,
          textCapitalization: widget.textCapitalization,
          keyboardType: widget.keyboardType,
          validator: (value) => _handleValidate(value!),
          inputFormatters: (widget.textInputFormatter != null) ? [
            widget.textInputFormatter!
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
            hintText: widget.placeholder!,
            filled: true,
            fillColor: _colorsHelper.calculateBGColor(context: context, color: kSpecialGray),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: _useThisRadius,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: _useThisRadius,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: _useThisRadius,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: _useThisRadius,
            ),
            disabledBorder: OutlineInputBorder(
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
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: kDefaultPadding/2, top: 4, bottom: 4),
              child: CircleBtnWidget(
                accion: _showPassword,
                btnSize: 10.4.w,
                icon: _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                iconColor: kSpecialGray,
                backgroundColor: kSpecialGray.withOpacity(0.15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}