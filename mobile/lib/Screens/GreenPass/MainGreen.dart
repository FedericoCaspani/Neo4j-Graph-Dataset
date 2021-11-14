import 'package:covid_free_app/Screens/GreenPass/Analytics.dart';
import 'package:covid_free_app/Screens/GreenPass/GreenPass.dart';
import 'package:covid_free_app/Screens/GreenPass/Logout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constraints.dart';

/*
*
* This class is notifying user about his/her must-take swab
* */
class MainGreen extends StatefulWidget {

  @override
  _MainGreenState createState() => _MainGreenState();

}

class _MainGreenState extends State<MainGreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: Container(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100,),
              ClipOval(
                child: Image.network(
                  logoBarCode,
                  height: 300.0,
                  width: 300.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 50.0,),
              GreenPass(),
              SizedBox(height: 20.0,),
              Analytics(),
              SizedBox(height: 20.0,),
              Logout()
            ],
          ),
        ),
      ),
    );
  }
}