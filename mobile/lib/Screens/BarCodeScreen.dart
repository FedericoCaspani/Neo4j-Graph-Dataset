import 'package:covid_free_app/Payload/DataManagement/BarCodeStore.dart';
import 'package:covid_free_app/Screens/MaynLayout.dart';
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
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    onPrimary: Colors.black,
                    textStyle: const TextStyle(fontSize: 30),
                    fixedSize: Size(size.height * 3/4, size.width)
                ),
                onPressed: scanBarCode,
                child: const Text('Press here to start scan your tax code!')
            ),
            ElevatedButton(
              child: const Text('Press here, f you cannot scan your tax code'),
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 30),
                  fixedSize: Size(size.height * 1/4, size.width)
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BarCodeAdditionalScreen())
                );
              },
            )
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
              MaterialPageRoute(builder: (context) => MainLayout())
          );
        },
        child: const Text('OK'),
      )
    ],
  );
}
