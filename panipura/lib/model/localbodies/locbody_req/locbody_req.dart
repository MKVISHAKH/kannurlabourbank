import 'package:json_annotation/json_annotation.dart';

part 'locbody_req.g.dart';

@JsonSerializable()
class LocbodyReq {
  @JsonKey(name: 'district_id')
  int? districtId;
  @JsonKey(name: 'lb_type_id')
  int? lbTypeId;

  LocbodyReq({this.districtId, this.lbTypeId});

  factory LocbodyReq.fromJson(Map<String, dynamic> json) {
    return _$LocbodyReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LocbodyReqToJson(this);
}
