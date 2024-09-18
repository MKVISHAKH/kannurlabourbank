import 'package:json_annotation/json_annotation.dart';

part 'upldimgresp.g.dart';

@JsonSerializable()
class Upldimgresp {
  bool? success;
  String? message;

  Upldimgresp({this.success, this.message});

  factory Upldimgresp.fromJson(Map<String, dynamic> json) {
    return _$UpldimgrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpldimgrespToJson(this);
}
