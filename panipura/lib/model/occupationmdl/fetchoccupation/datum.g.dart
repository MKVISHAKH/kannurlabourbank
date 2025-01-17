// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      occupationId: (json['occupation_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameMl: json['name_ml'] as String?,
      typeId: (json['type_id'] as num?)?.toInt(),
      qualification: json['qualification'],
      qualificationMl: json['qualification_ml'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'occupation_id': instance.occupationId,
      'name': instance.name,
      'name_ml': instance.nameMl,
      'type_id': instance.typeId,
      'qualification': instance.qualification,
      'qualification_ml': instance.qualificationMl,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
