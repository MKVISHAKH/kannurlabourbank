// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchlabourmdl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Searchlabourmdl _$SearchlabourmdlFromJson(Map<String, dynamic> json) =>
    Searchlabourmdl(
      userId: (json['user_id'] as num?)?.toInt(),
      occupationId: (json['occupation_id'] as num?)?.toInt(),
      districtId: (json['district_id'] as num?)?.toInt(),
      lbTypeId: (json['lb_type_id'] as num?)?.toInt(),
      localbodyId: (json['localbody_id'] as num?)?.toInt(),
      experience: json['experience'] as String?,
      minWage: json['min_wage'] as String?,
      maxWage: json['max_wage'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$SearchlabourmdlToJson(Searchlabourmdl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'occupation_id': instance.occupationId,
      'district_id': instance.districtId,
      'lb_type_id': instance.lbTypeId,
      'localbody_id': instance.localbodyId,
      'experience': instance.experience,
      'min_wage': instance.minWage,
      'max_wage': instance.maxWage,
      'token': instance.token,
    };
