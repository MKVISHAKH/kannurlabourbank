// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getskillreq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Getskillreq _$GetskillreqFromJson(Map<String, dynamic> json) => Getskillreq(
      userId: (json['user_id'] as num?)?.toInt(),
      token: json['token'] as String?,
      locale: json['locale'] as String?,
    );

Map<String, dynamic> _$GetskillreqToJson(Getskillreq instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'token': instance.token,
      'locale': instance.locale,
    };
