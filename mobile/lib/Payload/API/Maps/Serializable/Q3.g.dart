// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Q3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vaccine _$VaccineFromJson(Map<String, dynamic> json) => Vaccine(
      name: json['name'] as String,
    );

Map<String, dynamic> _$VaccineToJson(Vaccine instance) => <String, dynamic>{
      'name': instance.name,
    };

Value _$ValueFromJson(Map<String, dynamic> json) => Value(
      count: json['count'] as int,
      vaccines: (json['vaccines'] as List<dynamic>)
          .map((e) => Vaccine.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ValueToJson(Value instance) => <String, dynamic>{
      'count': instance.count,
      'vaccines': instance.vaccines,
    };

QThree _$QThreeFromJson(Map<String, dynamic> json) => QThree(
      values: (json['values'] as List<dynamic>)
          .map((e) => Value.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QThreeToJson(QThree instance) => <String, dynamic>{
      'values': instance.values,
    };
