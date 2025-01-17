// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edithmtwnreq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Edithmtwnreq _$EdithmtwnreqFromJson(Map<String, dynamic> json) => Edithmtwnreq(
      userId: (json['user_id'] as num?)?.toInt(),
      place: json['place'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$EdithmtwnreqToJson(Edithmtwnreq instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'place': instance.place,
      'token': instance.token,
    };
