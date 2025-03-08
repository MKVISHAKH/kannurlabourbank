import 'package:json_annotation/json_annotation.dart';

part 'versionreq.g.dart';

@JsonSerializable()
class Versionreq {
  String? version;
  String? buildnumber;

  Versionreq({this.version, this.buildnumber});

  factory Versionreq.fromJson(Map<String, dynamic> json) {
    return _$VersionreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VersionreqToJson(this);
}
