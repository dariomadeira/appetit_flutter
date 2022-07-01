
import 'package:appetit/constants.dart';
import 'package:appetit/src/helpers/strings_helper.dart';
import 'package:appetit/src/providers/auth_provider.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:appetit/src/widgets/buttons/circle_btn_widget.dart';
import 'package:appetit/src/widgets/commons/avatar_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:math';

// APPBAR GENERAL
class GeneralAppbarWidget extends StatelessWidget implements PreferredSizeWidget {

  // MOSTRAR EL AVATAR
  final bool showAvatar;
  // MOSTRAR EL BOTÓN DE VOLVER
  final bool showBack;
  // MOSTAR EL LOGO
  final bool showLogo;
  // MOSTRAR EL ÍCONO DE LA BUSQUEDA
  final bool showSearch;
  // MOSTRAR EL ÍCONO DEL CARRITO
  final bool showCartEmpty;
  // LA ACCIÓN AL PRESIONAR BUSCAR
  final VoidCallback? accionSearch;
  // LA ACCIÓN AL PRESIONAR EL CARRITO
  final VoidCallback? accionCartEmpty;
  // MOSTRAR EL PRECIO
  final String? cartPrice;
  // TÍTULO A USAR
  final String appbarTitle;
  // LA ACCIÓN AL HACER BACK
  final VoidCallback? accionBack;
  // COLOR DE FONDO DE LA BARRA
  final Color? backgroundColor;
  // OCULTAR TITULO
  final bool hideTitle;
  // COLOR DE FONDO DEL BOTÓN DE BACK
  final Color? backColor;

  // CONSTRUCTOR
  const GeneralAppbarWidget({
    Key? key,
    this.showAvatar = true,
    this.showBack = false,
    this.showLogo = true,
    this.showSearch = false,
    this.accionSearch,
    this.showCartEmpty = false,
    this.accionCartEmpty,
    this.cartPrice,
    this.appbarTitle = '',
    this.accionBack,
    this.backgroundColor = null,
    this.hideTitle = false,
    this.backColor = null,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _stringsHelper = StringsHelper();
    final _auth = Provider.of<AuthProvider>(context);
    final _themeProvider = Provider.of<ThemeProvider>(context);
    Color _randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

    return SafeArea(
      top: true,
      left: false,
      right: false,
      bottom: false,
      child: Container(
        height: 56,
        width: 100.w,
        color: backgroundColor != null ? backgroundColor : _themeProvider.darkTheme ? kBackgroundDark : kBackgroundLight,
        child: Row(
          children: [
            const SizedBox(width: kDefaultPadding),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Visibility(
                    visible: showBack,
                    child: CircleBtnWidget(
                      iconColor: backColor != null ? backColor : _randomColor,
                      backgroundColor: backColor != null ? backColor!.withOpacity(0.15) : _randomColor.withOpacity(0.15),
                      accion: accionBack ?? () {
                        Navigator.pop(context);
                      },
                      btnSize: 10.4.w,
                      icon: Icons.arrow_back,
                    ),
                  ),
                  Visibility(
                    visible: showSearch,
                    child: CircleBtnWidget(
                      accion: accionSearch ?? () {},
                      btnSize: 10.4.w,
                      icon: Icons.search,
                    ),
                  ),
                  Visibility(
                    visible: showCartEmpty,
                    child: CircleBtnWidget(
                      accion: accionCartEmpty ?? () {},
                      btnSize: 10.4.w,
                      icon: Icons.delete,
                    ),
                  ),
                ],
              )
            ),
            (appbarTitle == '') 
            ? Visibility(
              visible: showLogo,
              child: SvgPicture.asset(
                'assets/svgs/appLogo.svg',
                semanticsLabel: 'Appetit',
                width: 100,
              ),
            )
            : Visibility(
              visible: !hideTitle,
              child: Text(
                appbarTitle,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: _themeProvider.darkTheme ? kTitleDark : kTitleLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),





            if (cartPrice != null) Text(
              cartPrice!,
              style: const TextStyle(
                fontSize: 24,
                color: kPriceColor,
                fontWeight: FontWeight.w900,
              ),
            ),





            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // AptCircleBtnWidget(
                  //   accion: () {
                  //     Navigator.pop(context);
                  //   },
                  //   btnSize: 40,
                  //   icon: Icons.arrow_back,
                  // ),
                  Visibility(
                    visible: showAvatar,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'profile');
                      },
                      child: AvatarWidget(
                        avatarColor: Colors.lime[500],
                        sizeRadius: 20,
                        avatarImage: _auth.currentUser != null 
                          ? _auth.currentUser!.userProfilePicture 
                          : '',
                        inicials: _auth.currentUser != null 
                          ? _stringsHelper.getInicials(
                              name: _auth.currentUser!.userName,
                            ) 
                          : tr("general_question"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox( width: kDefaultPadding),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight + 8);
  }
}