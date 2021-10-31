import 'package:shared_preferences/shared_preferences.dart';


/*
* This class is created to store the tax code locally in terms of performance
* Assumption is that the only one guy has only one tax code
* */

class BarCodeStorage {

  BarCodeStorage();

  Future<String> getBarCode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('barCode') ?? '';
  }

  Future setBarCode(String barCode) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('barCode') == null) {
      prefs.setString('barCode', barCode);
    }
  }

  Future removeBarCode() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('barCode');
  }

}