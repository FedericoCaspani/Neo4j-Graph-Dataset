// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Q5.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QFive _$QFiveFromJson(Map<String, dynamic> json) => QFive(
      infected: json['infected'] as int,
      tested: json['tested'] as int,
      ratio: (json['ratio'] as num).toDouble(),
    );

Map<String, dynamic> _$QFiveToJson(QFive instance) => <String, dynamic>{
      'infected': instance.infected,
      'tested': instance.tested,
      'ratio': instance.ratio,
    };
