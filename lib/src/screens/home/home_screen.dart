// import 'package:easy_localization/easy_localization.dart';
import 'package:appetit/src/widgets/appbars/general_appbar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppbarWidget(
        
      ),
      body: Center(
        child: Text('hola gustavo'),
      ),
    );
  }
}