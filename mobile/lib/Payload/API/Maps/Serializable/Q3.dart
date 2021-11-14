import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import '../../../../constraints.dart';

part 'Q3.g.dart';

@JsonSerializable()
class Vaccine {
  Vaccine({
    required this.name
  });

  factory Vaccine.fromJson(Map<String, dynamic> json) => _$VaccineFromJson(json);
  Map<String, dynamic> toJson() => _$VaccineToJson(this);

  final String name;
}

@JsonSerializable()
class Value {
  Value({
    required this.count,
    required this.vaccines
  });

  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);
  Map<String, dynamic> toJson() => _$ValueToJson(this);

  final int count;
  final List<Vaccine> vaccines;
}

@JsonSerializable()
class QThree {
  QThree({
    required this.values
  });

  factory QThree.fromJson(Map<String, dynamic> json) => _$QThreeFromJson(json);
  Map<String, dynamic> toJson() => _$QThreeToJson(this);

  final List<Value> values;
}

// api/v0/DailyInfected
Future<QThree> placeDailyInfected() async {
  String request = backend + '/DailyInfected';

  try {
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      return QThree.fromJson(json.decode(response.body));
    }
  } catch (e) {
    print(e);
  }

  return QThree.fromJson(
      json.decode('{"count":"0","vaccines":[{name: "Pfizer"}]}')
  );
}

