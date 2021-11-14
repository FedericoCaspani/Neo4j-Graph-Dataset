import 'package:covid_free_app/Payload/DataManagement/BarCodeStore.dart';
import 'package:covid_free_app/Screens/Registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import '../../constraints.dart';
import 'BarCodeAdditionalScreen.dart';

class BarCodeScreen extends StatefulWidget {
  @override
  _BarCodeScreenState createState() => _BarCodeScreenState();
}

class _BarCodeScreenState extends State<BarCodeScreen> {

  String? scanResult;
  BarCodeStorage _barCodeStorage = new BarCodeStorage();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //style: fontButton,
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: Image.network(
                logoBarCode,
                height: 300.0,
                width: 300.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: 300.0,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      onPrimary: Colors.black,
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14
                      )
                  ),
                  onPressed: scanBarCode,
                  icon: Icon(Icons.settings_overscan_outlined),
                  label: Text(
                    'Press here to start scan your tax code!',
                  )
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: 300.0,
              child: ElevatedButton.icon(
                label: Text(
                  'Press here, if you can\'t scan tax code!',
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BarCodeAdditionalScreen())
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }

  Future scanBarCode() async {

    try {
      final scanResult = await FlutterBarcodeScanner.scanBarcode(
          "#FF6666", // the line that shows the process of scanning
          "Cancel",
          false,
          ScanMode.BARCODE
      );
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
    } on PlatformException {
      this.scanResult = "Failed to get platform version";
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
