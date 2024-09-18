import 'package:json_annotation/json_annotation.dart';

part 'edithmtwnresp.g.dart';

@JsonSerializable()
class Edithmtwnresp {
  bool? success;
  String? message;
  String? place;

  Edithmtwnresp({this.success, this.message, this.place});

  factory Edithmtwnresp.fromJson(Map<String, dynamic> json) {
    return _$EdithmtwnrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EdithmtwnrespToJson(this);
}
