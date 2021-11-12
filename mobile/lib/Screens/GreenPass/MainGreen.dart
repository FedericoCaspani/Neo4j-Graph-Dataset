import 'package:covid_free_app/Screens/GreenPass/GreenPass.dart';
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipOval(
            child: Image.network(
              logoBarCode,
              height: 300.0,
              width: 300.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20.0,),
          GreenPass(),
          SizedBox(height: 20.0,),
          //TODO: here we will have an analytics; think about the representation
        ],
      ),
    );
  }
}