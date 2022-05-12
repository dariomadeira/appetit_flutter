
import 'package:appetit/constants.dart';
// import 'package:appetit/src/helpers/strings_helper.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:appetit/src/widgets/buttons/circle_btn_widget.dart';
import 'package:appetit/src/widgets/commons/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:math';

/// Appbar para toda la app
class GeneralAppbarWidget extends StatelessWidget implements PreferredSizeWidget {

  /// Si debe mostrar el avatar
  final bool showAvatar;
  /// Si debe mostrar el botón de volver
  final bool showBack;
  /// Si debe mostar el logo
  final bool showLogo;
  /// Si debe mostrar el ícono de la busqueda
  final bool showSearch;
  /// Si debe mostrar el ícono del carrito
  final bool showCartEmpty;
  /// La acción al presiona buscar
  final VoidCallback? accionSearch;
  /// La acción al prespionar el carrito
  final VoidCallback? accionCartEmpty;
  /// Mostrar el precio
  final String? cartPrice;
  /// Título a usar
  final String appbarTitle;
  /// La acción al hacer back
  final VoidCallback? accionBack;
  /// color de fondo de la barra
  final Color? backgroundColor;

  /// Constructor
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // final _stringsHelper = StringsHelper();
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
            const SizedBox(width: kDefaultPadding/2),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Visibility(
                    visible: showBack,
                    child: CircleBtnWidget(
                      iconColor: _randomColor,
                      backgroundColor: _randomColor.withOpacity(0.15),
                      accion: accionBack ?? () {
                        Navigator.pop(context);
                      },
                      btnSize: 40,
                      icon: Icons.arrow_back,
                    ),
                  ),
                  Visibility(
                    visible: showSearch,
                    child: CircleBtnWidget(
                      accion: accionSearch ?? () {},
                      btnSize: 40,
                      icon: Icons.search,
                    ),
                  ),
                  Visibility(
                    visible: showCartEmpty,
                    child: CircleBtnWidget(
                      accion: accionCartEmpty ?? () {},
                      btnSize: 40,
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
            : Text(
              appbarTitle,
              style: TextStyle(
                fontSize: 15.sp,
                color: _themeProvider.darkTheme ? kTitleDark : kTitleLight,
                fontWeight: FontWeight.w600,
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
                        sizeRadius: 18,
                        avatarImage: '',
                        inicials: '?',
                        // avatarImage: _auth.currentUser != null 
                        //   ? _auth.currentUser.userProfilePicture 
                        //   : '',
                        // inicials: _auth.currentUser != null 
                        //   ? _stringsHelper.getInicials(
                        //       name: _auth.currentUser.userName,
                        //     ) 
                        //   : '?',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox( width: kDefaultPadding/2),
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