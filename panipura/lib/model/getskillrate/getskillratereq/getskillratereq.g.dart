// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getskillratereq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Getskillratereq _$GetskillratereqFromJson(Map<String, dynamic> json) =>
    Getskillratereq(
      userId: (json['user_id'] as num?)?.toInt(),
      skillId: (json['skill_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetskillratereqToJson(Getskillratereq instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'skill_id': instance.skillId,
    };
