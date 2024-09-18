import 'package:json_annotation/json_annotation.dart';

part 'loginreq.g.dart';

@JsonSerializable()
class Loginreq {
  String? mobile;
  String? password;

  Loginreq({this.mobile, this.password});
  Loginreq.create({required this.mobile, required this.password});

  factory Loginreq.fromJson(Map<String, dynamic> json) {
    return _$LoginreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginreqToJson(this);
}
