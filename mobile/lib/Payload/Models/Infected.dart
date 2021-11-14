import 'package:covid_free_app/Payload/Models/QRModel.dart';

class InfectedModel extends QRModel {
  final String taxCode;
  final String name;
  final String surname;
  final String dateOfInfection;

  InfectedModel(this.taxCode, this.name, this.surname, this.dateOfInfection);

  factory InfectedModel.fromJson(dynamic json) {
    return InfectedModel(json['taxCode'] as String, json['name'] as String, json['surname'] as String, json['date_of_infection'] as String);
  }

  @override
  String toString() {
    return '{ ${this.taxCode}, ${this.name}, ${this.surname}, ${this.dateOfInfection} }';
  }
}