import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'employer_id')
  int? empId;
  String? token;
  String? name;
  String? mobile;

  Data({this.userId, this.empId, this.token, this.name, this.mobile});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
