import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:appetit/src/widgets/buttons/big_btn_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

/// Crear un sheet para elegir una imágen
void sheetSelectphoto({
  required BuildContext context,
  required Function actionCamera,
  required Function actionGallery,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigBtnWidget(
                  btnSecondLine: tr('bottomsheet_photo'),
                  btnFirstLine: tr('bottomsheet_take'),
                  btnAccion: () {
                    Navigator.pop(context);
                    actionCamera();
                  },
                  btnWidth: 41.w,
                  btnColor: Colors.orange[600],
                  btnIcon: Icons.camera_alt_outlined,
                ),
                BigBtnWidget(
                  btnSecondLine: tr('bottomsheet_photo'),
                  btnFirstLine: tr('bottomsheet_select'),
                  btnAccion: () {
                    Navigator.pop(context);
                    actionGallery();
                  },
                  btnWidth: 41.w,
                  btnIcon: Icons.collections,
                  btnColor: Colors.pink,
                ),
              ],
            ),
          ],
        ),
      );
    }
  );
}
