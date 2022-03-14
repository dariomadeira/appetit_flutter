import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hola"),
      ),
      body: Center(
        child: Text('Hola Mundo'),
     ),
     floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
        backgroundColor: Colors.black,
        onPressed: () {

        },
      ),
    );
  }
}