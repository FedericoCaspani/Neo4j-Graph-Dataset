// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Q6.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      name: json['name'] as String,
      surname: json['surname'] as String,
      taxCode: json['taxCode'] as String,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'taxCode': instance.taxCode,
    };

QSix _$QSixFromJson(Map<String, dynamic> json) => QSix(
      count: json['count'] as int,
      date: json['date'] as String,
      placeName: json['placeName'] as String,
      persons: (json['persons'] as List<dynamic>)
          .map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QSixToJson(QSix instance) => <String, dynamic>{
      'count': instance.count,
      'date': instance.date,
      'placeName': instance.placeName,
      'persons': instance.persons,
    };
