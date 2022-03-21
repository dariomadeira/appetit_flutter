import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:appetit/src/widgets/areas/divider_title_widget.dart';
import 'package:appetit/src/widgets/buttons/rounded_btn_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Modal de borrado de cuenta
Future<bool> showWarning({BuildContext? context}) async {

  final _themeProvider = Provider.of<ThemeProvider>(context!, listen: false);

  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: _themeProvider.darkTheme ? kBackgroundDark : kBackgroundLight,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kDefaultPadding)
          )
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DividerTitleWidget(
              title: tr('profile_delete_user'),
              subTitle: tr('profile_modal_warning_delete_account'),
              alignmentText: CrossAxisAlignment.center,
            ),
            const SizedBox(height: kDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedBtnWidget(
                  btnAccion:() {
                    Navigator.of(context).pop(false);
                  },
                  btnIcon: Icons.arrow_back_ios,
                  btnText: tr('general_cancel'),
                  btnColor: const Color(0xFF607D8B),
                  isLighten: true,
                ),
                const SizedBox(width: kDefaultPadding),
                RoundedBtnWidget(
                  btnAccion:() {
                    Navigator.of(context).pop(true);
                  },
                  btnIcon: Icons.delete_forever,
                  btnText: tr('general_delete'),
                  // btnColor: const Color(0xFFF44336),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}