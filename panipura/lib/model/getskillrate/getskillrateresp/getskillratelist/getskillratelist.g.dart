// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getskillratelist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Getskillratelist _$GetskillratelistFromJson(Map<String, dynamic> json) =>
    Getskillratelist(
      ratingId: json['rating_id'] as int?,
      userId: json['user_id'] as int?,
      employerId: json['employer_id'] as int?,
      skillId: json['skill_id'] as int?,
      rating: json['rating'] as int?,
      comments: json['comments'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      userName: json['user_name'] as String?,
      skillName: json['skill_name'] as String?,
      employerName: json['employer_name'] as String?,
    );

Map<String, dynamic> _$GetskillratelistToJson(Getskillratelist instance) =>
    <String, dynamic>{
      'rating_id': instance.ratingId,
      'user_id': instance.userId,
      'employer_id': instance.employerId,
      'skill_id': instance.skillId,
      'rating': instance.rating,
      'comments': instance.comments,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'user_name': instance.userName,
      'skill_name': instance.skillName,
      'employer_name': instance.employerName,
    };
