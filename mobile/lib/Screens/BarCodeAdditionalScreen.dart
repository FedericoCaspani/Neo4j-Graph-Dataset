import 'package:covid_free_app/Payload/DataManagement/BarCodeStore.dart';
import 'package:covid_free_app/Screens/Registration.dart';
import 'package:covid_free_app/constraints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarCodeAdditionalScreen extends StatefulWidget {
  @override
  _BarCodeAdditionalScreen createState() => _BarCodeAdditionalScreen();
}

class _BarCodeAdditionalScreen extends State<BarCodeAdditionalScreen> {

  final TextEditingController _textController = new TextEditingController();
  final BarCodeStorage _barCodeStorage = new BarCodeStorage();
  String? scanResult;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              'Please enter your tax code in this field'
            ),
            SizedBox(height: 28,),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tax code'
              ),
              controller: _textController,
              onSubmitted: (String value) => setState(() {
                this.scanResult = value;
              }),
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
                onPressed: scanBarCode
              ),
            )
          ],
        ),
      ),
    );
  }

  Future scanBarCode() async {

      if (!mounted) return;

      if (this.scanResult == null) {
        showDialog(
          context: context,
          builder: (context) => _buildAlarm(context),
        );
      } else {
        _barCodeStorage.setBarCode(this.scanResult.toString());

        String barCode = await _barCodeStorage.getBarCode();

        if (barCode != '-1') {
          showDialog(
            context: context,
            builder: (context) => _buildPopupDialog(context),
          );
        }
      }
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Everything is fine! You could proceed'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Registration())
            );
          },
          child: const Text('OK'),
        )
      ],
    );
  }

  Widget _buildAlarm(BuildContext context) {
    return new AlertDialog(
      title: const Text('You have not entered your tax code!'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}