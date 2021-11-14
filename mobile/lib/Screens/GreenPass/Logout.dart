import 'package:covid_free_app/Payload/DataManagement/BarCodeStore.dart';
import 'package:covid_free_app/Payload/DataManagement/QRCodeStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constraints.dart';

class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {

  final BarCodeStorage _barCodeStorage = new BarCodeStorage();
  final QRCodeStorage _qrCodeStorage = new QRCodeStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: logout,
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(15.0),
            primary: kPrimaryColor,
            onPrimary: kPrimaryLightColor
        ),
        child: Icon(
          Icons.logout_outlined,
          size: 35.0,
        ),
      ),
    );
  }

  Future logout() async {
    _qrCodeStorage.removeQRCode();
    _barCodeStorage.removeBarCode();

    showDialog(context: context, builder: (context) => _buildReturn(context));
  }

  Widget _buildReturn(BuildContext context) {
    return new AlertDialog(
      title: const Text('You have been succesfully logged out!'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
                context,
                '/start'
            );
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}