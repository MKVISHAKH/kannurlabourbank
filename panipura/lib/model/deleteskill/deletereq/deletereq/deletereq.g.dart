// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletereq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deletereq _$DeletereqFromJson(Map<String, dynamic> json) => Deletereq(
      userId: (json['user_id'] as num?)?.toInt(),
      skillId: (json['skill_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DeletereqToJson(Deletereq instance) => <String, dynamic>{
      'user_id': instance.userId,
      'skill_id': instance.skillId,
    };
