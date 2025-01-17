// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addreflistskill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Addreflistskill _$AddreflistskillFromJson(Map<String, dynamic> json) =>
    Addreflistskill(
      referenceId: (json['reference_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      skillId: (json['skill_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AddreflistskillToJson(Addreflistskill instance) =>
    <String, dynamic>{
      'reference_id': instance.referenceId,
      'user_id': instance.userId,
      'skill_id': instance.skillId,
      'name': instance.name,
      'mobile': instance.mobile,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
