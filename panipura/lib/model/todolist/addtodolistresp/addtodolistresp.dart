import 'package:json_annotation/json_annotation.dart';

part 'addtodolistresp.g.dart';

@JsonSerializable()
class Addtodolistresp {
  bool? success;
  List<dynamic>? data;
  String? message;

  Addtodolistresp({this.success, this.data, this.message});

  factory Addtodolistresp.fromJson(Map<String, dynamic> json) {
    return _$AddtodolistrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddtodolistrespToJson(this);
}
