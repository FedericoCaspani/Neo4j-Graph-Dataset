// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Q2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QTwo _$QTwoFromJson(Map<String, dynamic> json) => QTwo(
      places: (json['places'] as List<dynamic>)
          .map((e) => Place.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int,
    );

Map<String, dynamic> _$QTwoToJson(QTwo instance) => <String, dynamic>{
      'places': instance.places,
      'count': instance.count,
    };

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      name: json['name'] as String,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'name': instance.name,
      'x': instance.x,
      'y': instance.y,
    };
