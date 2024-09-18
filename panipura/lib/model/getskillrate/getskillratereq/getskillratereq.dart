import 'package:json_annotation/json_annotation.dart';

part 'getskillratereq.g.dart';

@JsonSerializable()
class Getskillratereq {
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'skill_id')
  int? skillId;

  Getskillratereq({this.userId, this.skillId});
  Getskillratereq.req({required this.userId, required this.skillId});

  factory Getskillratereq.fromJson(Map<String, dynamic> json) {
    return _$GetskillratereqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetskillratereqToJson(this);
}
