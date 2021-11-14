import 'dart:convert';

import 'package:covid_free_app/constraints.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'Q1.g.dart';


@JsonSerializable()
class QOne {
  QOne({
    required this.persons
  });

  factory QOne.fromJson(Map<String, dynamic> json) => _$QOneFromJson(json);
  Map<String, dynamic> toJson() => _$QOneToJson(this);

  final List<Person> persons;
}

@JsonSerializable()
class Person {
  Person({
    required this.name,
    required this.surname,
    required this.taxCode
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);

  final String name;
  final String surname;
  final String taxCode;
}

// api/v0/PlaceQuarPeop/<string:val>
Future<QOne> placeQuarantinedPeople(String value) async {
  String request = backend+ '/PlaceQuarPeop/' + value;

  try {
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      return QOne.fromJson(json.decode(response.body));
    }
  } catch (e) {
    print(e);
  }

  return QOne.fromJson(
      json.decode('{"name":"","surname":"", "taxCode":""}')
  );
}