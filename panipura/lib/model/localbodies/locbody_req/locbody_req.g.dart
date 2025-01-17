// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locbody_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocbodyReq _$LocbodyReqFromJson(Map<String, dynamic> json) => LocbodyReq(
      districtId: (json['district_id'] as num?)?.toInt(),
      lbTypeId: (json['lb_type_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LocbodyReqToJson(LocbodyReq instance) =>
    <String, dynamic>{
      'district_id': instance.districtId,
      'lb_type_id': instance.lbTypeId,
    };
