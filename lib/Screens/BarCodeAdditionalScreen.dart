import 'package:covid_free_app/Payload/DataManagement/BarCodeStore.dart';
import 'package:covid_free_app/Screens/MaynLayout.dart';
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
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              onSubmitted: (String value) => scanBarCode(value),
            )
          ],
        ),
      ),
    );
  }

  Future scanBarCode(String scanResult) async {

      if (!mounted) return;

      setState(() => this.scanResult = scanResult);

      _barCodeStorage.setBarCode(scanResult);

      String barCode = await _barCodeStorage.getBarCode();

      if (barCode != '-1') {
        showDialog(
          context: context,
          builder: (context) => _buildPopupDialog(context),
        );
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
                MaterialPageRoute(builder: (context) => MainLayout())
            );
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}