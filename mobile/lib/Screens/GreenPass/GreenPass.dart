import 'package:covid_free_app/Payload/DataManagement/QRCodeStorage.dart';
import 'package:covid_free_app/Payload/Models/GreenPass.dart';
import 'package:covid_free_app/Payload/Models/Infected.dart';
import 'package:covid_free_app/constraints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;


class GreenPass extends StatefulWidget {
  @override
  _GreenPassState createState() => _GreenPassState();
}

class _GreenPassState extends State<GreenPass> {

  final QRCodeStorage _qrCodeStorage = new QRCodeStorage();
  var scanResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: scanQRCode,
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(15.0),
            primary: kPrimaryColor,
            onPrimary: kPrimaryLightColor
        ),
        child: Icon(
          Icons.qr_code_2_outlined,
          size: 35.0,
        ),
      ),
    );
  }

  // TODO: insert the work with the server
  Future scanQRCode() async {
    try {
      final scanResult = await FlutterBarcodeScanner.scanBarcode(
          "#FF6666", // the line that shows the process of scanning
          "Cancel",
          false,
          ScanMode.QR
      );
      if (!mounted) return;

      setState(() => this.scanResult = scanResult);

      if (scanResult.contains('dateStart')) {
        GreenPassModel greenPass = GreenPassModel.fromJson(scanResult);
        _qrCodeStorage.setQRCode(greenPass);
        try {
          String request = backend + '/SetGreen';
          var response = await http.post(Uri.parse(request), headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'});

          if (response.statusCode == 201) {
            print('Luck!');
          }
        } catch (e) {
          print(e);
        }
      } else {
        InfectedModel infectedModel = InfectedModel.fromJson(scanResult);
        _qrCodeStorage.setQRCode(infectedModel);
        try {
          String request = backend + '/SetPositive';
          var response = await http.post(Uri.parse(request), headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'});

          if (response.statusCode == 201) {
            print('Luck!');
          }

        } catch (e) {

        }
      }


      String barCode = await _qrCodeStorage.getQRCode();

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

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Everything is fine! You have got the green pass!'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}