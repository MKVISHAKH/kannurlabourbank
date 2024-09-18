import 'package:json_annotation/json_annotation.dart';

part 'deletereq.g.dart';

@JsonSerializable()
class Deletereq {
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'skill_id')
  int? skillId;

  Deletereq({this.userId, this.skillId});
  Deletereq.req({required this.userId, required this.skillId});

  factory Deletereq.fromJson(Map<String, dynamic> json) {
    return _$DeletereqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DeletereqToJson(this);
}
