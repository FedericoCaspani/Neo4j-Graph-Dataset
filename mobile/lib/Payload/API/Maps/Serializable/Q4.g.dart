// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Q4.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QFour _$QFourFromJson(Map<String, dynamic> json) => QFour(
      healthy: json['healthy'] as int,
      infected: json['infected'] as int,
      ratio: (json['ratio'] as num).toDouble(),
    );

Map<String, dynamic> _$QFourToJson(QFour instance) => <String, dynamic>{
      'healthy': instance.healthy,
      'infected': instance.infected,
      'ratio': instance.ratio,
    };
