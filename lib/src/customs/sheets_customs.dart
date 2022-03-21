import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:appetit/src/widgets/areas/divider_title_widget.dart';
import 'package:appetit/src/widgets/buttons/rounded_btn_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Crear un sheet para elegir una imágen   
void sheetSelectphoto({
  required BuildContext context,
  required Function actionCamera,
  required Function actionGallery
}) {

  final _themeProvider = Provider.of<ThemeProvider>(context, listen: false);

  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(kDefaultPadding),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    backgroundColor: _themeProvider.darkTheme ? kBackgroundDark : kBackgroundLight,
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DividerTitleWidget(
              title: tr('bottomsheet_use'),
            ),
            const SizedBox(height: kDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedBtnWidget(
                  btnAccion: () {
                    Navigator.pop(context);
                    actionCamera();
                  },
                  btnIcon: Icons.camera_alt_outlined,
                  btnText: tr('bottomsheet_from_cammera'),
                ),
                const SizedBox(width: kDefaultPadding),
                RoundedBtnWidget(
                  btnAccion: () {
                    Navigator.pop(context);
                    actionGallery();
                  },
                  btnIcon: Icons.collections,
                  btnText: tr('bottomsheet_from_gallery'),
                ),
              ],     
            )
          ],
        ),
      );
    }
  );

}