import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:appetit/src/widgets/buttons/circle_btn_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class SimpleInputPasswordWidget extends StatefulWidget {

  /// Controlador
  final TextEditingController textController;
  /// Ayuda del campo
  final String? placeholder;
  /// Autorrección
  final bool autoCorrect;
 /// Tipo de teclado
  final TextInputType keyboardType;
  /// Capitalizaciones del texto
  final TextCapitalization textCapitalization;
  /// Funcion de validar
  final Function? inputValidate;
  /// formateador de texto
  final TextInputFormatter? textInputFormatter;

  const SimpleInputPasswordWidget({
    Key? key,
    required this.textController,
    required this.placeholder, 
    this.autoCorrect = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.inputValidate,
    this.textInputFormatter,
  }) : super(key: key);

  @override
  State<SimpleInputPasswordWidget> createState() => _SimpleInputPasswordWidgetState();
}

class _SimpleInputPasswordWidgetState extends State<SimpleInputPasswordWidget> {
  
  final BorderRadius _useThisRadius = BorderRadius.circular(kDefaultPadding + kDefaultPadding/2);
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
      String result = tr("general_empty");
      if (!value.isEmpty) {
        if (widget.inputValidate != null) {
          Map _validations = widget.inputValidate!(value);
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
        TextFormField(
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
              color: _colorsHelper.calculateHintColor(context: context, color: kSpecialGray),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
            hintText: widget.placeholder,
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
            contentPadding: EdgeInsets.symmetric(
              vertical: kDefaultPadding - 2,
              horizontal: kDefaultPadding - 2,
            ),
            errorStyle: TextStyle (
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
              color: kSpecialError,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: kDefaultPadding/2),
              child: CircleBtnWidget(
                accion: _showPassword,
                btnSize: 40,
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