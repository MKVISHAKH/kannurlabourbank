import 'package:json_annotation/json_annotation.dart';

part 'otprsndreq.g.dart';

@JsonSerializable()
class Otprsndreq {
  String? mobile;
  String? type;

  Otprsndreq({this.mobile, this.type});
  Otprsndreq.req({required this.mobile, this.type});
  factory Otprsndreq.fromJson(Map<String, dynamic> json) {
    return _$OtprsndreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OtprsndreqToJson(this);
}
