import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import '../../../../constraints.dart';

part 'Q4.g.dart';

@JsonSerializable()
class QFour {
  QFour({
    required this.healthy,
    required this.infected,
    required this.ratio
  });

  factory QFour.fromJson(Map<String, dynamic> json) => _$QFourFromJson(json);
  Map<String, dynamic> toJson() => _$QFourToJson(this);

  final int healthy;
  final int infected;
  final double ratio;
}

// api/v0/InfectedHealed
Future<QFour> placeInfectedHealed() async {
  String request = backend + '/InfectedHealed';

  try {
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      return QFour.fromJson(json.decode(response.body));
    }
  } catch (e) {
    print(e);
  }

  return QFour.fromJson(
      json.decode('{"healthy":"0","infected":"0", "ratio": "0"}')
  );
}

