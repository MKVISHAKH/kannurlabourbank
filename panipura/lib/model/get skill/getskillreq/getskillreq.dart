import 'package:json_annotation/json_annotation.dart';

part 'getskillreq.g.dart';

@JsonSerializable()
class Getskillreq {
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'locale')
  String? locale;

  Getskillreq({this.userId, this.token, this.locale});
  Getskillreq.req({required this.userId, this.token, this.locale});

  factory Getskillreq.fromJson(Map<String, dynamic> json) {
    return _$GetskillreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetskillreqToJson(this);
}
