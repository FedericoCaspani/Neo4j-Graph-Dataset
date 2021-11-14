import 'package:covid_free_app/Payload/Models/QRModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRCodeStorage {
  QRCodeStorage();

  Future<String> getQRCode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('qrCodeCovidFree') ?? '-1';
  }

  Future setQRCode(QRModel barCode) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('qrCodeCovidFree') == null && prefs.getString('qrCodeCovidFree') == '-1') {
      prefs.setString('qrCodeCovidFree', barCode.toString());
    }
  }

  Future removeQRCode() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('qrCodeCovidFree');
  }

}