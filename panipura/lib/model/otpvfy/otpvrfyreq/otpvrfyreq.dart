import 'package:json_annotation/json_annotation.dart';

part 'otpvrfyreq.g.dart';

@JsonSerializable()
class Otpvrfyreq {
  String? mobile;
  String? otp;
  String? type;

  Otpvrfyreq({this.mobile, this.otp, this.type});
  Otpvrfyreq.req({required this.mobile, required this.otp, required this.type});

  factory Otpvrfyreq.fromJson(Map<String, dynamic> json) {
    return _$OtpvrfyreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OtpvrfyreqToJson(this);
}
