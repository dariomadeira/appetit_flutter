import 'package:appetit/src/widgets/buttons/rounded_btn_widget.dart';
import 'package:flutter/material.dart';

// PANTALLA DE CREACIÓN DE CUENTA TERMINADA
class SuccessUserCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('cuenta terminada'),
            RoundedBtnWidget(
              btnAccion: () async {
                await Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
              },
              btnText: "ir a home",
            ),
          ],
        ),
      ),
    );
  }
}
