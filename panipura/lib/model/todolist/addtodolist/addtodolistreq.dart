import 'package:json_annotation/json_annotation.dart';

part 'addtodolistreq.g.dart';

@JsonSerializable()
class Addtodolist {
  @JsonKey(name: 'user_id')
  int? userId;
  String? title;
  String? description;
  @JsonKey(name: 'frm_dt')
  String? frmDt;
  @JsonKey(name: 'to_dt')
  String? toDt;
  @JsonKey(name: 'frm_time')
  String? frmTime;
  @JsonKey(name: 'to_time')
  String? toTime;
  @JsonKey(name: 'todolist_id')
  int? todolistId;
  Addtodolist(
      {this.userId,
      this.title,
      this.description,
      this.frmDt,
      this.toDt,
      this.frmTime,
      this.toTime,
      this.todolistId});
  Addtodolist.value(
      {this.userId,
      required this.title,
      required this.description,
      required this.frmDt,
      required this.toDt,
      required this.frmTime,
      required this.toTime,
      this.todolistId});

  factory Addtodolist.fromJson(Map<String, dynamic> json) {
    return _$AddtodolistFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddtodolistToJson(this);
}
