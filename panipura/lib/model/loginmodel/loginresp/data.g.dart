// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      userId: (json['id'] as num?)?.toInt(),
      employerId: (json['employer_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      address: json['address'] as String?,
      place: json['place'] as String?,
      post: json['post'] as String?,
      pin: json['pin'] as String?,
      genderId: (json['gender_id'] as num?)?.toInt(),
      districtId: (json['district_id'] as num?)?.toInt(),
      blockId: (json['block_id'] as num?)?.toInt(),
      localbodyId: (json['localbody_id'] as num?)?.toInt(),
      dob: json['dob'] as String?,
      aadhaar: json['aadhaar'] as String?,
      mobile: json['mobile'] as String?,
      educationId: (json['education_id'] as num?)?.toInt(),
      category: (json['category'] as num?)?.toInt(),
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      token: json['token'] as String?,
      error: json['error'] as String?,
      mobileverified: json['mobile_verified'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.userId,
      'employer_id': instance.employerId,
      'name': instance.name,
      'address': instance.address,
      'place': instance.place,
      'post': instance.post,
      'pin': instance.pin,
      'gender_id': instance.genderId,
      'district_id': instance.districtId,
      'block_id': instance.blockId,
      'localbody_id': instance.localbodyId,
      'dob': instance.dob,
      'aadhaar': instance.aadhaar,
      'mobile': instance.mobile,
      'education_id': instance.educationId,
      'category': instance.category,
      'email': instance.email,
      'email_verified_at': instance.emailVerifiedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'token': instance.token,
      'error': instance.error,
      'mobile_verified': instance.mobileverified,
    };
