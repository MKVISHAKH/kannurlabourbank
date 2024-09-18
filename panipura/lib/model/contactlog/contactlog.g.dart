// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contactlog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contactlog _$ContactlogFromJson(Map<String, dynamic> json) => Contactlog(
      contactTime: json['contact_time'] as String?,
      employerId: json['employer_id'] as int?,
      userId: json['user_id'] as int?,
    );

Map<String, dynamic> _$ContactlogToJson(Contactlog instance) =>
    <String, dynamic>{
      'contact_time': instance.contactTime,
      'employer_id': instance.employerId,
      'user_id': instance.userId,
    };
