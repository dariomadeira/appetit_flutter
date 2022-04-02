import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/colors_helper.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

/// Widget del avatar
class AvatarWidget extends StatelessWidget {

  /// Imagen a mostrar
  final String? avatarImage;
  /// Iniciales del nombre
  final String? inicials;
  /// Rdio del círculo
  final double sizeRadius;
  /// Modo de carga
  final bool isLoading;
  /// Color del avatar
  final Color? avatarColor;

  /// Constructor
  const AvatarWidget({
    Key? key,
    required this.avatarImage,
    required this.inicials,
    this.sizeRadius = kDefaultPadding,
    this.isLoading = false,
    this.avatarColor = kPrimaryColor,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final _colorsHelpers = ColorsHelper();
    final _themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: new Border.all(
          color: _themeProvider.darkTheme ? kBackgroundDark : kBackgroundLight,
          width: 1,
        ),
      ),
      child: CircleAvatar(
        radius: sizeRadius,
        backgroundColor: _colorsHelpers.calculateBGColor(context: context, color: avatarColor, opacity: 0.3),
        backgroundImage: (avatarImage != '') ? NetworkImage(avatarImage!) : null,
        child: isLoading
            ? Lottie.asset(
                'assets/animations/loader.json',
                width: sizeRadius,
                height: sizeRadius,
                fit: BoxFit.fill,
              )
            : (avatarImage == '')
                ? Text(
                    inicials!,
                    style: TextStyle(
                      color: _colorsHelpers.calculateColorInicials(context: context, color: avatarColor),
                      fontWeight: FontWeight.w800,
                      fontSize: (sizeRadius > 20) ? sizeRadius / 2 : sizeRadius * 0.8,
                    ),
                  )
                : null,
      ),
    );
  }
}
