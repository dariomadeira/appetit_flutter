import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Divisor de áreas
class DividerWidget extends StatelessWidget {

  /// Constructor
  const DividerWidget({
    Key? key,
    this.dividerText = ''
  }) : super(key: key);

  /// Texto para el divisor
  final String dividerText;

  @override
  Widget build(BuildContext context) {

    final _themeProvider = Provider.of<ThemeProvider>(context);

    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: _themeProvider.darkTheme ? kTextDark.withOpacity(0.2) : kTextLight.withOpacity(0.2),
            thickness: kDefaultBorder,
          )
        ),
        Visibility(
          visible: (dividerText == '') ? false : true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
            child: Text(
              dividerText,
              style: TextStyle(
                fontSize: 16,
                color: _themeProvider.darkTheme ? kTextDark : kTextLight,
              ),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: _themeProvider.darkTheme ? kTextDark.withOpacity(0.2) : kTextLight.withOpacity(0.2),
            thickness: kDefaultBorder,
          )
        ),
      ]
    );
  }
}