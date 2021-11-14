import 'dart:convert';

import 'package:covid_free_app/constraints.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'Q2.g.dart';


@JsonSerializable()
class QTwo {
  QTwo({
    required this.places,
    required this.count
  });

  factory QTwo.fromJson(Map<String, dynamic> json) => _$QTwoFromJson(json);
  Map<String, dynamic> toJson() => _$QTwoToJson(this);

  final List<Place> places;
  final int count;
}

@JsonSerializable()
class Place {
  Place({
    required this.name,
    required this.x,
    required this.y
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  final String name;
  final double x;
  final double y;
}

// api/v0/PlaceAmountPeop
Future<QTwo> placeAmountPeople() async {
  String request = backend+ '/PlaceAmountPeop';

  try {
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      return QTwo.fromJson(json.decode(response.body));
    }
  } catch (e) {
    print(e);
  }

  return QTwo.fromJson(
    json.decode('{"count":3,"places":[{"name":"ul Alex Monahovoy","x":55.3,"y":37.48}]}')
  );
}