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

  final TextEditingController _textEditingController = new TextEditingController();
  final BarCodeStorage _barCodeStorage = new BarCodeStorage();
  String namePerson = '';
  String birthDate = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              controller: _textEditingController,
              onSubmitted: (String value) => {
                namePerson = value
              },
            ),
            SizedBox(height: 12,),
            //TODO: if I had time redo it into something fancy (like calendar choose)
            Text(
                'Please enter your birthdate'
            ),
            SizedBox(height: 28,),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Birthdate'
              ),
              controller: _textEditingController,
              onSubmitted: (String value) => {
                birthDate = value
              },
            ),
            SizedBox(height: 12,),
            Text(
                'Please enter your surname'
            ),
            SizedBox(height: 28,),
            TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Surname'
                ),
                controller: _textEditingController,
              onSubmitted: (String value) => saveModel(value),
            ),
          ],
        ),
      ),
    );
  }

  Future saveModel(String surname) async {

    if (namePerson == '') {
      showDialog(
        context: context,
        builder: (context) => _buildAlert(context)
      );
    } else if (surname == '') {
      showDialog(context: context, builder: (context) => _buildAlert(context));
    } else if (birthDate == '') {
      showDialog(context: context, builder: (context) => _buildAlert(context));
    } else {
      // TODO: send information to Neo4j
      Person(namePerson, surname, await _barCodeStorage.getBarCode(), birthDate);
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
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainLayout())
            );
          },
          child: const Text('OK'),
        )
      ],
    );
  }

}