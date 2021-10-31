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
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _barCodeCheck();
    });
  }

  void _barCodeCheck() async {
    String barCode = await _barCodeStorage.getBarCode();
    //String barCode = 'sss';
    if ( barCode == '') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => BarCodeScreen()
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.width,
        child: MainLayout(),
      ),
    );
  }

}
