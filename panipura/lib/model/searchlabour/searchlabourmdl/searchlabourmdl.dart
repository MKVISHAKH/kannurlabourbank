import 'package:json_annotation/json_annotation.dart';

part 'searchlabourmdl.g.dart';

@JsonSerializable()
class Searchlabourmdl {
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'occupation_id')
  int? occupationId;
  @JsonKey(name: 'district_id')
  int? districtId;
  @JsonKey(name: 'lb_type_id')
  int? lbTypeId;
  @JsonKey(name: 'localbody_id')
  int? localbodyId;
  String? experience;
  @JsonKey(name: 'min_wage')
  String? minWage;
  @JsonKey(name: 'max_wage')
  String? maxWage;
  String? token;

  Searchlabourmdl({
    this.userId,
    this.occupationId,
    this.districtId,
    this.lbTypeId,
    this.localbodyId,
    this.experience,
    this.minWage,
    this.maxWage,
    this.token,
  });
  Searchlabourmdl.req({
    this.userId,
    this.occupationId,
    this.districtId,
    this.lbTypeId,
    this.localbodyId,
    this.experience,
    this.minWage,
    this.maxWage,
    this.token,
  });

  factory Searchlabourmdl.fromJson(Map<String, dynamic> json) {
    return _$SearchlabourmdlFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SearchlabourmdlToJson(this);
}
