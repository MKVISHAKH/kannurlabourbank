// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addskillreq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Addskillreq _$AddskillreqFromJson(Map<String, dynamic> json) => Addskillreq(
      userId: (json['user_id'] as num?)?.toInt(),
      occupationId: (json['occupation_id'] as num?)?.toInt(),
      experience: json['experience'] as String?,
      wages: json['wages'] as String?,
      wPeriod: json['w_period'] as String?,
      additionalInfo: json['additional_info'] as String?,
    );

Map<String, dynamic> _$AddskillreqToJson(Addskillreq instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'occupation_id': instance.occupationId,
      'experience': instance.experience,
      'wages': instance.wages,
      'w_period': instance.wPeriod,
      'additional_info': instance.additionalInfo,
    };
