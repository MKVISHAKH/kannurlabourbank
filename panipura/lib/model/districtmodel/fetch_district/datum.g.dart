// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      districtId: (json['district_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameMl: json['name_ml'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'district_id': instance.districtId,
      'name': instance.name,
      'name_ml': instance.nameMl,
    };
