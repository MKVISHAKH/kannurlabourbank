// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      rating: json['rating'] as int?,
      employerId: json['employer_id'] as int?,
      skillId: json['skill_id'] as int?,
      comments: json['comments'] as String?,
      userId: json['user_id'] as int?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      ratingId: json['rating_id'] as int?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'rating': instance.rating,
      'employer_id': instance.employerId,
      'skill_id': instance.skillId,
      'comments': instance.comments,
      'user_id': instance.userId,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'rating_id': instance.ratingId,
    };
