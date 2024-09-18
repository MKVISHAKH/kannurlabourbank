import 'package:json_annotation/json_annotation.dart';

part 'deletetodoreq.g.dart';

@JsonSerializable()
class Deletetodoreq {
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'todolist_id')
  int? todolistId;

  Deletetodoreq({this.userId, this.todolistId});

  factory Deletetodoreq.fromJson(Map<String, dynamic> json) {
    return _$DeletetodoreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DeletetodoreqToJson(this);
}
