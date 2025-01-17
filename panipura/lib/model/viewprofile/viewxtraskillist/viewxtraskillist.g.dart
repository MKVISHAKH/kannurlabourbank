// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewxtraskillist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Viewxtraskillist _$ViewxtraskillistFromJson(Map<String, dynamic> json) =>
    Viewxtraskillist(
      skillId: (json['skill_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      occupationId: (json['occupation_id'] as num?)?.toInt(),
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
    );

Map<String, dynamic> _$ViewxtraskillistToJson(Viewxtraskillist instance) =>
    <String, dynamic>{
      'skill_id': instance.skillId,
      'user_id': instance.userId,
      'occupation_id': instance.occupationId,
      'experience': instance.experience,
      'wages': instance.wages,
      'w_period': instance.wPeriod,
      'additional_info': instance.additionalInfo,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
