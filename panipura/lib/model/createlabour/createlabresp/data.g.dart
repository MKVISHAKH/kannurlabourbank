// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      userId: (json['user_id'] as num?)?.toInt(),
      empId: (json['employer_id'] as num?)?.toInt(),
      token: json['token'] as String?,
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'user_id': instance.userId,
      'employer_id': instance.empId,
      'token': instance.token,
      'name': instance.name,
      'mobile': instance.mobile,
    };
