import 'package:covid_free_app/Payload/Models/QRModel.dart';

class GreenPassModel extends QRModel {
  final String taxCode;
  final String date1;
  final String date2;
  final String typeVac;

  GreenPassModel(this.taxCode, this.date1, this.date2, this.typeVac);

  factory GreenPassModel.fromJson(dynamic json) {
    return GreenPassModel(json['taxCode'] as String, json['date1'] as String, json['date2'] as String, json['typeVac'] as String);
  }

  @override
  String toString() {
    return '{ ${this.taxCode}, ${this.date1}, ${this.date2}, ${this.typeVac} }';
  }
}