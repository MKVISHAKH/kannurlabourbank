import 'package:json_annotation/json_annotation.dart';

part 'rstpswrdvrfy.g.dart';

@JsonSerializable()
class Rstpswrdvrfy {
  String? password;
  String? otp;

  Rstpswrdvrfy({this.password, this.otp});
  Rstpswrdvrfy.req({required this.password, required this.otp});

  factory Rstpswrdvrfy.fromJson(Map<String, dynamic> json) {
    return _$RstpswrdvrfyFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RstpswrdvrfyToJson(this);
}
