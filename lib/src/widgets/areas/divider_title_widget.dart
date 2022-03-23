import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Crea un título destacado
class DividerTitleWidget extends StatelessWidget {

  /// Constructor
  const DividerTitleWidget({
    Key? key,
    required this.title,
    this.useTopPadding = false, 
    this.subTitle = "",
    this.alignmentText = CrossAxisAlignment.start,
  }) : super(key: key);

  /// Título
  final String title;
  /// Subtítulo
  final String subTitle;
  /// Usar espaciado en top
  final bool useTopPadding;
  /// Usar espaciado en top
  final CrossAxisAlignment alignmentText;

  @override
  Widget build(BuildContext context) {

    final _themeProvider = Provider.of<ThemeProvider>(context);
    
    return Padding(
      padding: useTopPadding ? const EdgeInsets.only(top: kDefaultPadding/2) : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: alignmentText,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 26,
              color: kSecondaryColor,
              height: 1,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: kDefaultPadding/6),
          Visibility(
            visible: subTitle != "",
            child: Text(
              subTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _themeProvider.darkTheme ? kGeneralDark : kGeneralLight,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}