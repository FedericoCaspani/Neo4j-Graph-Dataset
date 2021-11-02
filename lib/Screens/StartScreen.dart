import 'package:covid_free_app/Payload/DataManagement/BarCodeStore.dart';
import 'package:covid_free_app/Screens/BarCodeScreen.dart';
import 'package:covid_free_app/Screens/MaynLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
* Decide which screen to run either with taxCode
* or without it
* */

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  final BarCodeStorage _barCodeStorage = new BarCodeStorage();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return FutureBuilder(
        future: _barCodeStorage.getBarCode(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.data != '-1') {
            // TODO just for the test
            return MainLayout();
          }
          return BarCodeScreen();
        }
    );
  }

}
