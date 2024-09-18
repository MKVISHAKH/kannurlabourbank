import 'package:json_annotation/json_annotation.dart';

part 'addskillreq.g.dart';

@JsonSerializable()
class Addskillreq {
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'occupation_id')
  int? occupationId;
  String? experience;
  String? wages;
  @JsonKey(name: 'w_period')
  String? wPeriod;
  @JsonKey(name: 'additional_info')
  String? additionalInfo;

  Addskillreq({
    this.userId,
    this.occupationId,
    this.experience,
    this.wages,
    this.wPeriod,
    this.additionalInfo,
  });

  Addskillreq.req({
    required this.userId,
    required this.occupationId,
    required this.experience,
    required this.wages,
    required this.wPeriod,
    this.additionalInfo,
  });

  factory Addskillreq.fromJson(Map<String, dynamic> json) {
    return _$AddskillreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddskillreqToJson(this);
}
