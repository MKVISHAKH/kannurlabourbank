// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchlablist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Searchlablist _$SearchlablistFromJson(Map<String, dynamic> json) =>
    Searchlablist(
      skillId: (json['skill_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      place: json['place'] as String?,
      dob: json['dob'] as String?,
      mobile: json['mobile'] as String?,
      occupationId: (json['occupation_id'] as num?)?.toInt(),
      occupationName: json['occupation_name'] as String?,
      experience: json['experience'] as String?,
      wages: (json['wages'] as num?)?.toInt(),
      wPeriod: json['w_period'] as String?,
      additionalInfo: json['additional_info'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      rating: json['rating'] as String?,
    );

Map<String, dynamic> _$SearchlablistToJson(Searchlablist instance) =>
    <String, dynamic>{
      'skill_id': instance.skillId,
      'user_id': instance.userId,
      'name': instance.name,
      'place': instance.place,
      'dob': instance.dob,
      'mobile': instance.mobile,
      'occupation_id': instance.occupationId,
      'occupation_name': instance.occupationName,
      'experience': instance.experience,
      'wages': instance.wages,
      'w_period': instance.wPeriod,
      'additional_info': instance.additionalInfo,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'rating': instance.rating,
    };
