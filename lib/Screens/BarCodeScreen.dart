import 'package:covid_free_app/Payload/DataManagement/BarCodeStore.dart';
import 'package:covid_free_app/Screens/MaynLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import '../../constraints.dart';

class BarCodeScreen extends StatefulWidget {
  @override
  _BarCodeScreenState createState() => _BarCodeScreenState();
}

class _BarCodeScreenState extends State<BarCodeScreen> {

  String? scanResult = "A";
  BarCodeStorage _barCodeStorage = new BarCodeStorage();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "$scanResult",
            ) ,
            SizedBox(height: 28,),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    onPrimary: Colors.black
                ),
                onPressed: scanBarCode,
                icon: Icon(Icons.camera_alt_outlined),
                label: Text('Start scan')
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

      /*_barCodeStorage.setBarCode(scanResult);

      String barCode = await _barCodeStorage.getBarCode();

      // TODO: do the greetings
      if (barCode != '') {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainLayout())
        );
      }*/

    } on PlatformException {
      this.scanResult = "Failed to get platform version";
    }

  }
}