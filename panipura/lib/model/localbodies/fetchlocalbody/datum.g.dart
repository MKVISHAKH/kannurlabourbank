// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      name: json['name'] as String?,
      nameMl: json['name_ml'] as String?,
      localbodyId: (json['localbody_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'name': instance.name,
      'name_ml': instance.nameMl,
      'localbody_id': instance.localbodyId,
    };
