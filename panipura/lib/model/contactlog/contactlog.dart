import 'package:json_annotation/json_annotation.dart';

part 'contactlog.g.dart';

@JsonSerializable()
class Contactlog {
  @JsonKey(name: 'contact_time')
  String? contactTime;
  @JsonKey(name: 'employer_id')
  int? employerId;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'employer_mobile')
  String? empMob;
  @JsonKey(name: 'user_mobile')
  String? usrMob;

  Contactlog(
      {this.contactTime,
      this.employerId,
      this.userId,
      this.empMob,
      this.usrMob});

  factory Contactlog.fromJson(Map<String, dynamic> json) {
    return _$ContactlogFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ContactlogToJson(this);
}
