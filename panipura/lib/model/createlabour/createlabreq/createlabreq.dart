import 'package:json_annotation/json_annotation.dart';

part 'createlabreq.g.dart';

@JsonSerializable()
class Createlabreq {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'place')
  String? place;
  @JsonKey(name: 'post')
  String? post;
  @JsonKey(name: 'pin')
  String? pin;
  @JsonKey(name: 'gender_id')
  int? genderId;
  @JsonKey(name: 'district_id')
  int? districtId;
  @JsonKey(name: 'block_id')
  int? blockId;
  @JsonKey(name: 'localbody_id')
  int? localbodyId;
  @JsonKey(name: 'dob')
  String? dob;
  @JsonKey(name: 'aadhaar')
  String? aadhaar;
  @JsonKey(name: 'mobile')
  String? mobile;
  @JsonKey(name: 'education_id')
  int? educationId;
  @JsonKey(name: 'category')
  int? category;
  @JsonKey(name: 'password')
  String? password;
  @JsonKey(name: 'c_password')
  String? cPassword;

  Createlabreq({
    this.name,
    this.address,
    this.place,
    this.post,
    this.pin,
    this.genderId,
    this.districtId,
    this.blockId,
    this.localbodyId,
    this.dob,
    this.aadhaar,
    this.mobile,
    this.educationId,
    this.category,
    this.password,
    this.cPassword,
  });
  Createlabreq.req({
    required this.name,
    required this.address,
    required this.place,
    required this.post,
    required this.pin,
    required this.genderId,
    required this.districtId,
    required this.blockId,
    required this.localbodyId,
    required this.dob,
    this.aadhaar,
    required this.mobile,
    this.educationId,
    required this.category,
    required this.password,
    required this.cPassword,
  });
  factory Createlabreq.fromJson(Map<String, dynamic> json) {
    return _$CreatelabreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreatelabreqToJson(this);
}
