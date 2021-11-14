import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import '../../../../constraints.dart';

part 'Q5.g.dart';

@JsonSerializable()
class QFive {
  QFive({
    required this.infected,
    required this.tested,
    required this.ratio
  });

  factory QFive.fromJson(Map<String, dynamic> json) => _$QFiveFromJson(json);
  Map<String, dynamic> toJson() => _$QFiveToJson(this);

  final int infected;
  final int tested;
  final double ratio;
}

// api/v0/GetDailyStamp
Future<QFive> placeDailyStamp() async {
  String request = backend + '/GetDailyStamp';

  try {
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      return QFive.fromJson(json.decode(response.body));
    }
  } catch (e) {
    print(e);
  }

  return QFive.fromJson(
      json.decode('{"infected":"0","tested":"0", "ratio":"0"}')
  );
}

