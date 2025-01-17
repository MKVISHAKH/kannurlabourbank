// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratingreqmdl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ratingreqmdl _$RatingreqmdlFromJson(Map<String, dynamic> json) => Ratingreqmdl(
      employerId: (json['employer_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
      skillId: (json['skill_id'] as num?)?.toInt(),
      comments: json['comments'] as String?,
    );

Map<String, dynamic> _$RatingreqmdlToJson(Ratingreqmdl instance) =>
    <String, dynamic>{
      'employer_id': instance.employerId,
      'user_id': instance.userId,
      'rating': instance.rating,
      'skill_id': instance.skillId,
      'comments': instance.comments,
    };
