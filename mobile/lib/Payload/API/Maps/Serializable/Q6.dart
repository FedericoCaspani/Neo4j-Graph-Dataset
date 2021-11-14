import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import '../../../../constraints.dart';

part 'Q6.g.dart';

@JsonSerializable()
class Person {

  Person({
    required this.name,
    required this.surname,
    required this.taxCode,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);

  final String name;
  final String surname;
  final String taxCode;
}

@JsonSerializable()
class QSix {
  QSix({
    required this.count,
    required this.date,
    required this.placeName,
    required this.persons
  });

  factory QSix.fromJson(Map<String, dynamic> json) => _$QSixFromJson(json);
  Map<String, dynamic> toJson() => _$QSixToJson(this);

  final int count;
  final String date;
  final String placeName;
  final List<Person> persons;
}

// api/v0/MostVisited/
Future<QSix> mostVisited() async {
  String request = backend + "/MostVisited";
  
  try {
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      return QSix.fromJson(json.decode(response.body));
    }
  } catch (e) {
    print(e);
  }
  
  return QSix.fromJson(json.decode('{"count": "0", date:"2000-01-01", "placeName": "Moscow", '
      '"persons":[{"name": "name", "surname":"surname", "taxCode":"taxCode"}]}'));
}
