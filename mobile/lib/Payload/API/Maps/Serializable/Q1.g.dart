// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Q1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QOne _$QOneFromJson(Map<String, dynamic> json) => QOne(
      persons: (json['persons'] as List<dynamic>)
          .map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QOneToJson(QOne instance) => <String, dynamic>{
      'persons': instance.persons,
    };

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
