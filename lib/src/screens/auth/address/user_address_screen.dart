import 'package:flutter/material.dart';

class UserAddressScreen extends StatefulWidget {

  @override
  State<UserAddressScreen> createState() => _UserAddressScreenState();
}

class _UserAddressScreenState extends State<UserAddressScreen> {
  final _startPointController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter MapBox AutoComplete example"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: CustomTextField(
          hintText: "Select starting point",
          textController: _startPointController,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapBoxAutoCompleteWidget(
                  apiKey: "Your MapBox token here",
                  hint: "Select starting point",
                  onSelect: (place) {
                    // TODO : Process the result gotten
                    _startPointController.text = place.placeName;
                  },
                  limit: 10,
                ),
              ),
            );
          },
          enabled: true,
        ),
      ),
    );
  }
}