import 'package:covid_free_app/Payload/DataManagement/BarCodeStore.dart';
import 'package:covid_free_app/Payload/Models/Person.dart';
import 'package:covid_free_app/constraints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MaynLayout.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  final TextEditingController _textEditingControllerOne = new TextEditingController();
  final TextEditingController _textEditingControllerSec = new TextEditingController();
  final BarCodeStorage _barCodeStorage = new BarCodeStorage();
  String namePerson = '';
  String surName = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              ClipOval(
                child: Image.network(
                  logoBarCode,
                  height: 200.0,
                  width: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Please enter your name'
              ),
              SizedBox(height: 28,),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name'
                ),
                controller: _textEditingControllerOne,
                onSubmitted: (String value) => setState(() {
                  this.namePerson = value;
                })
              ),
              SizedBox(height: 12,),
              Text('Please enter your surname'),
              SizedBox(height: 28,),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Surname'
                ),
                controller: _textEditingControllerSec,
                onSubmitted: (String value) => setState(() {
                  this.surName = value;
                })
            ),
            SizedBox(height: 28,),
            SizedBox(
              width: 300.0,
              child: ElevatedButton.icon(
                  label: Text(
                    'Press here to continue',
                  ),
                  icon: Icon(Icons.input_outlined),
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      onPrimary: Colors.black,
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14
                      )
                  ),
                  onPressed: saveModel
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future saveModel() async {

    if (namePerson == '') {
      showDialog(
        context: context,
        builder: (context) => _buildAlert(context)
      );
    } else if (surName == '') {
      showDialog(context: context, builder: (context) => _buildAlert(context));
    } else {
      // TODO: send information to Neo4j
      Person(namePerson, surName, await _barCodeStorage.getBarCode());
      showDialog(context: context, builder: (context) => _goToMain(context));
    }
  }

  Widget _buildAlert(BuildContext context) {
    return new AlertDialog(
      title: const Text('You have not entered the valuable information!'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  Widget _goToMain(BuildContext context) {
    return new AlertDialog(
      title: const Text('You are done everything correctly! Welcome!'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
                context,
                '/menu'
            );
          },
          child: const Text('OK'),
        )
      ],
    );
  }

}