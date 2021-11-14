import 'package:shared_preferences/shared_preferences.dart';

class QRCodeStorage {
  QRCodeStorage();

  Future<String> getQRCode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('qrCodeCovidFree') ?? '-1';
  }

  Future setQRCode(String barCode) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('qrCodeCovidFree') == null && prefs.getString('qrCodeCovidFree') == '-1') {
      prefs.setString('qrCodeCovidFree', barCode);
    }
  }

  Future removeQRCode() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('qrCodeCovidFree');
  }

}