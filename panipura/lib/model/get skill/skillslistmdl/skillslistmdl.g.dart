// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skillslistmdl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Skillslistmdl _$SkillslistmdlFromJson(Map<String, dynamic> json) =>
    Skillslistmdl(
      skillId: (json['skill_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      occupationId: (json['occupation_id'] as num?)?.toInt(),
      occupationname: json['occupation_name'] as String?,
      experience: json['experience'] as String?,
      wages: (json['wages'] as num?)?.toInt(),
      wPeriod: json['w_period'] as String?,
      additionalInfo: json['additional_info'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      skillname: json['skillname'] as String?,
      error: json['error'] as String?,
    )..willingpanchayath = json['willing_panchayath'] == null
        ? null
        : DateTime.parse(json['willing_panchayath'] as String);

Map<String, dynamic> _$SkillslistmdlToJson(Skillslistmdl instance) =>
    <String, dynamic>{
      'skill_id': instance.skillId,
      'user_id': instance.userId,
      'occupation_id': instance.occupationId,
      'occupation_name': instance.occupationname,
      'experience': instance.experience,
      'wages': instance.wages,
      'w_period': instance.wPeriod,
      'willing_panchayath': instance.willingpanchayath?.toIso8601String(),
      'additional_info': instance.additionalInfo,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'skillname': instance.skillname,
      'error': instance.error,
    };
