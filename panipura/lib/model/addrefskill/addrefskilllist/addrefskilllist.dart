import 'package:json_annotation/json_annotation.dart';

part 'addrefskilllist.g.dart';

@JsonSerializable()
class Addrefskilllist {
  @JsonKey(name: 'user_id')
  int? userId;
  String? name;
  String? mobile;

  Addrefskilllist({this.userId, this.name, this.mobile});
  Addrefskilllist.req({this.userId, this.name, this.mobile});

  factory Addrefskilllist.fromJson(Map<String, dynamic> json) {
    return _$AddrefskilllistFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddrefskilllistToJson(this);
}
