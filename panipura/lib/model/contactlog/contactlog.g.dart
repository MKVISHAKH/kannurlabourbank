// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contactlog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contactlog _$ContactlogFromJson(Map<String, dynamic> json) => Contactlog(
      contactTime: json['contact_time'] as String?,
      employerId: (json['employer_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      empMob: json['employer_mobile'] as String?,
      usrMob: json['user_mobile'] as String?,
    );

Map<String, dynamic> _$ContactlogToJson(Contactlog instance) =>
    <String, dynamic>{
      'contact_time': instance.contactTime,
      'employer_id': instance.employerId,
      'user_id': instance.userId,
      'employer_mobile': instance.empMob,
      'user_mobile': instance.usrMob,
    };
