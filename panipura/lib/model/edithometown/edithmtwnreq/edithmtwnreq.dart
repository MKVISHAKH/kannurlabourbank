import 'package:json_annotation/json_annotation.dart';

part 'edithmtwnreq.g.dart';

@JsonSerializable()
class Edithmtwnreq {
  @JsonKey(name: 'user_id')
  int? userId;
  String? place;
  String? token;

  Edithmtwnreq({this.userId, this.place, String? token});
  Edithmtwnreq.req(
      {required this.userId, required this.place, required this.token});

  factory Edithmtwnreq.fromJson(Map<String, dynamic> json) {
    return _$EdithmtwnreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EdithmtwnreqToJson(this);
}
