// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      userId: json['user_id'] as int?,
      occupationId: json['occupation_id'] as int?,
      experience: json['experience'] as String?,
      wages: json['wages'] as String?,
      wPeriod: json['w_period'] as String?,
      additionalInfo: json['additional_info'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      skillId: json['skill_id'] as int?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'user_id': instance.userId,
      'occupation_id': instance.occupationId,
      'experience': instance.experience,
      'wages': instance.wages,
      'w_period': instance.wPeriod,
      'additional_info': instance.additionalInfo,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'skill_id': instance.skillId,
      'error': instance.error,
    };
