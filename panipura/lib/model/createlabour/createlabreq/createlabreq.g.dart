// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createlabreq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Createlabreq _$CreatelabreqFromJson(Map<String, dynamic> json) => Createlabreq(
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
      password: json['password'] as String?,
      cPassword: json['c_password'] as String?,
    );

Map<String, dynamic> _$CreatelabreqToJson(Createlabreq instance) =>
    <String, dynamic>{
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
      'password': instance.password,
      'c_password': instance.cPassword,
    };
