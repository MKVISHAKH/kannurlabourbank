import 'package:json_annotation/json_annotation.dart';

part 'gettodolist.g.dart';

@JsonSerializable()
class Gettodolist {
  @JsonKey(name: 'todolist_id')
  int? todolistId;
  String? title;
  String? description;
  @JsonKey(name: 'frm_dt')
  String? frmDt;
  @JsonKey(name: 'to_dt')
  String? toDt;
  @JsonKey(name: 'start_time')
  String? startTime;
  @JsonKey(name: 'end_time')
  String? endTime;

  Gettodolist({
    this.todolistId,
    this.title,
    this.description,
    this.frmDt,
    this.toDt,
    this.startTime,
    this.endTime,
  });

  factory Gettodolist.fromJson(Map<String, dynamic> json) {
    return _$GettodolistFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GettodolistToJson(this);
}
